Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUGJN6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUGJN6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUGJN6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 09:58:16 -0400
Received: from [213.188.213.77] ([213.188.213.77]:54933 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S266249AbUGJN6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 09:58:13 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: <viro@parcelfarce.linux.theplanet.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: FW: Mount -o bind strange behaviour
Date: Sat, 10 Jul 2004 16:00:10 +0200
Message-ID: <006801c46686$375f74b0$e60a0a0a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: viro@www.linux.org.uk [mailto:viro@www.linux.org.uk] On
> Behalf Of viro@parcelfarce.linux.theplanet.co.uk
> Sent: Saturday, July 10, 2004 3:50 PM
> To: Massimo Cetra
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Mount -o bind strange behaviour
> 
> No way to tell without at least the contents of your
> /proc/mounts before and after...

This is the output at the moment.

gremo1:~# mount
/dev/md3 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/md1 on /boot type ext3 (rw)
/dev/md5 on /usr/local type ext3 (rw)
/dev/md6 on /home type ext3 (rw)
/dev/md7 on /var type ext3 (rw)
proc on /var/chroot/apache/proc type proc (rw)
/home/www on /var/chroot/apache/home/www type none (rw,bind)
/var/log/www on /var/chroot/apache/var/log/www type none (rw,bind)
/usr/local/lib/php on /var/chroot/apache/usr/local/lib/php type none
(rw,bind) /var/www on /var/chroot/apache/var/www type none (rw,bind)
/usr/lib/locale on /var/chroot/apache/usr/lib/locale type none (rw,bind)
/usr/local/apache/conf on /var/chroot/apache/usr/local/apache/conf type
none (ro,bind) gremo1:~#


gremo1:~# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/md1 /boot ext3 rw 0 0
/dev/md5 /usr/local ext3 rw 0 0
/dev/md6 /home ext3 rw 0 0
/dev/md7 /var ext3 rw 0 0
proc /var/chroot/apache/proc proc rw 0 0
/dev/md6 /var/chroot/apache/home/www ext3 rw 0 0
/dev/md7 /var/chroot/apache/var/log/www ext3 rw 0 0
/dev/md5 /var/chroot/apache/usr/local/lib/php ext3 rw 0 0 /dev/md7
/var/chroot/apache/var/www ext3 rw 0 0 /dev/root
/var/chroot/apache/usr/lib/locale ext3 rw 0 0 /dev/md5
/var/chroot/apache/usr/local/apache/conf ext3 rw 0 0 gremo1:~#


No way to provide cat /proc/mount content of /proc/mount before. Mount
had the same output and everything seemed to be normal.

This was the mountpoint with the problem. /usr/local/apache/conf on
/var/chroot/apache/usr/local/apache/conf type none (ro,bind)


Regards, 
 Max

