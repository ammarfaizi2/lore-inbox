Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTEaQyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbTEaQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:54:05 -0400
Received: from host81-136-217-175.in-addr.btopenworld.com ([81.136.217.175]:6087
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S264740AbTEaQyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:54:03 -0400
Date: Sat, 31 May 2003 18:07:24 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: linux-kernel@vger.kernel.org
Subject: Re: Any experience with Promise PDC20376 and SATA RAID?
Message-ID: <Pine.LNX.4.53.0305311757390.27375@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no GPL/LGPL support for the promise 20376 Fastrak 133
controller on Linux at the moment. There is a binary module from
Promise, but only on 2.4.18 i believe.

	http://www.promise.com/support/download/download2_eng.asp?productId=107&category=driver&os=100

I think someone is working on reverse engineering the code for
stock kernel inclusion.

I've got the same controller on my board, but no use for it
since i only have 2 disks on the machine which fit nicely on the
2 onboard IDE controllers in my A7V8X motherboard - though it'd
be nice to be able to buy and support ATA150 drive speeds.

Cheers
M

Reid Spencer wrote:
> I think the kernel doesn't know about the device number (105a:3376 =
> PDC20376) since it isn't in the kernel's drivers/pci/pci.ids file
> (latest device is 7275 PDC20277)and it doesn't recognize the device when
> it processes the IDE devices at boot up. All I get is:
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller at PCI slot 00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
>     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
> hda: WDC WD400AB-32BVA0, ATA DISK drive
> blk: queue c03c58e0, I/O limit 4095Mb (mask 0xffffffff)
> hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
> UDMA(100)
> ide-floppy driver 0.99.newide
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
> ide-floppy driver 0.99.newide
>
> Note that ide2 isn't found even though I specifically gave the ports for
> it on the "append line" of the boot.  I don't know enough about the
> IDE/PDC support to be able to add support for this new PDC20376 chip.
>
> Anyone out there done this?
>
> Reid.

