Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTEXIkD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 04:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEXIkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 04:40:02 -0400
Received: from pc2-alde1-3-cust225.glfd.cable.ntl.com ([213.107.78.225]:30813
	"EHLO mayday.local") by vger.kernel.org with ESMTP id S264226AbTEXIj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 04:39:58 -0400
Date: Sat, 24 May 2003 09:52:00 +0100 (BST)
To: <linux-kernel@vger.kernel.org>
Subject: [OT] I love Linux!
X-URL: <http://www.cix.co.uk/~mayday>
X-Dev86-Version: 0.16.11
Reply-By: 01 jan 2001 00:00:00
X-Message-Flag: Linux: The choice of a GNU generation.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Robert de Bath <robert$@mayday.cix.co.uk>
Message-ID: <acbcfe360cc41d35@mayday.cix.co.uk>
X-Mailer: Pine for Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought you might be interested in this scrollback log, the complete
one is approx 17000 lines; I've no idea what caused the original problem;
hopefully something like a cosmic ray hitting a scsi transceiver.

> W1(robert)/$ ls -l  /disk/sda4
> total 184881842
> drwxr-xr-x    4 root     root         1024 May 11 18:44 boot
> dr--rwSrwT  15848 2962804722 2850042371 995903248 Jan 20  1959 lost+found
> W1(robert)/$ sudo umount /disk/sda4

> W1(robert)/$ sudo e2fsck /dev/sda4
> e2fsck 1.27 (8-Mar-2002)
> Group descriptors look bad... trying backup blocks...
> Superblock has a bad ext3 journal (inode 8).
> Clear<y>? yes

Hmmm.

>
> *** ext3 journal has been deleted - filesystem is now ext2 only ***
>
> /dev/sda4 was not cleanly unmounted, check forced.
> e2fsck: Illegal triply indirect block found while reading bad blocks inode
> This doesn't bode well, but we'll try to go on...
> Pass 1: Checking inodes, blocks, and sizes
> Bad block inode has illegal block(s).  Clear<y>? yes

OMG!

>
> Illegal block #0 (1431276975) in bad block inode.  CLEARED.
> Illegal block #1 (673818087) in bad block inode.  CLEARED.
> Illegal block #2 (707372471) in bad block inode.  CLEARED.
> Illegal block #3 (608784174) in bad block inode.  CLEARED.
> Illegal block #4 (2312398709) in bad block inode.  CLEARED.
> Illegal block #5 (1548877642) in bad block inode.  CLEARED.
> Illegal block #6 (1635558748) in bad block inode.  CLEARED.
> Illegal block #7 (698739426) in bad block inode.  CLEARED.
> Illegal block #8 (1244206925) in bad block inode.  CLEARED.
> Illegal block #9 (3562494532) in bad block inode.  CLEARED.
> Illegal block #10 (1391372882) in bad block inode.  CLEARED.
> Illegal block #11 (1253673108) in bad block inode.  CLEARED.
> Illegal block #-1 (252663295) in bad block inode.  CLEARED.
> Illegal block #-2 (575818347) in bad block inode.  CLEARED.
> Illegal block #-3 (2336762341) in bad block inode.  CLEARED.
> Reserved inode 4 <The ACL data inode> has bad mode.  Clear<y>? yes
>
> Reserved inode 6 <The undelete directory inode> has bad mode.  Clear<y>?
> yes

Wimper wimper

> Illegal block #4 (704842913) in inode 1951.  CLEARED.
> Illegal block #5 (2746145280) in inode 1951.  CLEARED.
> Illegal block #6 (1448955905) in inode 1951.  CLEARED.
> Illegal block #8 (3877244673) in inode 1951.  CLEARED.
> Illegal block #9 (3309966792) in inode 1951.  CLEARED.
> Illegal block #10 (1437152980) in inode 1951.  CLEARED.
> Illegal block #11 (1498273102) in inode 1951.  CLEARED.
> Too many illegal blocks in inode 1951.
> Clear inode? yes
>
> Restarting e2fsck from the beginning...
> /dev/sda4 was not cleanly unmounted, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> i_faddr for inode 2 (/) is 2184181835, should be zero.
> Clear? yes
>
> i_frag for inode 2 (/) is 72, should be zero.
> Clear? yes
>
> i_fsize for inode 2 (/) is 46, should be zero.
> Clear? yes
>
> Entry 'lost+found' in / (2) has deleted/unused inode 11.  Clear? yes
>
> Pass 3: Checking directory connectivity
> /lost+found not found.  Create? yes
>
> Pass 4: Checking reference counts
> Inode 2 ref count is 5, should be 4.  Fix? yes
>
> Inode 12 (...) has a bad mode (056231).
> Clear? yes
>
> Inode 13 (...) has a bad mode (075610).
> Clear? yes

Inode 2! Inode 12! Oh well there goes the data.

> Illegal block #4 (704842913) in inode 1951.  CLEARED.
> Illegal block #5 (2746145280) in inode 1951.  CLEARED.
> Illegal block #6 (1448955905) in inode 1951.  CLEARED.
> Illegal block #8 (3877244673) in inode 1951.  CLEARED.
> Illegal block #9 (3309966792) in inode 1951.  CLEARED.
> Illegal block #10 (1437152980) in inode 1951.  CLEARED.
> Illegal block #11 (1498273102) in inode 1951.  CLEARED.
> Too many illegal blocks in inode 1951.
> Clear inode? yes
>
> Restarting e2fsck from the beginning...
> /dev/sda4 was not cleanly unmounted, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> i_faddr for inode 2 (/) is 2184181835, should be zero.
> Clear? yes
>
> i_frag for inode 2 (/) is 72, should be zero.
> Clear? yes
>
> i_fsize for inode 2 (/) is 46, should be zero.
> Clear? yes
>
> Entry 'lost+found' in / (2) has deleted/unused inode 11.  Clear? yes
>
> Pass 3: Checking directory connectivity
> /lost+found not found.  Create? yes
>
> Pass 4: Checking reference counts
> Inode 2 ref count is 5, should be 4.  Fix? yes
>
> Inode 12 (...) has a bad mode (056231).
> Clear? yes
>
> Inode 13 (...) has a bad mode (075610).
> Clear? yet

Cringe!

...
17000 lines from the top.
> /dev/sda4: ***** FILE SYSTEM WAS MODIFIED *****

No shit!

> /dev/sda4: 58/10040 files (12.1% non-contiguous), 15670/40131 blocks
> W1(robert)/$ sudo e2fsck -y -f /dev/sda4
> e2fsck 1.27 (8-Mar-2002)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /dev/sda4: 58/10040 files (12.1% non-contiguous), 15670/40131 blocks

Hey! 15Mb! That doesn't look bad.

> W1(robert)/$ sudo mount /dev/sda4 -r
> W1(robert)/$ ls /disk/sda4
> boot  lost+found

Oh my.

> W1(robert)/$ cd /disk/sda4
> W1(robert)sda4$ ls -l
> total 2
> drwxr-xr-x    4 root     root         1024 May 11 18:44 boot
> drwxr-xr-x    2 root     root         1024 May 24 08:29 lost+found
> W1(robert)sda4$ cd boot
> W1(robert)boot$ ls -l
> total 13289
> -rw-r--r--    1 root     root       221502 Jun 25  2001 System.map-2.2.17
> -rw-r--r--    1 root     root       397485 Apr 14  2002 System.map-2.4.18-k6
> -rw-r--r--    1 root     root       437466 May  7 00:23 System.map-2.4.20
> -rw-r--r--    1 root     root       459497 May 11 00:48 System.map-2.4.20-05102308
> -rw-r--r--    1 root     root       424536 Mar 25 10:05 System.map-2.4.20-1-k6
> -rw-r--r--    1 root     root          512 Dec 10  2000 boot.0300
> -rw-r--r--    1 root     root          512 Sep 24  2000 boot.0800
> drwxr-xr-x    2 root     root         1024 Sep 15  2002 bootdisk
> -rw-r--r--    1 root     root        37036 Apr 14  2002 config-2.4.18-k6
> -rw-r--r--    1 root     root        40107 May  6 23:23 config-2.4.20
> -rw-r--r--    1 root     root        40409 May 10 23:11 config-2.4.20-05102308
> -rw-r--r--    1 root     root        39538 Mar 22 03:36 config-2.4.20-1-k6
> -rw-r--r--    1 root     root      2736128 Sep 15  2002 initrd.img-2.4.18-k6
> -rw-r--r--    1 root     root      2871296 May  7 07:22 initrd.img-2.4.20
> -rw-r--r--    1 root     root      2887680 May  9 22:04 initrd.img-2.4.20-1-k6
> lrwxrwxrwx    1 root     root           17 May 11 18:44 initrd.img.old -> initrd.img-2.4.20
> -rw-------    1 root     root       163328 May 11 18:44 map
> -rwxrwxr-x    1 root     root          599 May 10 22:32 mklink
> drwxr-xr-x    2 root     root         1024 Sep 15  2002 old
> -rw-r--r--    1 root     root           20 May  7 00:23 patches-2.4.20
> -rw-r--r--    1 root     root           25 May 11 00:48 patches-2.4.20-05102308
> lrwxrwxrwx    1 root     root           23 May 11 18:44 vmlinuz -> vmlinuz-2.4.20-05102308
> -rw-r--r--    1 root     root       614313 Apr 14  2002 vmlinuz-2.4.18-k6
> -rw-r--r--    1 root     root       722227 May  7 00:23 vmlinuz-2.4.20
> -rw-r--r--    1 root     root       790421 May 11 00:48 vmlinuz-2.4.20-05102308
> -rw-r--r--    1 root     root       638232 Mar 25 10:05 vmlinuz-2.4.20-1-k6
> lrwxrwxrwx    1 root     root           14 May 11 18:44 vmlinuz-rd.old -> vmlinuz-2.4.20
> W1(robert)boot$

It's all there! Could this possibly mean ...

FX: diff, lilo, reboot, rumble, beep, rumble

> Debian GNU/Linux 3.0 mayday.local
> mayday login: _

Wow! I love Linux!

-- 
Rob.                          (Robert de Bath <robert$ @ debath.co.uk>)
                                       <http://www.cix.co.uk/~mayday>
Google Homepage:   http://www.google.com/search?btnI&q=Robert+de+Bath

