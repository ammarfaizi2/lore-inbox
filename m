Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274118AbSITARK>; Thu, 19 Sep 2002 20:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274119AbSITARK>; Thu, 19 Sep 2002 20:17:10 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:40853 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S274118AbSITARJ>; Thu, 19 Sep 2002 20:17:09 -0400
Date: Thu, 19 Sep 2002 20:21:49 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7-ac2 ide-scsi
Message-ID: <20020920002149.GA11605@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Is ide-scsi supposed to be broke in -pre7-ac2?
 
 [grimau@Master grimau]$ cdrecord --scanbus
 Cdrecord 1.11a32 (i586-mandrake-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
 Linux sg driver version: 3.1.24
 Using libscg version 'schily-0.6'
 scsibus0:
 (garbage characters) Removable unsupported Disk <-- this line changes each time
         0,1,0     1) *
 ...
 
 in dmesg I have:
 ...
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SIS5513: IDE controller at PCI slot 00:02.5
 SIS5513: chipset revision 208
 SIS5513: not 100% native mode: will probe irqs later
 SiS646    ATA 133 controller
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
 hda: Maxtor 4G100J5, ATA DISK drive
 blk: queue c03d4400, I/O limit 4095Mb (mask 0xffffffff)
 hdc: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
 hdd: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: host protected area => 1
 hda: 200108160 sectors (102455 MB) w/2048KiB Cache, CHS=12456/255/63, UDMA(133)
 hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.12
 Partition check:
  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
 SCSI subsystem driver Revision: 1.00
 ...
 <bunch of not-scsi & not-IDE stuff>
 ...
 scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x12 00 00 00 ff 00 
 hdc: lost interrupt
   Vendor:  TÐ÷0123  Model: 456789abcdefghij  Rev: klmn
   Type:   Direct-Access                      ANSI SCSI revision: 07
 ...
 
 I'm sure I missed some info that may be helpful, so lemme know if/what you need.
 

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.openprojects.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

