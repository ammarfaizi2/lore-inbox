Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRHYL4K>; Sat, 25 Aug 2001 07:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbRHYL4C>; Sat, 25 Aug 2001 07:56:02 -0400
Received: from node-cffb924a.powerinter.net ([207.251.146.74]:34878 "HELO
	switchmanagement.com") by vger.kernel.org with SMTP
	id <S268916AbRHYLzx>; Sat, 25 Aug 2001 07:55:53 -0400
Message-ID: <3B879253.2010400@switchmanagement.com>
Date: Sat, 25 Aug 2001 04:56:03 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware: no cards found in 2.2.19, cards found in 2.4.x
In-Reply-To: <E15aKzT-0006BX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

 >Im using one with 2.2.18 fine. Is your bios set for pnp os ?
 >
 >
I modified the setting from "No PNP OS" to "PNP OS", with identical
results (card not found).  Could there be a conflict with another card
only under 2.2.19?  Here is an lspci -vvv (from the 2.4.4-14 kernel):

00:07.0 RAID bus controller: 3ware Inc 3ware ATA-RAID (rev 12)
     Subsystem: 3ware Inc 3ware ATA-RAID
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (2250ns min)
     Interrupt: pin A routed to IRQ 17
     Region 0: I/O ports at 2420 [size=16]
     Expansion ROM at <unassigned> [disabled] [size=64K]

00:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c810 (rev 23)
     Subsystem: Symbios Logic Inc. (formerly NCR) 8100S
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (2000ns min, 16000ns max), cache line size 08
     Interrupt: pin A routed to IRQ 58
     Region 0: I/O ports at 2000 [size=256]
     Region 1: Memory at d0001000 (32-bit, non-prefetchable) [size=256]
     Capabilities: [40] Power Management version 1
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23)
(prog-if 00 [VGA])
     Subsystem: Unknown device 3e3e:003e
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64 (500ns min, 2500ns max)
     Region 0: Memory at d2000000 (32-bit, prefetchable) [size=32M]
     Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
     Expansion ROM at <unassigned> [disabled] [size=32K]

00:0b.0 PIC: Intel Corporation 683053 Programmable Interrupt Device
(prog-if 03)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 0 (2000ns min, 2000ns max)

00:0c.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
     Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 0

00:0c.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64
     Region 4: I/O ports at 2430 [size=16]

00:0c.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64
     Interrupt: pin D routed to IRQ 54
     Region 4: I/O ports at 2400 [size=32]

00:0c.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Interrupt: pin ? routed to IRQ 9

00:10.0 Host bridge: Intel Corporation 450NX - 82451NX Memory & I/O
Controller (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:12.0 Host bridge: Intel Corporation 450NX - 82454NX/84460GX PCI
Expander Bridge (rev 02)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
     Latency: 128, cache line size 08

00:13.0 Host bridge: Intel Corporation 450NX - 82454NX/84460GX PCI
Expander Bridge (rev 02)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
     Latency: 128, cache line size 08

01:01.0 SCSI storage controller: Adaptec AHA-2940U2/W
     Subsystem: Adaptec: Unknown device a180
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (9750ns min, 6250ns max), cache line size 08
     Interrupt: pin A routed to IRQ 19
     BIST result: 00
     Region 0: I/O ports at 3000 [size=256]
     Region 1: Memory at d4004000 (64-bit, non-prefetchable) [size=4K]
     Expansion ROM at <unassigned> [disabled] [size=128K]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 02)
(prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128, cache line size 08
     Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
     I/O behind bridge: 00004000-00004fff
     Memory behind bridge: d4100000-d43fffff
     Prefetchable memory behind bridge: 00000000e0000000-00000000eff00000
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Bridge: PM- B3+

01:03.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c896 (rev 01)
     Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (4250ns min, 16000ns max), cache line size 08
     Interrupt: pin A routed to IRQ 57
     Region 0: I/O ports at 3400 [size=256]
     Region 1: Memory at d4005000 (64-bit, non-prefetchable) [size=1K]
     Region 3: Memory at d4000000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [40] Power Management version 1
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:03.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c896 (rev 01)
     Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (4250ns min, 16000ns max), cache line size 08
     Interrupt: pin B routed to IRQ 56
     Region 0: I/O ports at 3800 [size=256]
     Region 1: Memory at d4005400 (64-bit, non-prefetchable) [size=1K]
     Region 3: Memory at d4002000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [40] Power Management version 1
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 64)
     Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (2500ns min, 2500ns max), cache line size 08
     Interrupt: pin A routed to IRQ 22
     Region 0: I/O ports at 3c00 [size=128]
     Region 1: Memory at d4005800 (32-bit, non-prefetchable) [size=128]
     Expansion ROM at <unassigned> [disabled] [size=128K]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 Memory controller: Distributed Processing Technology Domino RAID
Engine (rev 02)
     Subsystem: Distributed Processing Technology Domino RAID Engine
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B+
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (1000ns min, 2000ns max), cache line size 08
     Interrupt: pin A routed to IRQ 50
     BIST result: 00
     Region 0: Memory at d4100000 (32-bit, non-prefetchable) [size=64K]
     Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]

02:04.0 I2O: Distributed Processing Technology SmartRAID V Controller
(rev 03) (prog-if 01)
     Subsystem: Distributed Processing Technology: Unknown device 50c6
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 128 (250ns min, 250ns max), cache line size 08
     Interrupt: pin A routed to IRQ 20
     BIST result: 00
     Region 0: Memory at d4200000 (32-bit, non-prefetchable) [size=2M]
     Region 1: I/O ports at 4000 [size=256]
     Expansion ROM at 00090000 [disabled] [size=32K]




