Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRIJGh1>; Mon, 10 Sep 2001 02:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273214AbRIJGhS>; Mon, 10 Sep 2001 02:37:18 -0400
Received: from alcatraz.fdf.net ([209.245.242.221]:32896 "HELO
	alcatraz.fdf.net") by vger.kernel.org with SMTP id <S273213AbRIJGhD>;
	Mon, 10 Sep 2001 02:37:03 -0400
Date: Mon, 10 Sep 2001 01:37:23 -0500 (CDT)
From: Dustin Marquess <jailbird@alcatraz.fdf.net>
To: <linux-kernel@vger.kernel.org>
Subject: Software RAID-1 Oops on Alpha on 2.4.x kernels
Message-ID: <Pine.LNX.4.33.0109100134060.871-100000@alcatraz.fdf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to upgrade the kernel on one of my Alphas running
Software RAID-1 from 2.2.19 to any 2.4.x kernel all weekend.  I've tried
everything from 2.4.5 to 2.4.10-pre7, and all of them Oops.  They either
Oops when I run mke2fs or mkreiserfs on the md device, or when I mount the
md drvice, or if I get it mounted and start copying files over to it.

Below is an Oops I got from 2.4.10-pre7 trying to run mkreiserfs on the md
device.

Anybody have any ideas?  I assume this is an Alpha-only issue, and it
seems to affect every 2.4.x kernel that I've tried.  I've also tried many
-ac and aa patches to all of the kernels, to no avail.

Hopefully somebody can put me out of my misery.. :)

-Dustin

ksymoops 2.3.4 on alpha 2.4.10-pre7.  Options used
     -v /usr/src/linux-2.4.10-pre7/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre7/ (default)
     -m /boot/System.map-2.4.10-pre7 (default)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says fffffc0000458f60, vmlinux says fffffc00003755a0.  Ignoring ksyms_base entry
Sep 10 01:16:02 utopia kernel: Unable to handle kernel paging request at virtual address ffff6c000c4689fc
Sep 10 01:16:02 utopia kernel: mkreiserfs(294): Oops 0
Sep 10 01:16:02 utopia kernel: pc = [raid1_read_balance+348/480]  ra = [raid1_make_request+472/1088]  ps = 0000
Sep 10 01:16:02 utopia kernel: v0 = fffffc0007d0501c  t0 = 0000000000000002  t1 = 0000000000000002
Sep 10 01:16:02 utopia kernel: t2 = ffffdc00011d8e80  t3 = 0000000000000000  t4 = ffff6c000c468a1c
Sep 10 01:16:02 utopia kernel: t5 = ffff6c000c4689fc  t6 = ffff6c000c4689f4  t7 = fffffc0005f58000
Sep 10 01:16:02 utopia kernel: s0 = fffffc0007af7be0  s1 = 0000000000000900  s2 = fffffc0007af7be0
Sep 10 01:16:02 utopia kernel: s3 = fffffc0007d05000  s4 = fffffc0000a6cde0  s5 = 0000000000000000
Sep 10 01:16:02 utopia kernel: s6 = 0000000000000000
Sep 10 01:16:02 utopia kernel: a0 = fffffc0007d05000  a1 = fffffc0007af7be0  a2 = fffffc0007af7be0
Sep 10 01:16:02 utopia kernel: a3 = 0000000000000002  a4 = fffffc0007d05018  a5 = 0000000000000008
Sep 10 01:16:02 utopia kernel: t8 = 0000000000000002  t9 = 0000000000000000  t10= ffff700004763a00
Sep 10 01:16:02 utopia kernel: t11= 0000000000000002  pv = fffffc0000456200  at = fffffc0007d05020
Sep 10 01:16:02 utopia kernel: gp = fffffc00005af880  sp = fffffc0005f5b938

1 warning issued.  Results may not be reliable.

