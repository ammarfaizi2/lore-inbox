Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271514AbRINXP6>; Fri, 14 Sep 2001 19:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRINXPj>; Fri, 14 Sep 2001 19:15:39 -0400
Received: from smtp1.chicago.il.ameritech.net ([206.141.192.26]:26332 "EHLO
	smtp.ameritech.net") by vger.kernel.org with ESMTP
	id <S271514AbRINXPd>; Fri, 14 Sep 2001 19:15:33 -0400
Date: Fri, 14 Sep 2001 19:18:36 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: repeated nfs mounts..
Message-ID: <Pine.LNX.4.20.0109141912020.10398-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Weird thing: I can repeatedly mount nfs filesystem over the same mount
point.. Anyone has an explanation ? I am running 2.4.9.

                        Vladimir Dergachev

inspire:/home/volodya# mount 
/dev/hda2 on / type ext2 (rw) 
/dev/hda7 on /u type ext2 (rw) 
/dev/hda1 on /c type vfat (rw) 
/dev/hdc on /cdrom type iso9660 (ro,nosuid,nodev) 
none on /proc type proc (rw) 
none on /dev/pts type devpts (rw,gid=5,mode=620) 
none on /devfs type devfs (rw) 
none on /proc/bus/usb type usbdevfs (rw) 
inspire:/home/volodya# mount /
mount: /dev/hda2 already mounted or / busy 
mount: according to mtab, /dev/hda2 is already mounted on / 
inspire:/home/volodya# mount /nfs/storage/ 
inspire:/home/volodya# mount /nfs/storage/
inspire:/home/volodya# mount /nfs/storage/ 
inspire:/home/volodya# mount /nfs/storage/ 
inspire:/home/volodya# ls /nfs/storage/ 
samba  u
inspire:/home/volodya# mount 
/dev/hda2 on / type ext2 (rw) 
/dev/hda7 on /u type ext2 (rw) 
/dev/hda1 on /c type vfat (rw) 
/dev/hdc on /cdrom type iso9660 (ro,nosuid,nodev) 
none on /proc type proc (rw) 
none on /dev/pts type devpts (rw,gid=5,mode=620) 
none on /devfs type devfs (rw) 
none on /proc/bus/usb type usbdevfs (rw) 
node4:/storage/ on /nfs/storage type nfs (rw,nosuid,nodev,addr=192.168.0.4,addr=192.168.0.4) 
node4:/storage/ on /nfs/storage type nfs (rw,nosuid,nodev,addr=192.168.0.4,addr=192.168.0.4) 
node4:/storage/ on /nfs/storage type nfs (rw,nosuid,nodev,addr=192.168.0.4,addr=192.168.0.4) 
node4:/storage/ on /nfs/storage type nfs (rw,nosuid,nodev,addr=192.168.0.4,addr=192.168.0.4) 
inspire:/home/volodya# umount /nfs/storage/ 
inspire:/home/volodya# ls /nfs/storage/ 
samba  u
inspire:/home/volodya# 
inspire:/home/volodya# umount /nfs/storage/
inspire:/home/volodya# ls /nfs/storage/
samba  u
inspire:/home/volodya# umount /nfs/storage/
inspire:/home/volodya# ls /nfs/storage/
samba  u
inspire:/home/volodya# umount /nfs/storage/
inspire:/home/volodya# ls /nfs/storage/
inspire:/home/volodya#



