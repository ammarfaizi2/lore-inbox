Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTCGE7U>; Thu, 6 Mar 2003 23:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbTCGE7U>; Thu, 6 Mar 2003 23:59:20 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46488 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261346AbTCGE7T>; Thu, 6 Mar 2003 23:59:19 -0500
Date: Thu, 06 Mar 2003 21:09:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 448] New: IDE Changes broke UDMA timings for AMD74xx
Message-ID: <301860000.1047013788@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=448

           Summary: IDE Changes broke UDMA timings for AMD74xx
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: spstarr@sh0n.net


Distribution: LFS 
 
Some changes in IDE from 2.5.59+ broke UDMA timings for the AMD74xx chipset. 
 
niform Multi-Platform E-IDE driver Revision: 7.00alpha2 
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
AMD7441: IDE controller at PCI slot 00:07.1 
AMD7441: chipset revision 4 
AMD7441: not 100% native mode: will probe irqs later 
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
AMD_IDE: Advanced Micro Devic AMD-768 [Opus] IDE (rev 04) UDMA100 controller on pci00: 
07.1 
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio 
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA 
hda: MAXTOR 6L060J3, ATA DISK drive 
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive 
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive 
 
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(33)  
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(25) 
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33) 
 
 
hda should be timed to UDMA100 max chipset speed. (but can go UDMA133 if the chipset on 
motherboard could support it). 
 
When looking at the code differences they were minimal so I couldn't see what broke the 
timings.


