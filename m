Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266924AbUFZC3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266924AbUFZC3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 22:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUFZC3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 22:29:10 -0400
Received: from diane.island.net ([199.60.19.9]:49311 "EHLO diane.island.net")
	by vger.kernel.org with ESMTP id S266924AbUFZC24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 22:28:56 -0400
Message-ID: <1088216934.40dcdf66edd1d@webmail.island.net>
Date: Fri, 25 Jun 2004 19:28:54 -0700
From: andyb@island.net
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 207.81.95.65
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having partition table troubles here with 2.6.7 on hdc:  unknown partition table.
but not on hda.

Using 2.6.6 kernel, hdc is handled just fine, partitions are visible.
The boot drive is hda,  drive hdc is for other optional mount points.

VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC26400B, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QUANTUM FIREBALL CR8.4A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/512KiB Cache, CHS=13328/15/63
 hda: hda1 hda2 hda3 < hda5 hda6 >
hdc: max request size: 128KiB
hdc: 16514064 sectors (8455 MB) w/418KiB Cache, CHS=16383/16/63
 hdc: unknown partition table
--------

It's been said in this thread that the kernel no longer guesses a geometry;
it's also been said elsewhere that the kernel doesn't use CHS at all.
What do I put on the kernel parameter line to give a define geometry?
I've tried  hdc=lba32,  with no success.


