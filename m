Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280716AbRKBQOB>; Fri, 2 Nov 2001 11:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280718AbRKBQNv>; Fri, 2 Nov 2001 11:13:51 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:24838 "HELO smeg")
	by vger.kernel.org with SMTP id <S280716AbRKBQNj>;
	Fri, 2 Nov 2001 11:13:39 -0500
Message-ID: <11594.193.132.197.81.1004721119.squirrel@mail.mswinxp.net>
Date: Fri, 2 Nov 2001 17:11:59 -0000 (GMT)
Subject: 2.4.12-ac5 Promise Controller Disk Failure
From: "Lee Packham" <linux@mswinxp.net>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, story goes, with:

Linux smeg.mswinxp.net 2.4.12-ac5 #1 Tue Oct 23 18:31:51 BST 2001 i686 
unknown

My box was running fine with this kernel, but the max uptime I can get is 
about 4-5 days before I get a error that locks the box up tight because it 
appears that the drive fails. The drive is fine. I do not believe this is a 
hardware fault as the drive is not that old and has worked with months of 
uptimes before.

So, here's the stats... If you need anything more, mail me...

lspci -vv (exerpt)

00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20262 
(rev 01)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at a400 [size=8]
        Region 1: I/O ports at a800 [size=4]
        Region 2: I/O ports at ac00 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=64]
        Region 5: Memory at e9000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at e4000000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

/var/log/messages

Nov  1 09:12:00 smeg kernel: hdg: dma_timer_expiry: status=0xd0 { Busy }
Nov  1 09:12:00 smeg kernel: hdg: DMA disabled
Nov  1 09:12:00 smeg kernel: hdg: ide_set_handler: handler not null; 
old=c0190520, new=c0186d70
Nov  1 09:12:00 smeg kernel: bug: kernel timer added twice at c01881f7.
Nov  1 09:12:00 smeg kernel: ide3: reset: success
Nov  1 09:12:13 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:12:13 smeg kernel: hdg: lost interrupt
Nov  1 09:12:23 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:12:23 smeg kernel: hdg: lost interrupt
Nov  1 09:12:33 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:12:33 smeg kernel: hdg: lost interrupt
Nov  1 09:12:43 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:12:43 smeg kernel: hdg: lost interrupt
Nov  1 09:12:53 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:12:53 smeg kernel: hdg: lost interrupt
Nov  1 09:13:03 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:13:03 smeg kernel: hdg: lost interrupt
Nov  1 09:13:13 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:13:13 smeg kernel: hdg: lost interrupt
Nov  1 09:13:23 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:13:23 smeg kernel: hdg: lost interrupt
Nov  1 09:13:33 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:13:33 smeg kernel: hdg: lost interrupt
Nov  1 09:13:43 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:13:43 smeg kernel: hdg: lost interrupt
Nov  1 09:13:53 smeg kernel: ide_dmaproc: chipset supported ide_dma_lostirq 
func only: 13
Nov  1 09:13:53 smeg kernel: hdg: lost interrupt

