Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282359AbRKXDtl>; Fri, 23 Nov 2001 22:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282360AbRKXDtb>; Fri, 23 Nov 2001 22:49:31 -0500
Received: from smtp01.iprimus.net.au ([203.134.64.99]:5647 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S282359AbRKXDt0>; Fri, 23 Nov 2001 22:49:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jeff <jeff_l@iprimus.com.au>
Reply-To: jeff_l@iprimus.com.au
To: <linux-kernel@vger.kernel.org>
Subject: Problems booting linux kernel
Date: Sat, 24 Nov 2001 14:52:27 +1100
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <S37ThqyOfdS1U94odj20001785f@smtp01.iprimus.net.au>
X-OriginalArrivalTime: 24 Nov 2001 03:49:18.0179 (UTC) FILETIME=[FE358330:01C1749A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
	I have two eide hard drives arranged as master and slave on my primary
ide controller.  The 20G seagate is the master and it has LILO as the 
bootloader.  This drive also has an old RH 6.1 install on it that I hardly
use.  A 30G quantum is the slave and it has linux that I built from sources.  
This latter drive and OS is the one I use mostly.  
	Now I want to configure the 30G drive as the master and I want to use
the 20G (current master) for other things.

	My 30G drive has a / (root) partition (currently /dev/hdb2) and a /boot 
partition (currently /dev/hdb1).  I couldn't get LILO to start properly when I
installed it on my 30G drive so I've switched to GRUB.  (I'll switch back to 
LILO if need be and I get good advice.)   I can get GRUB to start my kernel 
but my kernel panics when trying to mount file systems.  Here is a transcript 
of the kernel output:

attempt to access beyond end of device
03:42: rw=0, want=1, liimt=1
EXT2-fs: unable to read superblock
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
attempt to access beyond end of device
03:42: rw=0, want=33, limit=1
isofs_read_super: bread failed, dev=03:42, iso_blknum=16, block=32
Kernel panic: VFS: Unable to mount root fs on 03:42

When I switch everything back to the way it was this kernel can be started 
without a problem.

In switching the drives' master/slave status around I have (of course) done 
the following:
* changed jumper settings on both drives
* edited /etc/fstab on the 30G drive (the one I want to boot as master).
* modified the bios settings (got bios to autodetect drives in new
  configuration).

Why does my kernel panic?  How do I fix the problem so that I can boot the 
linux kernel on my 30G drive when the drive is configured as master instead 
of slave?

Please help,
		Jeff
    
-- 
===============================================================================
I never saw a wild thing
sorry for itself.
A small bird will drop frozen dead from a bough
without ever having felt sorry for itself.
	-- "Self-Pity" by David Herbert Lawrence (1885-1930)
