Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129492AbQKZHFH>; Sun, 26 Nov 2000 02:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130095AbQKZHE5>; Sun, 26 Nov 2000 02:04:57 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:33751 "EHLO jhuml4.jhu.edu")
        by vger.kernel.org with ESMTP id <S130090AbQKZHEu>;
        Sun, 26 Nov 2000 02:04:50 -0500
Date: Sun, 26 Nov 2000 01:32:55 -0500 (EST)
From: afei@jhu.edu
Subject: difference between kernel and bios report on drive status
In-Reply-To: <Pine.LNX.4.30.0011241145200.12335-100000@fs129-190.f-secure.com>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org, Fei Liu <afei@jhu.edu>
Message-id: <Pine.GSO.4.05.10011260126390.19778-100000@aa.eps.jhu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there:  

I am using PROMISE ultra100 with 2 UDMA66 disks. The PROMIS
bios reports that both disks are using UDMA 4. But during kernel boot On
Fri, 24 Nov 2000, Szabolcs Szakacsits wrote: up, the master disk is using
UDMA 2 only. The reason is that master disk's pci->dma_ultra value is only
0x40f. I hacked the kernel a bit, both hard disk using hardware configued
udma_four though. So I am wondering why not use udma_four as mode
indication? Anyone here knows or
 I have to email Andre on this?

By the way, mode4 works much faster.(hdparm -tT):
disk1: udma33, mode2, disk buffer read 14MB/s
disk2: udma66, mode4, disk buffer read 24MB/s

both disks: buffer-cache read 88MB/s

The second disk is only 5400RPM, the first one is 7200RPM. Both comply > >
HOW? to UDMA66. How come the 2nd one is UDMA66, but the first one is > > >
No performance loss, RAM is always fully utilized (except if no swap),
UDMA33? And how come the 2nd is faster than the first one. 

I hope this is not a kernel bug.

Fei

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
