Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312747AbSCVQVK>; Fri, 22 Mar 2002 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312748AbSCVQVA>; Fri, 22 Mar 2002 11:21:00 -0500
Received: from www.stpibonline.soft.net ([164.164.128.17]:31435 "EHLO
	cyclops.soft.net") by vger.kernel.org with ESMTP id <S312747AbSCVQUp>;
	Fri, 22 Mar 2002 11:20:45 -0500
Message-ID: <91A7E7FABAF3D511824900B0D0F95D10136FA4@BHISHMA>
From: Abdij Bhat <Abdij.Bhat@kshema.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel Upgrade Hangs!
Date: Fri, 22 Mar 2002 21:41:46 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am trying to build the 2.4.17 Kernel and upgrade my existing 2.4.7-10 Red
Hat Linux System. Here is the procedure I followed ( based on Red Hat
Documentation on the same ):

1. tar -xvzf linux-2.4.17.tar.gz
2. cd linux
3. make mkproper
4. make menuconfig
5.make dep 
6. make clean 
7. make bzImage 
8. make modules 
9. make modules_install 
10. cp /usr/src/linux-2.4.17/arch/i386/boot/bzImage /boot/vmlinuz-2.4.17 
11. cp /usr/src/linux-2.4.17/System.map /boot/System.map-2.4.17 
12. cd /boot rm System.map ln -s System.map-2.4.17 System.map 
13. mkinitrd /boot/initrd-2.4.17.img 2.4.17 
14. Modify the /etc/lilo.conf to add
		image=/boot/vmlinuz-2.4.17
		label=linux-Mine
		root=/dev/hda1
		initrd=/boot/initrd-2.4.17
		read-only

 Now when i reboot and select the linux-Mine option the screen displays
		Loading vmlinuz-2.4.7
		Uncompressing Linux... Ok, booting the kernel

 and then HANGS!!!!!!

 What might be the problem. I have followed the instruction to the T. I
tried without the initrd option too. I have enabled the RAM diak
option/disabled it....
 
 Please help me out on the issue.

Thanks and Regards,
Abdij
