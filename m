Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTAYSS7>; Sat, 25 Jan 2003 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbTAYSS7>; Sat, 25 Jan 2003 13:18:59 -0500
Received: from CPEdeadbeef0000-CM3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:9220
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261660AbTAYSS6>; Sat, 25 Jan 2003 13:18:58 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Sat, 25 Jan 2003 13:28:24 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PROBLEM[2.5.59][-mm4] - DMA Disabled & UDMA wrong mode
Cc: Andrew Morton <akpm@digeo.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200301251328.24971.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 2.5.59-mm4 I've seen DMA being disabled. I don't know if this is occuring 
in vanilla 2.5.59.
Also, the UDMA33 is wrong, this A7M266-D supports UDMA100 and the drive itself 
is a UDMA(133) but since ive not heard of any UDMA133 controllers it's using 
100.

dmesg snippit:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devic AMD-768 [Opus] IDE (rev04) UDMA100 controller on 
pci00:07.1
     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L060J3, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(33) 
