Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSJALeo>; Tue, 1 Oct 2002 07:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261588AbSJALeo>; Tue, 1 Oct 2002 07:34:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17802 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261586AbSJALem>;
	Tue, 1 Oct 2002 07:34:42 -0400
Date: Tue, 1 Oct 2002 13:39:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021001113939.GQ3867@suse.de>
References: <3D99885B.533C320D@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D99885B.533C320D@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Helge Hafting wrote:
> I get two of these during bootup of 2.5.39 UP, preempt
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> hda: FUJITSU MPB3032ATU, ATA DISK drive
> hdb: CD-ROM 32X/AKU, ATAPI CD/DVD-ROM drive
> Sleeping function called from illegal context at slab.c:1374
> c12b3ec4 c01146c4 c02801a0 c0284429 0000055e 000001d0 c012dca0 c0284429 
>        0000055e c039a390 c01d1b84 04000000 c039a390 c010915f 00000018
> 000001d0 
>        c039a390 c039a380 cfe0e2c0 04000000 c01cb617 0000000e c01d1b84
> 04000000 
> Call Trace:
>  [<c01146c4>]__might_sleep+0x54/0x60
>  [<c012dca0>]kmalloc+0x4c/0x130
>  [<c01d1b84>]ide_intr+0x0/0x17c
>  [<c010915f>]request_irq+0x53/0xa8
>  [<c01cb617>]init_irq+0x1e7/0x338
>  [<c01d1b84>]ide_intr+0x0/0x17c
>  [<c01cbaa6>]hwif_init+0x112/0x258
>  [<c01cb31c>]probe_hwif_init+0x1c/0x6c
>  [<c01d789d>]ide_setup_pci_device+0x3d/0x68
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: WDC WD200BB-00CAA0, ATA DISK drive

Fixed in 2.5.40

-- 
Jens Axboe

