Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRDUPxH>; Sat, 21 Apr 2001 11:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDUPw6>; Sat, 21 Apr 2001 11:52:58 -0400
Received: from m2ep.pp.htv.fi ([212.90.64.98]:56842 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S132725AbRDUPwu>;
	Sat, 21 Apr 2001 11:52:50 -0400
Message-ID: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi>
From: "Ville Holma" <ville.holma@pp.htv.fi>
To: <linux-kernel@vger.kernel.org>
Cc: <ville.holma@pp.htv.fi>
Subject: a way to restore my hd ?
Date: Sat, 21 Apr 2001 18:52:01 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm affraid this list is my last chance at saving my harddrive. I hope this
kind of question is appropriate here and if not, my appologies.

Anyway, here's the deal. I upgraded my hardware to 1GHz Athlon with a 133
kHz FSB,  Via KT133A chipset motherboard and 256 Mb of 133 sdram. I'm
running a standard 2.4.3 kernel.

The memory I had was however somehow corrupt and after I got my new system
booted up and used it a little it became shaky and then locked hard and I
could do nothing but reset it. I suppose this was caused by the
malfunctioning memory but I can't be sure, I know there has been problems
with the via chipset also.

Anyway now that I try to boot up the system I get a kernel panic like this:


EXT2-fs: #blocks per group too big: 2147516416
fatfs: bodus cluster size
kernel panic: VFS: Unable to mount root fs on 03:47


So I set up another linux box and tried to run e2fsck on the partition
resulting in this


debian:~# e2fsck /dev/hdb7
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Corruption found in superblock.  (frags_per_group = 2147516416).

The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b -2147450879 <device>


So I tried to use the huge block size like e2fsck suggests and I get this


debian:~# e2fsck -b -2147450879 /dev/hdb7
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
e2fsck: Attempt to read block from filesystem resulted in short read while
trying to open /dev/hdb7
Could this be a zero-length partition?


This is where the human panic occured. There is data on that partition that
I _really_ do not want to loose. I'm clueless and woud appreciate any
help/suggestions. If some additonal information is needed I'm more than
happy to deliver.

Thanks in advance

Ville

