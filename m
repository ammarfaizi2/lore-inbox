Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUAPQwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUAPQwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:52:40 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:56978 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265742AbUAPQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:52:38 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: Nforce2 66MHz IDE without idebus=xx and "Athlon-xp powersaving system lock"
Date: Fri, 16 Jan 2004 13:52:25 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401161352.25732.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If all Nvidia Nforce2 based systems have 2 pci buses (First is 66mhz for onboard devices and
second is 33mhz for pci expansion slots) and IDE controller work in 66mhz,
will be change kernel to start IDE controller in 66mhz mode automatic?

Athlon-xp powersaving lock-up: mm series disable 'Halt Disconnect and Stop Grant Disconnect' on boot!
 
Without mm patchs I disable it with "athcool" tool, kernel developers maybe include 
automatic disable 'Halt Disconnect and Stop Grant Disconnect' on Linus tree?



from athcool menssages 
=====================================
!!!WARNING!!!
Depending on your motherboard and/or hardware components,
enabling Athlon powersaving mode sometimes causes that
 * noisy or distorted sound playback
 * a slowdown in harddisk performance
 * system locks or instability
=======================================


dmesg
================================================
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6E040L0, ATA DISK drive
hdb: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
==================================================

lspci -v
===================================================
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
        Flags: bus master, 66Mhz, fast devsel, latency 0
        I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
====================================================

Thanks

