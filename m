Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131957AbQLHR3o>; Fri, 8 Dec 2000 12:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132020AbQLHR3e>; Fri, 8 Dec 2000 12:29:34 -0500
Received: from proxy.ovh.net ([213.244.20.42]:49415 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S131957AbQLHR3S>;
	Fri, 8 Dec 2000 12:29:18 -0500
Message-ID: <3A311338.238D81A3@ovh.net>
Date: Fri, 08 Dec 2000 17:58:32 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: problem with DAC960
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
running raid-1 on Mylex 170 2x18Go we have lot of problem
like this:

EXT2-fs error (device rd(48,3)): ext2_readdir: directory #181 contains a hole at offset 827392
EXT2-fs error (device rd(48,3)): ext2_readdir: directory #181 contains a hole at offset 831488
EXT2-fs error (device rd(48,3)): ext2_readdir: directory #181 contains a hole at offset 835584
EXT2-fs error (device rd(48,3)): ext2_readdir: directory #181 contains a hole at offset 839680
EXT2-fs error (device rd(48,3)): ext2_readdir: directory #181 contains a hole at offset 843776
EXT2-fs error (device rd(48,2)): ext2_new_block: Free blocks count corrupted for block group 3
EXT2-fs error (device rd(48,2)): ext2_new_block: Free blocks count corrupted for block group 3
EXT2-fs error (device rd(48,2)): ext2_new_block: Free blocks count corrupted for block group 3
EXT2-fs error (device rd(48,2)): ext2_new_block: Free blocks count corrupted for block group 3
EXT2-fs error (device rd(48,2)): ext2_new_block: Free blocks count corrupted for block group 3
EXT2-fs error (device rd(48,2)): ext2_new_block: Free blocks count corrupted for block group 3

I comes after we added DEAD hd to raid
rebuild 0:0 > command

but we still have the errors.
any idea ?
thanks for help

Octave

# cat /proc/rd/c0/current_status 
***** DAC960 RAID Driver Version 2.2.8 of 19 August 2000 *****
Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex AcceleRAID 170 PCI RAID Controller
  Firmware Version: 6.00-01, Channels: 1, Memory Size: 32MB
  PCI Bus: 0, Device: 16, Function: 1, I/O Address: Unassigned
  PCI Address: 0xCE000000 mapped at 0xD0000000, IRQ Channel: 5
  Controller Queue Depth: 512, Maximum Blocks per Command: 2048
  Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
  Physical Devices:
    0:0  Vendor: IBM       Model: DPSS-309170N      Revision: S93E
         Wide Synchronous at 40 MB/sec
         Serial Number:         ZD14G827
         Disk Status: Write-Only, 17883136 blocks
    0:1  Vendor: IBM       Model: DPSS-309170N      Revision: S93E
         Wide Synchronous at 40 MB/sec
         Serial Number:         ZD146613
         Disk Status: Online, 17883136 blocks
    0:7  Vendor: MYLEX     Model: AcceleRAID 170    Revision: 0600
         Wide Synchronous at 160 MB/sec
         Serial Number:   
  Logical Drives:
    /dev/rd/c0d0: RAID-1, Critical, 17883136 blocks
                  Logical Device Initialized, BIOS Geometry: 255/63
                  Stripe Size: 64KB, Segment Size: 8KB
                  Read Cache Disabled, Write Cache Disabled
  Rebuild in Progress: Logical Drive 0 (/dev/rd/c0d0) 0% completed



Octave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
