Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTKJPkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbTKJPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:40:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54408 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263921AbTKJPk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:40:27 -0500
Date: Mon, 10 Nov 2003 16:39:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Csaba Halasz <Jester01@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-cd panic with faulty disk and DMA enabled (2.6.0-test9)
Message-ID: <20031110153948.GO32637@suse.de>
References: <9B4E9DA25A3DD41189B000508B5C0CEE2142AD@BOMBA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B4E9DA25A3DD41189B000508B5C0CEE2142AD@BOMBA>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10 2003, Csaba Halasz wrote:
> Hi!
> 
> I have a DVD+RW disk that crashes the kernel every time I try to
> read a particular area using my DVD-ROM drive with DMA enabled.
> (The writer unit can read it back without any problems though.)
> 
> IMHO the crash seems to be of a more general nature,
> not related to DVD+RW.
> 
> Linux version 2.6.0-test9 (hcs@defiant) (gcc version 3.3 (Debian)) #1 Sun Nov 9 14:08:41 CET 2003
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE: IDE controller at PCI slot 0000:00:09.0
> NFORCE: chipset revision 195
> NFORCE: not 100%% native mode: will probe irqs later
> AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
> AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD_IDE: 0000:00:09.0 (rev c3) UDMA100 controller on pci0000:00:09.0
>     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
> hda: Maxtor 5T040H4, ATA DISK drive
> hdb: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: Maxtor 5T040H4, ATA DISK drive
> hdd: MATSHITADVD-ROM SR-8586, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> end_request: I/O error, dev hdb, sector 0
> hdb: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> end_request: I/O error, dev hdd, sector 0
> hdd: ATAPI 123X DVD-ROM drive, 512kB Cache, UDMA(33)
> hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> hdd: media error (bad sector): error=0x34
> end_request: I/O error, dev hdd, sector 7043320
> Buffer I/O error on device hdd, logical block 880415
> hdd: DMA timeout retry
> hdd: timeout waiting for DMA
> 
> Unable to handle kernel paging request at virtual address ddff7f74
>  printing eip:
> c0249af6
> *pde = 00076067
> *pte = 1dff7000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0249af6>]    Not tainted

Could you build the same kernel with CONFIG_DEBUG_INFO enabled, and then
do a

# gdb vmlinux
# l *0xc0249af6

for me? Thanks.

-- 
Jens Axboe

