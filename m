Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTIVDtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 23:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTIVDtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 23:49:15 -0400
Received: from mailhub2.uq.edu.au ([130.102.5.59]:38815 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S262766AbTIVDtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 23:49:13 -0400
Subject: Cobalt RaQ 550: 2.4.x Boot Problem
From: Stuart Low <stuart@perlboy.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Serverpeak.com
Message-Id: <1064202544.17769.3.camel@poohbox.perlaholic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Sep 2003 13:49:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm currently trying to convert a Cobalt RaQ 550 to a [near to] standard
install of Redhat 9. I've completed an installation (using another
desktop machine) and removed the drive before RH9 booted for the first
time (avoid configuration issues).

I've also chrooted to the sysimage and installed the Generation V Cobalt
Kernel rpms that are available online. Unfortunately, this appears to be
all in vain as the kernel fails to load reporting the following:

raid5: using function: pIII_sse (2038.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs: unable to read superblock
XFS: SB read failed
I/O error in filesystem ("md(9,1)") meta-data dev 0x901 block 0x0
       ("xfs_readsb") error 5 buf count 512
Kernel panic: VFS: Unable to mount root fs on 09:01
 <6>disabling network interfaces.

My first guess was it's looking for the raid device md9. But even after
parsing root=/dev/hda1 to both the boot and load kernel (the Cobalt
doesn't have a real bios, it uses a small kernel to boot a second from
what I can see) it fails "Reporting no init= ".

Any and all guesses would be appreciated,

Stuart Low


-- 
ServerPeak.com - Innovators in Service Provider Solutions
Need a Linux Admin? Contact Us!

