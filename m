Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbTAAEPt>; Tue, 31 Dec 2002 23:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTAAEPt>; Tue, 31 Dec 2002 23:15:49 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:51584 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S266797AbTAAEPs>; Tue, 31 Dec 2002 23:15:48 -0500
Date: Tue, 31 Dec 2002 23:24:07 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: USB-storage and CF reader oddness
Message-ID: <20030101042407.GA1391@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel 2.5.52 & 53

ASUS P4S533 (SiS645DX chipset)
P4 2GHz
1G PC2700 RAM
SanDisk SDDR-77 ImageMate CF reader

First - I really have no clue how to use this device in linux.

scsi, scsi disk, scsi CD and scsi generic builtin.
USB and OHCI-HCD builtin (required for ps/2 mouse - no idea why)
USB-storage as a module with all devices selected.

insert a card, modprobe usb-storage.
lsmod shows usb-storage with 0 usage
ls /dev shows sda and sda1
mount returns "no media found"
remove card, modprobe -r usb-storage
get "kernel cannot handle paging request" from process drakupdate-fsta
lsmod shows nothing
ls /dev shows no sda or sda1
insert card, modprobe usb-storage
lsmod shows usb-storage with usage 0
ls /dev shows sda and sda1
mount spews hundreds of lines of debug messages, but appears to mount the card.
ls /mnt/disk shows the contents of the card
umount hangs
lsmod in another term hangs
ls /dev hangs
rmmod -f usb-storage unloads usb-storage
ls /dev doesn't hang (except the one that was already hung)
lsmod hangs
modprobe usb-storage hangs

I guess at this point I've totally mangled things and reboot.
These steps always work the same way.

I can also cause modprobe and lsmod to hang by doing 
modprobe usb-storage
rmmod usb-storage
a few times

Any hints on what I should be REALLY doing to be able to read more than
one card per boot?
hotplug doesn't work at all - Mandrake's initscripts only work if everything
is a module.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

