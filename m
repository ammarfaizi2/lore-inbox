Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVCTBE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVCTBE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 20:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVCTBE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 20:04:28 -0500
Received: from sccimhc91.asp.att.net ([63.240.76.165]:20201 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S261954AbVCTBET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 20:04:19 -0500
From: Jay Roplekar <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: SATA  VIA8237 Problems (Install)
Date: Sat, 19 Mar 2005 19:03:35 -0600
User-Agent: KMail/1.7
Cc: jay_roplekar@hotmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503191903.36102.jay_roplekar@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a KT600 based motherboard & I am planning to set up my new system using 
that.  It has onboard via 8237 sata {raid, cough cough} controller. I am 
planning to use a single sata disk (I am not interested in raid).   The 
various distro installers are having tough time noticing a brand new western 
digital disk.  Following is the dmesg from the installer :

##
libata version 1.10 loaded.
sata_via version 1.1
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 11 (level, low) -> IRQ 11
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xB000 ctl 0xB402 bmdma 0xC000 irq 11
ata2: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC008 irq 11
ata1: dev 0 cfg 49:3030 82:0078 83:0078 84:0000 85:0000 86:3fff 87:0010 
88:000f
ata1: no dma/lba
ata1: dev 0 not supported, ignoring
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
###

Is the line  "ata1: dev 0 not supported, ignoring" expected?    Is there 
something basic I am missing. I would appreciate any help.  
I have tried to digest info on Jeff Garzik's linux.yyz.us/sata/  and also 
www.linuxmafia.com/faq/Hardware/sata.html  but its quite possible I might 
have misinterpreted it.  FWIW,  the installer is 2.6.11-1 based  and  
following modules are present in the system. Thanks,

Jay 

####
odule                  Size  Used by    Not tainted
parport_pc 28805 0 - Live 0xd0a1c000
parport 39689 1 parport_pc, Live 0xd09d5000
dm_snapshot 17797 0 - Live 0xd097a000
dm_mirror 25389 0 - Live 0xd0998000
dm_zero 2497 0 - Live 0xd081b000
dm_mod 61013 3 dm_snapshot,dm_mirror,dm_zero, Live 0xd0a25000
xfs 586897 0 - Live 0xd0c0f000
exportfs 8513 1 xfs, Live 0xd0902000
jfs 203897 0 - Live 0xd0ae9000
reiserfs 267317 0 - Live 0xd0aa6000
ext3 133065 0 - Live 0xd0a39000
jbd 79065 1 ext3, Live 0xd09fc000
msdos 8641 0 - Live 0xd0906000
raid6 107345 0 - Live 0xd09e0000
raid5 28737 0 - Live 0xd098f000
xor 15305 2 raid6,raid5, Live 0xd0939000
raid1 21441 0 - Live 0xd08ab000
raid0 8513 0 - Live 0xd08fe000
sata_via 8389 0 - Live 0xd08d0000
libata 47429 1 sata_via, Live 0xd0982000
via_rhine 27209 0 - Live 0xd0931000
mii 4929 1 via_rhine, Live 0xd0894000
uhci_hcd 33497 0 - Live 0xd090a000
ehci_hcd 39245 0 - Live 0xd0926000
sr_mod 19173 0 - Live 0xd08ca000
sd_mod 19137 0 - Live 0xd08b2000
scsi_mod 138665 3 libata,sr_mod,sd_mod, Live 0xd09a0000
edd 9889 0 - Live 0xd0890000
floppy 63729 0 - Live 0xd0915000
