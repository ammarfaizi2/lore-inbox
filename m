Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSH1MvU>; Wed, 28 Aug 2002 08:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSH1MvU>; Wed, 28 Aug 2002 08:51:20 -0400
Received: from atlas.inria.fr ([138.96.66.22]:63145 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S318802AbSH1MvT>;
	Wed, 28 Aug 2002 08:51:19 -0400
Message-Id: <200208281255.g7SCtYQg030108@atlas.inria.fr>
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: lnz@dandelion.com
Subject: DAC960 and cache...
Date: Wed, 28 Aug 2002 14:55:34 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I have a Mylex Acceleraid 170 Raid board and i use 
 DAC960 RAID Driver Version 2.4.11 of 11 October 2001 
under linux (kernel 2.4.18).
Here is the cat /proc/rd/c0/current_status :

***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex AcceleRAID 170 PCI RAID Controller
  Firmware Version: 6.00-15, Channels: 1, Memory Size: 32MB
  PCI Bus: 0, Device: 6, Function: 0, I/O Address: Unassigned
  PCI Address: 0xFC000000 mapped at 0xE0800000, IRQ Channel: 16
  Controller Queue Depth: 512, Maximum Blocks per Command: 2048
  Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
  Physical Devices:
    0:0  Vendor: QUANTUM   Model: ATLAS10K3_36_SCA  Revision: 020W
         Wide Synchronous at 160 MB/sec
         Serial Number: 344208142992
         Disk Status: Online, 71798784 blocks
    0:1  Vendor: QUANTUM   Model: ATLAS10K3_36_SCA  Revision: 020W
         Wide Synchronous at 160 MB/sec
         Serial Number: 344207749285
         Disk Status: Online, 71798784 blocks
    0:2  Vendor: QUANTUM   Model: ATLAS10K3_36_SCA  Revision: 020W
         Wide Synchronous at 160 MB/sec
         Serial Number: 344211046648
         Disk Status: Online, 71798784 blocks
    0:3  Vendor: QUANTUM   Model: ATLAS10K3_36_SCA  Revision: 020W
         Wide Synchronous at 160 MB/sec
         Serial Number: 344211046660
         Disk Status: Online, 71798784 blocks
    0:4  Vendor: QUANTUM   Model: ATLAS10K2-TY184J  Revision: DDD6
         Wide Synchronous at 160 MB/sec
         Serial Number: 161034310612
         Disk Status: Online, 35827712 blocks
    0:5  Vendor: QUANTUM   Model: ATLAS10K2-TY184J  Revision: DDD6
         Wide Synchronous at 160 MB/sec
         Serial Number: 161034412602
         Disk Status: Online, 35827712 blocks
    0:7  Vendor: MYLEX     Model: AcceleRAID 170    Revision: 0600
         Wide Synchronous at 160 MB/sec
         Serial Number:
  Logical Drives:
    /dev/rd/c0d0: RAID-6, Online, 107483136 blocks
                  Logical Device Initialized, BIOS Geometry: 255/63
                  Stripe Size: 64KB, Segment Size: 8KB
                  Read Cache Disabled, Write Cache Disabled
  No Rebuild or Consistency Check in Progress

as you see, both read and write cache are disabled. I don't manage to enable 
them... would you give me any clue ?

I also think my filesystem is slow : i used 
mke2fs -b 4096 -R stride=16 -i 16384 /dev/rd/c0d0p4
but i only get arround 5 Mo/s while doing a       tar c KDE | dd of=/dev/null
(KDE is a 715 Mo source/compilation tree of KDE)
Do you have any clue on how to improve this performance (direct sequencial
access on this disk using dd give me around 50 Mo/s)

Thx in advance for you help.

N. Turro
