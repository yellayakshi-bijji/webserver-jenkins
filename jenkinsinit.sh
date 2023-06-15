#! /bin/bash

set -e

echo "Updating packages..."
sudo yum update -y

echo "Installing Java..."
sudo yum -y install java-17-amazon-corretto-devel

echo "Importing the Jenkins Repository key.."
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

echo "Adding the Jenkins Repository to the package manager's configuration.."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

echo "Enabling the Jenkins repository by editing the repository configuration file.."
sudo sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/jenkins.repo

echo "Updating package managers configuration"
sudo yum update -y

echo "Installing Jenkins.."
sudo yum install jenkins -y

echo "Starting the Jenkins service.."
sudo systemctl start jenkins

echo "Enabling Jenkins to start on system boot.."
sudo systemctl enable jenkins

echo "Cloud-init log:"
cat /var/log/cloud-init-output.log
# Save the contents of the log file to a local file
cat /var/log/cloud-init-output.log > ~/cloud-init-log.txt
echo "User data script execution completed."