Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313676AbSDZGVx>; Fri, 26 Apr 2002 02:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313677AbSDZGVw>; Fri, 26 Apr 2002 02:21:52 -0400
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:128 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S313676AbSDZGVw>; Fri, 26 Apr 2002 02:21:52 -0400
Message-Id: <200204261520.g3QFKbQ00938@karpfen.mathe.tu-freiberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: 2.4.19-pre7: rootfs mounted twice
Date: Fri, 26 Apr 2002 17:20:36 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on 2.4.18 I get the following:

dreher@karpfen:~ > uname -a
Linux karpfen 2.4.18 #2 Sun Apr 21 23:27:03 CEST 2002 i586 unknown

dreher@karpfen:~ > df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root              7060308   6276080    425580  94% /
/dev/hda4              3794936   3043812    558344  84% /home

dreher@karpfen:~ > cat /proc/mounts
/dev/root / ext3 rw,noatime,nodiratime 0 0
proc /proc proc rw 0 0
/dev/hda4 /home ext3 rw,noatime,nodiratime 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
devpts /dev/pts devpts rw 0 0


On the other hand, 2.4.19-pre7 gives:

dreher@karpfen:~ > uname -a
Linux karpfen 2.4.19-pre7 #6 Sun Apr 21 20:27:47 CEST 2002 i586 unknown

dreher@karpfen:~ > df
Filesystem           1k-blocks      Used Available Use% Mounted on
rootfs                 7060308   6276188    425472  94% /
/dev/root              7060308   6276188    425472  94% /
/dev/hda4              3794936   3042316    559840  84% /home

dreher@karpfen:~ > cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw,noatime,nodiratime 0 0
proc /proc proc rw 0 0
/dev/hda4 /home ext3 rw,noatime,nodiratime 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
devpts /dev/pts devpts rw 0 0


I don't know if it is related, but in my bootscripts I link
/etc/mtab to /proc/mounts.


Regards,
Michael
