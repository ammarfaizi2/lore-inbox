Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUC0WIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUC0WIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:08:00 -0500
Received: from av6-2-sn2.hy.skanova.net ([81.228.8.107]:48323 "EHLO
	av6-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261899AbUC0WH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:07:57 -0500
Cc: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [sata] libata update
From: Henrik Gustafsson <lkml@fnord.se>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Sat, 27 Mar 2004 23:07:55 +0100
Message-ID: <opr5jjrhylesu439@mail1.telia.com>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for screwing with the thread, I was not subscribed when I read the 
original post)

The patch seems to work just fine. It's been running for six hours now 
with varying amounts of load and no catastrophes has occurred so far.

Only things are these lines saying 'abnormal status' (which has been there 
all along). I assume the codes mean 'device not present' (which would be 
correct, at least in my case) or something similar, but I don't know for 
sure so I leave it to someone better informed to patch :)

(also, there is the 'Unknown device'-thing in my lspci, but that's neither 
related to libata nor is it a 'real' problem)

Using a Promise FastTrack S150 SX4
Relevant piece of my dmesg, lspci follows (just let me know if you need 
the rest)

// Henrik Gustafsson

libata version 1.02 loaded.
sata_promise version 0.92
ata1: SATA max UDMA/133 cmd 0xE29D7200 ctl 0xE29D7238 bmdma 0x0 irq 10
ata2: SATA max UDMA/133 cmd 0xE29D7280 ctl 0xE29D72B8 bmdma 0x0 irq 10
ata3: SATA max UDMA/133 cmd 0xE29D7300 ctl 0xE29D7338 bmdma 0x0 irq 10
ata4: SATA max UDMA/133 cmd 0xE29D7380 ctl 0xE29D73B8 bmdma 0x0 irq 10
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors (lba48)
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ATA: abnormal status 0x7F on port 0xE29D729C
ata2: thread exiting
scsi1 : sata_promise
ATA: abnormal status 0x7F on port 0xE29D731C
ata3: thread exiting
scsi2 : sata_promise
ATA: abnormal status 0x7F on port 0xE29D739C
ata4: thread exiting
scsi3 : sata_promise
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write through
  sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

00:0b.0 RAID bus controller: Promise Technology, Inc.: Unknown device 6622 
(rev 01)
         Subsystem: Promise Technology, Inc.: Unknown device 6622
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 96 (1500ns min, 4500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at c400 [size=256]
         Region 1: I/O ports at c800 [size=256]
         Region 2: I/O ports at cc00 [size=256]
         Region 3: Memory at da000000 (32-bit, non-prefetchable) [size=1M]
         Region 4: Memory at da140000 (32-bit, non-prefetchable) [size=32K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

