Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTEYBqt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 21:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbTEYBqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 21:46:49 -0400
Received: from RJ193194.user.veloxzone.com.br ([200.165.193.194]:64015 "EHLO
	pervalidus.tk") by vger.kernel.org with ESMTP id S261265AbTEYBqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 21:46:47 -0400
Date: Sat, 24 May 2003 22:59:48 -0300 (E. South America Standard Time)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: What may be causing this ? ext3, hard drive, motherboard ?
Message-ID: <Pine.WNT.4.55.0305242226390.1388@pervalidus>
X-X-Sender: fredlwm@fastmail.fm
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3 days ago I noticed the following:

May 22 00:29:25 pervalidus kernel: eth0: Too much work at interrupt, IntrStatus=0x0001.
May 22 00:30:00 pervalidus last message repeated 17 times
May 22 00:30:13 pervalidus last message repeated 5 times
May 22 00:30:24 pervalidus kernel: eth0: Too much work at interrupt, IntrStatus=0x0001.
May 22 00:30:33 pervalidus last message repeated 2 times
May 22 00:30:34 pervalidus last message repeated 2 times
May 22 00:35:21 pervalidus kernel: EXT3-fs error (device ide0(3,7)): ext3_new_b lock: Allocating block in system zone - block = 1573066
May 22 00:38:51 pervalidus kernel: EXT3-fs error (device ide0(3,7)): ext3_new_inode: reserved inode or inode > inodes count - block_group = 0,inode=1
May 22 00:38:51 pervalidus kernel: EXT3-fs error (device ide0(3,7)) in ext3_new_inode: IO failure

I was disconnected from the Internet and most commands stopped
working with "Cannot execute binary file.".

>From /var/log/syslog:

May 22 00:30:39 pervalidus modprobe: modprobe: Can't locate module binfmt-0804
May 22 00:31:14 pervalidus last message repeated 26 times
May 22 00:32:19 pervalidus last message repeated 52 times
May 22 00:33:24 pervalidus last message repeated 52 times
May 22 00:34:25 pervalidus last message repeated 52 times
May 22 00:35:30 pervalidus last message repeated 52 times
May 22 00:36:35 pervalidus last message repeated 52 times
May 22 00:37:40 pervalidus last message repeated 52 times
May 22 00:38:41 pervalidus last message repeated 54 times
May 22 00:39:46 pervalidus last message repeated 54 times
May 22 00:40:51 pervalidus last message repeated 54 times
May 22 00:42:24 pervalidus last message repeated 8 times

On reboot:

May 22 01:01:52 pervalidus kernel: EXT3-fs error (device ide0(3,7)): ext3_new_inode: reserved inode or inode > inodes count - block_group = 0,inode=2
May 22 01:01:52 pervalidus kernel: EXT3-fs error (device ide0(3,7)) in ext3_new_inode: IO failure

I manually ran fsck and it "fixed" (there were some messages
about duplicate/bad blocks) everything, leaving 3 files I
recovered in /lost+found, but this undeletable:

br-s--xr-x    1 28260    28532      0,   0 Sep 22  2014 #1570049

#1570049: setuid block special (0/0)

smartmontools doesn't report any errors besides the high
Hardware_ECC_Recovered, which increased after I ran all
read-only Maxtor's Powermax tests (from 3 to almost 5 million),
but the latter didn't find anything wrong either.

Should I replace it ? There was also a crash today on Windows,
and after using reset the hard drive restarted
(Start_Stop_Count increased by 1), what it only does when you
power on or use sleep / wake up.

-- 
0@pervalidus.{tk, dyndns.org}
