# first-one-
for fun 
# ###############################
# Part 1: Create a new Heroku app
# ###############################

# Give your app a unique name
APP_NAME="my-secret-app" 

# Create your project in a new repo
# This example uses React but you can use whatever you like
npx create-react-app $APP_NAME

# Enter the repo
cd $APP_NAME

# Create a new Heroku app for your project
# Include the appropriate buildpack for your framework
heroku create $APP_NAME --buildpack mars/create-react-app

# Deploy your app to Heroku
git push heroku master

# Now you can view your project online with `heroku open`

# ####################################
# Part 2: Install heroku-buildpack-tor
# ####################################

# Add heroku-buildpack-tor
heroku buildpacks:add jtschoonhoven/heroku-buildpack-tor

# Create a Procfile for that starts Tor when the app starts
# If you're not using React, replace `bin/boot` with your start command
START_SERVER_COMMAND="./tor/bin/run_tor & bin/boot"
echo "tor: $START_SERVER_COMMAND" > Procfile

# Commit and deploy to Heroku
git add .
git commit -m "run app as Tor hidden service"
git push heroku master

# #################################
# Part 3: Access the Hidden Service
# #################################

# Start the `tor` worker defined in the Procfile
heroku ps:scale tor=1

# Retrieve the .onion address for your app from the dyno
heroku ps:exec --dyno=tor.1 'cat "/app/hidden_service/hostname"'

# Plop the .onion address into Tor Browser to confirm
# Happy hacking!
