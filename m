Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUA2K6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUA2K6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:58:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47273 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265872AbUA2K6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:58:47 -0500
Date: Thu, 29 Jan 2004 11:58:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE questions [kernel: 2.6.1-rc1]
Message-ID: <20040129105845.GA11683@suse.de>
References: <20040129112821.27b59313@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129112821.27b59313@phoebee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29 2004, Martin Zwickel wrote:
> Hi there,
> 
> 2 questions about IDE:
> 
> 1.: with my machine:
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SIS5513: IDE controller at PCI slot 0000:00:02.5
> SIS5513: chipset revision 0
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
>     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> hda: WDC WD800BB-00CAA1, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
> cdrom: : unknown mrw mode page
>       ^ no cdi->name?
>         is this for the hda device or hdc?

hdc - it's a debug message, it has been removed in newer kernels.

> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> 
> 
> 2.: with another machine: I have a disk that has some bad sectors
> (that says the drive fitness test from ibm). and I think one of the
> sectors is where the partition table is.  on kernel boot the kernel
> stops when it tries to detect the partitions and gives some "dma
> timeout"s.  can I disable the partition table probe? is the
> "hdx=noprobe" argument the right one?

If you want to completely ignore the drive, yes.

-- 
Jens Axboe

