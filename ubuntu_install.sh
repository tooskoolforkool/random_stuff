#!/bin/sh
cd ~
sudo apt-get update
sudo apt-get install vim terminator curl gparted -y
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py

# ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full -y
sudo rosdep init
rosdep update
rossource="source /opt/ros/kinetic/setup.bash"
if grep -Fxq "$rossource" ~/.bashrc; then echo ROS setup.bash is already in .bashrc; else echo "$rossource" >> ~/.bashrc; fi 
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools -y

# PX4 Firmware
curl https://raw.githubusercontent.com/PX4/Devguide/master/build_scripts/ubuntu_sim_common_deps.sh -o common_deps.sh
chmod +x common_deps.sh
. ./common_deps.sh

sudo apt-get install protobuf-compiler libeigen3-dev libopencv-dev -y

cd ~/src/Firmware
git checkout v1.7.3

# MavROS
sudo apt-get install ros-kinetic-mavros ros-kinetic-mavros-extras -y

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh

sudo pip install pymap3d
sudo pip install lap

# Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y

# etcher
echo "deb https://dl.bintray.com/resin-io/debian stable etcher" | sudo tee /etc/apt/sources.list.d/etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo apt-get update
sudo apt-get install etcher-electron -y

# Install QGroundControl AppImage to Desktop
cd ~/Desktop
wget https://s3-us-west-2.amazonaws.com/qgroundcontrol/latest/QGroundControl.AppImage
chmod +x ./QGroundControl.AppImage
sudo usermod -a -G dialout $USER
sudo apt-get remove modemmanager


