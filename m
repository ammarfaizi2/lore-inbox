Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSJEEZp>; Sat, 5 Oct 2002 00:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSJEEZp>; Sat, 5 Oct 2002 00:25:45 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:34016 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262020AbSJEEZo>; Sat, 5 Oct 2002 00:25:44 -0400
Date: Sat, 5 Oct 2002 00:31:16 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre8-ac3
Message-ID: <20021005043116.GD2940@Master.Wizards>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200209302029.g8UKTfG12427@devserv.devel.redhat.com> <3D9D9DD7.16EC9B3C@bigpond.com> <1033748526.31839.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033748526.31839.43.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 05:22:06PM +0100, Alan Cox wrote:
> On Fri, 2002-10-04 at 14:55, Allan Duncan wrote:
> > Is the -ac series ide-scsi still in the yet-to-be-fixed category?
> 
> It should work
> 
 
Not here - hasn't worked in a long time
All "not -ac" 2.4.x kernels work fine, but they also do not do
ATA/133 for this chipset (in case that's relevant)
 
 ASUS P4S533 (SiS645DX chipset)
 P4 2Ghz cpu
 1G PC2700 RAM
 nvidia GF2 GTS (using XFree86 nv driver, not nvidia binary)
 hda: Maxtor 4G100J5, ATA DISK drive
 hdc: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
 hdd: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
 
 append=" devfs=mount hdc=ide-scsi" in lilo.conf
 
 dmesg output:
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SIS5513: IDE controller at PCI slot 00:02.5
 SIS5513: chipset revision 208
 SIS5513: not 100% native mode: will probe irqs later
 SiS646    ATA 133 controller
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
 hda: Maxtor 4G100J5, ATA DISK drive
 blk: queue c036e720, I/O limit 4095Mb (mask 0xffffffff)
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
  
 ........ (other stuff like ieee1394) ......
 
 SCSI subsystem driver Revision: 1.00
 scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x12 00 00 00 ff 00 
 hdc: lost interrupt
   Vendor:     0123  Model: 456789abcdefghij  Rev: klmn
   Type:   Direct-Access                      ANSI SCSI revision: 07
 

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

