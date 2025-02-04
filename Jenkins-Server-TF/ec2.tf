resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t2.2xlarge"
  key_name               = var.key-name
  subnet_id              = var.private-subnet-id # Use existing private subnet
  vpc_security_group_ids = [var.security-group-id] # Use existing security group
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  associate_public_ip_address = false # Ensure no public IP is assigned

  root_block_device {
    volume_size = 30
  }

  user_data = templatefile("./tools-install.sh", {})

  tags = {
    Name = var.instance-name
  }
}
