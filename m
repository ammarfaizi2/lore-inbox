Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290851AbSBFWZg>; Wed, 6 Feb 2002 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290850AbSBFWZR>; Wed, 6 Feb 2002 17:25:17 -0500
Received: from gold.he.net ([216.218.149.2]:6672 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S290849AbSBFWZL>;
	Wed, 6 Feb 2002 17:25:11 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.S." <jss@pacbell.net>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel reboot problem
Date: Wed, 20 Feb 2002 14:27:49 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNEEELCAAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What in the world am I doing wrong?
Whenever I try and compile a kernel, my computer reboots after the message:

Loading Linux.......................

Here's what I do, tell me if it's wrong:

-Download kernel into home dir
-Unpack
-Rename and make symbolic link "linux"
-cd linux
-make mrproper
-make menuconfig
-make dep && make clean && make bzImage && make modules && make
modules_install
-cp bzImage to /boot/vmlinuz-2.4.17
-cp System.map /boot/System.map-2.4.17
-cd /boot
-create symbolic link to System.map -> System.map-2.4.17
-edit lilo.conf:

===========================
prompt
timeout=50
default=linux
boot=/dev/hda
map=boot/map
install=/boot/boot.b
message=/boot/message
lba32

image=/boot/vmlinuz-2.4.7-10
	label=linux
	initrd=/boot/initrd-2.4.7-10.img
	read-only
	root=/dev/hda5

#Add this part for new kernel
image=/boot/vmlinuz-2.4.17
	label=Linux-2.4.17
	read-only
	root=/dev/hda5
===========================
-Run /sbin/lilo

Lilo installs fine without any complaints and EVERYTIME I reboot
and choose the new kernel the computer reboots after the "Loading
Linux..................."
message. It never gets to the "Uncompressing" part of the boot message.
It's obviously got to
be something i'm doing wrong.  If redhat and slackware can get their kernels
to load, then there's no reason
I shouldn't be able to do my own.  Here's my setup:

Pentium 233
Intel Chipset
192 megs RAM
Maxtor 10g ATA/66

Some help would be much, much appreciated.  I've followed all the examples
and tried this dozens of times with no success to date.  I've downloaded
2.4.16 and it did the same thing.  I've tried putting the source and
unpacking it in the /usr/src directory. I've tried using initrd and
modifying lilo to reflect it.  The kernel ALWAYS compiles without any error
codes at the end and none of this seems to matter because in the end it just
reboots and reboots, etc...

