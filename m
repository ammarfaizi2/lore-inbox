Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319254AbSHNR3E>; Wed, 14 Aug 2002 13:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319255AbSHNR3E>; Wed, 14 Aug 2002 13:29:04 -0400
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:18767 "EHLO
	mailout5-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S319254AbSHNR3D>; Wed, 14 Aug 2002 13:29:03 -0400
Date: Wed, 14 Aug 2002 13:32:55 -0400
From: Rob Speer <rob@twcny.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Yet another 845G IDE problem
Message-ID: <20020814173255.GA533@twcny.rr.com>
Reply-To: rob@twcny.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Is-It-Not-Nifty: www.sluggy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get DMA to work on an AOpen motherboard using the Intel 845G
chipset. I see in the archives that other people have had problems like
this, and that it's due to a BIOS problem. I've tried some of the
patches that were sent in response, but it seems that those patches are
already incorporated into the kernel I'm using (2.4.20-pre1-ac3) and I
still have the problem.

My kernel command line includes "ide0=dma".

These lines show up on boot:

PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
...[several unrelated lines]...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.

And here's what seems to be the relevant part of 'lspci -v':

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: AOPEN Inc.: Unknown device 0074
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at f000 [size=16]
	Memory at 1f800000 (32-bit, non-prefetchable) [size=1K]

-- 
Rob Speer

