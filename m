Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129535AbQKZHd0>; Sun, 26 Nov 2000 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129627AbQKZHdQ>; Sun, 26 Nov 2000 02:33:16 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:14865
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129535AbQKZHdC>; Sun, 26 Nov 2000 02:33:02 -0500
Date: Sat, 25 Nov 2000 23:02:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Fei Liu <afei@jhu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: difference between kernel and bios report on drive status
In-Reply-To: <Pine.GSO.4.05.10011260126390.19778-100000@aa.eps.jhu.edu>
Message-ID: <Pine.LNX.4.10.10011252300260.10729-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is a standards bug that your drives are mixed in the rev.
Adjust the IVB option so that it does not care about these bits just the
presence of either set.

Cheers,


On Sun, 26 Nov 2000 afei@jhu.edu wrote:

> Hi there:  
> 
> I am using PROMISE ultra100 with 2 UDMA66 disks. The PROMIS
> bios reports that both disks are using UDMA 4. But during kernel boot On
> Fri, 24 Nov 2000, Szabolcs Szakacsits wrote: up, the master disk is using
> UDMA 2 only. The reason is that master disk's pci->dma_ultra value is only
> 0x40f. I hacked the kernel a bit, both hard disk using hardware configued
> udma_four though. So I am wondering why not use udma_four as mode
> indication? Anyone here knows or
>  I have to email Andre on this?
> 
> By the way, mode4 works much faster.(hdparm -tT):
> disk1: udma33, mode2, disk buffer read 14MB/s
> disk2: udma66, mode4, disk buffer read 24MB/s
> 
> both disks: buffer-cache read 88MB/s
> 
> The second disk is only 5400RPM, the first one is 7200RPM. Both comply > >
> HOW? to UDMA66. How come the 2nd one is UDMA66, but the first one is > > >
> No performance loss, RAM is always fully utilized (except if no swap),
> UDMA33? And how come the 2nd is faster than the first one. 
> 
> I hope this is not a kernel bug.
> 
> Fei
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
