Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbSLVMkd>; Sun, 22 Dec 2002 07:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbSLVMkd>; Sun, 22 Dec 2002 07:40:33 -0500
Received: from [81.2.122.30] ([81.2.122.30]:58372 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266435AbSLVMkc>;
	Sun, 22 Dec 2002 07:40:32 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212221300.gBMD0LxG001017@darkstar.example.net>
Subject: Re: [2.4.21-p2] more VIA-IDE problems
To: jarausch@skynet.be
Date: Sun, 22 Dec 2002 13:00:21 +0000 (GMT)
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <200212221226.gBMCQ9m07448@vador.skynet.be> from "jarausch@skynet.be" at Dec 22, 2002 01:26:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> beginning with 2.4.21-pre1 the kernel disables DMA on my
> regular ATA harddrives.
> 
> Upto 2.4.20 (Uniform Multi-Platform E-IDE driver Revision: 6.31)
> there have never been any problems, now I get
> 
> ! Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
>   ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ! VP_IDE: IDE controller at PCI slot 00:04.1
>   VP_IDE: chipset revision 16
>   VP_IDE: not 100% native mode: will probe irqs later
>   VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
>       ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
>       ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
>   hda: Maxtor 94098H6, ATA DISK drive
>   hdb: LITEON DVD-ROM LTD122, ATAPI CD/DVD-ROM drive
> + hda: DMA disabled
> + blk: queue c0395e20, I/O limit 4095Mb (mask 0xffffffff)
> + hdb: DMA disabled
>   hdc: ST340823A, ATA DISK drive
>   hdd: R/RW 4x4x32, ATAPI CD/DVD-ROM drive
> + hdc: DMA disabled
> + blk: queue c039626c, I/O limit 4095Mb (mask 0xffffffff)
> + hdd: DMA disabled
>   ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>   ide1 at 0x170-0x177,0x376 on irq 15

I think that they are superflous debugging messages, and that DMA is
actually re-enabled silently afterwards.  I could be wrong, though.

John.
