Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCBVKt>; Fri, 2 Mar 2001 16:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCBVKj>; Fri, 2 Mar 2001 16:10:39 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:49929 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S129498AbRCBVKd>; Fri, 2 Mar 2001 16:10:33 -0500
Date: Fri, 2 Mar 2001 16:10:47 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: usbdevfs can be mounted multiple times
Message-ID: <Pine.LNX.4.33.0103021605570.22765-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I understand that root can do many strange and unsafe things, but mounting
the same filesystem many times is not allowed for systems other than
usbdevfs.

[root@fonzie proski]# mount
/dev/ide/host0/bus0/target0/lun0/part1 on / type reiserfs (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc/bus/usb type usbdevfs (rw)
[root@fonzie proski]# mount /proc/bus/usb
[root@fonzie proski]# mount /proc/bus/usb
[root@fonzie proski]# mount /proc/bus/usb
[root@fonzie proski]# mount /proc/bus/usb
[root@fonzie proski]# mount
/dev/ide/host0/bus0/target0/lun0/part1 on / type reiserfs (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc/bus/usb type usbdevfs (rw)
none on /proc/bus/usb type usbdevfs (rw)
none on /proc/bus/usb type usbdevfs (rw)
none on /proc/bus/usb type usbdevfs (rw)
none on /proc/bus/usb type usbdevfs (rw)
[root@fonzie proski]# mount /dev/pts
mount: none already mounted or /dev/pts busy
mount: according to mtab, none is already mounted on /dev/pts
[root@fonzie proski]# mount --version
mount: mount-2.10p
[root@fonzie proski]# uname -a
Linux fonzie 2.4.2-ac8 #3 Fri Mar 2 12:59:44 EST 2001 i686 unknown
[root@fonzie proski]#

Regards,
Pavel Roskin

