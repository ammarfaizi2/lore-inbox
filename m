Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVCUWTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVCUWTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVCUWTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:19:22 -0500
Received: from sccimhc91.asp.att.net ([63.240.76.165]:8621 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S261905AbVCUWTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:19:02 -0500
From: Jay Roplekar <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [SATA] sata-via : bug?
Date: Mon, 21 Mar 2005 16:18:16 -0600
User-Agent: KMail/1.7
Cc: jay_roplekar@hotmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211618.16942.jay_roplekar@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I  have  a brand new Western Digital sata drive, VIA KT600  based ECS 
motherboard on which I am trying to install various distros (with installers 
based on 2.4.26, 2.6.7, 2.6.8, 2.6.11 etc)  all of them fail to detect the HD 
(and bomb out) because sata-via is ignoring it .  I have only one disk, I am 
not interested in raid.
 
 lspci which tells me it is VIA 6420 and should be  supported based on 
sata-via.c.   Following are syslog snippets that show more.
I would appreciate your help in resolving this. Thanks,

Jay
##
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Capabilities: [80] Power Management version 2

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
        Subsystem: Elitegroup Computer Systems: Unknown device 1884
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b000 [size=8]
        I/O ports at b400 [size=4]
        I/O ports at b800 [size=8]
        I/O ports at bc00 [size=4]
        I/O ports at c000 [size=16]
        I/O ports at c400 [size=256]
        Capabilities: [c0] Power Management version 2

##Dmesg when I connect the disk on channel 1
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
##with disk on second channel following
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: dev 0 cfg 49:3030 82:0078 83:0078 84:0078 85:0000 86:0000 87:0000 
88:0000
ata2: no dma/lba
ata2: dev 0 not supported, ignoring
scsi1 : sata_via
## I took this disk and sata cable on a different (ICH5 based) motherboard and 
## knoppix detected the disk ok and associated sda with it. 
