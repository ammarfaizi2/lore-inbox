Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSANP3z>; Mon, 14 Jan 2002 10:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSANP3q>; Mon, 14 Jan 2002 10:29:46 -0500
Received: from genesis.westend.com ([212.117.67.2]:23219 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S286821AbSANP3k>; Mon, 14 Jan 2002 10:29:40 -0500
Date: Mon, 14 Jan 2002 16:29:29 +0100
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Cc: info@starline.de
Subject: reproducible SCSI problems with Adaptec and EasyRAID II
Message-ID: <20020114152929.GD6930@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I experience kernel panics whenever I turn on my computer[1] and the
RAID[2] on after they both where off. When resetting or power cycling the
computer alone it works fine afterwards.

This error occurs with two different external cables. 

We had have similar errors a while before (also posted here) that occured 
whenever a scsi tape was in use and never got a working fix. As we're using 
the RAID systems on two other computers and never got it before buying the 
dual cpu (but sadly not exactly but a couple of days after we installed the 
new board) I suspect this to be the cause.

Any help appreciated!

thanks,

 -christian-

[1]: PIII dual cpu 
     Gigabyte GA-6VTXD (with VIA Apollo chipset, latest BIOS version)
     2GB ram
     Adaptec 29160 (BIOS v3.10.0)
     $ lspci 
  00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
  00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
  00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
  00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
  00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
  00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
  00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
  00:0b.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
  01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)

[2]: EasyRAID II external scsi raid with IDE disks running BIOS 2.5E

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x1
scsi1: Dumping Card State while idle, at SEQADDR 0x1
ACCUM = 0x3, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x0
 DFCNTRL = 0x4, DFSTATUS = 0x6d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0x0
STACK == 0x17, 0x19b, 0x0, 0x0
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 2
QINFIFO entries: 2 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 
Pending list: 2
Kernel Free SCB list: 1 0 
Untagged Q(1): 2 
DevQ(0:1:0): 0 waiting
scsi1:0:1:0: Attempting to queue an ABORT message
scsi1: Dumping Card State in Data-out phase, at SEQADDR 0x0
ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x0, SBLKCTL = 0xc0
 DFCNTRL = 0x0, DFSTATUS = 0x29
LASTPHASE = 0x0, SCSISIGI = 0x0, SXFRCTL0 = 0x0
SSTAT0 = 0x0, SSTAT1 = 0x8
STACK == 0x0, 0x0, 0x0, 0x0
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 0
QINFIFO entries: 3 3 
Waiting Queue entries: 0:255 1:255 2:255 
Disconnected Queue entries: 0:255 1:255 2:255 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 
Pending list: 3
Kernel Free SCB list: 1 0 
Untagged Q(1): 3 
DevQ(0:1:0): 0 waiting
qinpos = 1, SCB index = 3
Kernel panic: Loop 1


-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

