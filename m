Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271340AbTGQRcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271479AbTGQRcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:32:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47095 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271340AbTGQRcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:32:04 -0400
Date: Thu, 17 Jul 2003 19:46:11 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stef van der Made <svdmade@planet.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Onstream DI-30 not responding 2.6
In-Reply-To: <3F16DDF8.1030707@planet.nl>
Message-ID: <Pine.SOL.4.30.0307171938370.20577-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

ide-tape driver is broken right now in 2.6.
Config option for it is commented out because
it even doesn't compile (easy to fix).

I can help a bit if somebody wants to fix this driver.
--
Bartlomiej

On Thu, 17 Jul 2003, Stef van der Made wrote:
>
> Hi
>
> I'm trying to use my Onstream DI-30 (IDE) tape device with Kernel
> 2.6.0-test1. When trying to access the drive using the old 2.2 kernels
> and 2.4 these commands worked fine
>
> bash-2.05# mt -f /dev/nht0 status
> /dev/nht0: No such device
> bash-2.05# mt -f /dev/ht0 status
> /dev/ht0: No such device
> bash-2.05# mt -f /dev/hdd status
> /dev/hdd: No such device or address
> bash-2.05# mt -f /dev/hdc status
> /dev/hdc: No such device or address
>
> While they now are showing ugly errors.
>
> This is a part of the boot log
>
> VP_IDE: IDE controller at PCI slot 0000:00:07.1
> VP_IDE: chipset revision 16
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
>     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
> hda: WDC WD205BA, ATA DISK drive
> anticipatory scheduling elevator
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdd: OnStream DI-30, ATAPI TAPE drive
>
>
> Thanks in advance for any tips on a solution for this problem.
>
> Stef

