Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264642AbUEJLcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264642AbUEJLcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUEJLcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:32:39 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:59344 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S264642AbUEJLcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:32:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Mon, 10 May 2004 07:32:10 -0400
User-Agent: KMail/1.6
References: <409F4944.4090501@keyaccess.nl>
In-Reply-To: <409F4944.4090501@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405100732.10363.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.57.74] at Mon, 10 May 2004 06:32:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 May 2004 05:20, Rene Herman wrote:
>Good day.
>
>The 2.6.6-rc3 -> 2.6.6-final changes to ide-disk.c unfortunately
> make my machine complain loudly both at boot and reboot:
>
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx AMD7409: IDE controller at PCI slot 0000:00:07.1
>AMD7409: chipset revision 7
>AMD7409: not 100% native mode: will probe irqs later
>AMD7409: 0000:00:07.1 (rev 07) UDMA66 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
>hda: Maxtor 6Y120P0, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>hdc: PLEXTOR DVD-ROM PX-116A, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 128KiB
>hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63,
>UDMA(66)
>  hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
> hda2 hda3 hda4
>  hda2: <bsd: hda14 hda15 hda16 hda17 hda18 >
>  hda4: <minix: hda19 hda20 >
>hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error
> } hda: task_no_data_intr: error=0x04 { DriveStatusError }
>hda: Write Cache FAILED Flushing!
>
I have this too:
Linux version 2.6.6 (root@coyote.coyote.den) (gcc version 3.3.2 
20031022 (Red Hat Linux 3.3.2-1)) #1 Mon May 10 02:20:54 EDT 2004
[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
[...]
hda: Maxtor 6Y120P0, ATA DISK drive
[...]
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, 
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!

>The disk, 6Y120P0, is a new-ish Maxtor "DiamondMax Plus 9", 120G, 8M
>cache. Controller is an AMD756. Same complaints on reboot. Reverting
> the rc3->final changes to ide-disk.c fixes/supresses them again.
>
>Rene.

I note the drive is the same model here too, Rene.

The question remains however, is our data in danger?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
