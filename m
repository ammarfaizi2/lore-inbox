Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUANJP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUANJOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:14:53 -0500
Received: from [151.99.250.84] ([151.99.250.84]:4350 "EHLO
	ciliegio.cs.interbusiness.it") by vger.kernel.org with ESMTP
	id S265439AbUANJNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:13:43 -0500
From: "Andrea Pusceddu" <a.pusceddu@remosa-valves.com>
Organization: Remosa SpA | www.remosa-valves.com
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2004 10:13:20 +0100
MIME-Version: 1.0
Subject: [USB-STORAGE] Repeatable lost files problem
Reply-to: a.pusceddu@remosa-valves.com
Message-ID: <40051640.20530.684C08@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a weird repeateable problem using a mp3 player (Medion PRO2 256 MB) 
seen under linux as a usb mass storage, through usb-storage module.

Device: MP3 Player and USB storage device (256MB)

vendor ID 0x66f (Sigmatel Inc)
chipset ID :  0x8000 

It is reported to work correctly with usb-storage on 
http://www.qbik.ch/usb/devices/index.php

relevant modules: usb-storage, usb-ohci
Debian Woody (stable) with default kernel 2.4.18bf
hotplug or usbmgr (same problem with both)

This is how to reproduce the trouble:
1) plug in the device 
2) mount -t auto  /dev/sda  /mnt/usbdrive
3) cp ./filecopiedfromlinux.foo  /mnt/usbdrive
4) ls /mnt/usbdrive :
	filecopiedfromwindows.foo
	filecopiedfromlinux.foo
5) umount /mnt/usbdrive
6) unplug physically the device, i.e. disconnect it from usb port
7) from the Player LCD display i can actually see both files, and I can 
even listen to them, if they are MP3 audio files. So the files ARE in the 
usb drive! I do swear it :)

But if now the weirdness comes up: if  I do as follows:

8) plug in the device again
9) mount again as in step 2)
10) ls /mnt/usbdrive :
	filecopiedfromwindows.foo

The file copied from Linux has been deleted! What's weird, IMHO, is that 
ONLY the file(s) copied from Linux are lost, regardless of file content and 
size. File(s) copied by means of windows are not "volatile" , i.e. they 
persist between the sessions! Astonishing, isn't it?

Some additional info:
a) If I skip step 6), thus I don't  disconnect physically the device, then 
the problem disappears.
b) If I perform steps the corresponding of steps 8, 9, 10 using windows, 
the filecopiedfromlinux are lost as well.
I think there's something wrong with the chipset, even if its reported as 
working.
c) I can read and copy and use all files in the usb drive, without any 
problems. If don't remove the usb player, I don't experience any 
corruption.
d) My Linux Box is rather old (AMD K6-II 400 MHz, 512 MB Ram), but it works 
well and is stable. 
e) Sometimes it's possible to recover files using some undelete utility.

I can post dmesg output if this can help, or give you any other information 
you may need to focus the problem.

Sorry for the very long message, but I wanted to be as more precise as i 
can. 
Thank you for the time you all spend in developing Linux kernel,  I think 
that our poor world is a bit better also because of you. 

-- 
Call me Ishmael

