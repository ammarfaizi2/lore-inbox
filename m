Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUCWLHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUCWLHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:07:34 -0500
Received: from box.punkt.pl ([217.8.180.66]:31759 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262473AbUCWLH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:07:28 -0500
Message-ID: <40601966.3010706@punkt.pl>
Date: Tue, 23 Mar 2004 12:03:02 +0100
From: |TEcHNO| <techno@punkt.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, ja, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.x][2.6.x]EIO AP-1600 ATA133 Controller Card 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I recently bought this card, hopeing that it woudl work under linux, 
even the manufacurers page say's so. But afer installing it I found out 
that both 2.4.22, 2.4.25 and 2.6.4 fail to work with it correctly. They 
all report:

SiI680: IDE controller at PCI slot 00:0d.0
PCI: Found IRQ 9 for device 00:0d.0
PCI: Sharing IRQ 9 with 00:09.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: ST330621A, ATA DISK drive
hdb: ST3120026A, ATA DISK drive
blk: queue c0526860, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c052699c, I/O limit 4095Mb (mask 0xffffffff)
hdc: ST3120026A, ATA DISK drive
blk: queue c0526cb4, I/O limit 4095Mb (mask 0xffffffff)
hdf: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
hdf: set_drive_speed_status: status=0x41 { DriveReady Error }
hdf: set_drive_speed_status: error=0x04
hdf: set_drive_speed_status: status=0x41 { DriveReady Error }
hdf: set_drive_speed_status: error=0x04
hdf: set_drive_speed_status: status=0x41 { DriveReady Error }
hdf: set_drive_speed_status: error=0x04
hdh: LG CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
hdh: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdh: set_drive_speed_status: error=0x04
hdh: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdh: set_drive_speed_status: error=0x04
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xc8810e80-0xc8810e87,0xc8810e8a on irq 9
ide3 at 0xc8810ec0-0xc8810ec7,0xc8810eca on irq 9

sometimes it's a bit diffrent(ie. last time hdf reported hdh error, and 
hdh none), but the CD's work (read and write alike).
If I connect some HDD's they report hdh error, and then a number of 
other errors (which I don't have written, but they look like data 
gathering information errors). Sometimes it even detects my HDD's as 2TB 
drives and such (after reporting some errors) but even watinga lot 
didn't prove to help, it simply stops somewhere there.

The chipset is exactly Sil0680ACL144. Controller BIOS 3.0.77.

lspci -vvvvv

00:0d.0 Unknown mass storage controller: CMD Technology Inc PCI0680 (rev 02)
         Subsystem: CMD Technology Inc PCI0680
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 01
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at c400 [size=8]
         Region 1: I/O ports at c000 [size=4]
         Region 2: I/O ports at bc00 [size=8]
         Region 3: I/O ports at b800 [size=4]
         Region 4: I/O ports at b400 [size=16]
         Region 5: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at dff00000 [disabled] [size=512K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Hope this helps, I'm nto subscribed so pleas CC: to me.
I'm willing to help in testing of any patches etc.

-- 
pozdrawiam     |"Help me master, I felt the burning twilight behind
techno@punkt.pl|those gates of stell..." --Perihelion, Prophecy Sequence
