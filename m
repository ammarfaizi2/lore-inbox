Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSHXSVH>; Sat, 24 Aug 2002 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHXSVH>; Sat, 24 Aug 2002 14:21:07 -0400
Received: from 24-148-63-229.na.21stcentury.net ([24.148.63.229]:59182 "HELO
	wotke.danapple.com") by vger.kernel.org with SMTP
	id <S316595AbSHXSVG>; Sat, 24 Aug 2002 14:21:06 -0400
To: linux-kernel@vger.kernel.org
Cc: "Daniel I. Applebaum" <kernel@danapple.com>
Subject: 2.5.31 build failure & booting problems
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Sat, 24 Aug 2002 13:25:10 -0500
Message-Id: <20020824182515.3FE3F10B7A@wotke.danapple.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I changed to gcc 2.95.3, and that tradcpp0 error disappeared.
However, when building the ATA stuff as modules, I got some unresolved
symbols during depmod -a.  Compiling the ATA stuff integral to the
kernel eliminating those issues.  Sorry I didn't record the error
messages.  This is all relevant to 2.5.31.

Neither 2.5.31 nor 2.4.19 will boot on my machine.  So I seem to be
stalled at 2.4.13.  Do I need a new version of LILO?  I'm currently at 
LILO version 21.4-4

(For those new to this thread, my LILO will show Loading
linux-2.4.19.................. and then the machine will immediately
reboot.  Same for linux-2.5.31.)

My kernels ls -l as:
-rw-rw-r--    1 root     root       886157 Aug 24 10:36 vmlinuz-2.4.19
-rw-rw-r--    1 root     root       897454 Aug 24 11:40 vmlinuz-2.5.31

Are they too big?

This is how I build the kernel:

make clean
make menuconfig
make clean dep bzImage
make modules
make modules_install
cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.19
cd /boot
mkinitrd -f initrd-2.4.19.img 2.4.19
lilo
reboot

Any suggestions?  I'm totally baffled.

Which is the very first routine in the kernel to be run?  I'd like to
insert some kind of print statement, if possible, to see if it is even
getting called by LILO.

Dan.
