Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317877AbSGaJha>; Wed, 31 Jul 2002 05:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317875AbSGaJha>; Wed, 31 Jul 2002 05:37:30 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:60346 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317877AbSGaJh0>; Wed, 31 Jul 2002 05:37:26 -0400
Date: Wed, 31 Jul 2002 11:40:49 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DEC PCI-to-PCI bridge problem ?
Message-ID: <20020731094049.GC6332@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020731092803.GB6332@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731092803.GB6332@tahoe.alcove-fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 11:28:03AM +0200, Stelian Pop wrote:

> Hi,
> 
> I have a machine with (see lspci at the end):
> 	* intel motherboard (82443BX + 82371EB)
> 	* DEC PCI-to-PCI bridges (0x0022 0x1011)
> 	* several communication cards behind the bridges.

Oops, lspci attached now:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: d4000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 07 01 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 f0 00 a0 a2
20: 00 d4 f0 d7 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at c800 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100B (TX)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e1200000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at cc00 [size=64]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 07 00 90 02 08 00 00 02 08 20 00 00
10: 00 00 20 e1 01 cc 00 00 00 00 00 e1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 01 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 08 38

00:11.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at c000 [disabled] [size=256]
	Region 1: Memory at e1201000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 80 00 06 00 b0 02 02 00 00 01 08 20 00 80
10: 01 c0 00 00 04 10 20 e1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 a0 e2
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 28 19

00:12.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e1202000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at c400 [size=64]
	Region 2: Memory at e1100000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 07 00 90 02 08 00 00 02 08 20 00 00
10: 00 20 20 e1 01 c4 00 00 00 00 10 e1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: d9000000-ddffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
00: 11 10 22 00 07 01 90 02 06 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 91 a1 80 22
20: 00 d9 f0 dd f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 00

00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: de000000-e0ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
00: 11 10 22 00 07 01 90 02 06 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 20 b1 b1 80 22
20: 00 de f0 e0 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 00

01:00.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev b1) (prog-if 00 [VGA])
	Subsystem: Silicon Motion, Inc. SM720 Lynx3DM
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x2
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x2
00: 6f 12 20 07 1f 00 30 02 b1 00 00 03 00 20 00 00
10: 00 00 00 d4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 6f 12 20 07
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00

02:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dd907000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 9000 [size=64]
	Region 2: Memory at dd800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 07 00 90 02 08 00 00 02 08 20 00 00
10: 00 70 90 dd 01 90 00 00 00 00 80 dd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 38

02:09.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dd903000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at 9400 [size=128]
	Region 2: Memory at da000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 30 90 dd 01 94 00 00 00 00 00 da 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

02:0a.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dd901000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at 9800 [size=128]
	Region 2: Memory at da800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 10 90 dd 01 98 00 00 00 00 80 da 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

02:0b.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dd905000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at 9c00 [size=128]
	Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 50 90 dd 01 9c 00 00 00 00 00 db 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00

02:0c.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dd900000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at a000 [size=128]
	Region 2: Memory at db800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 00 90 dd 01 a0 00 00 00 00 80 db 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

02:0d.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dd902000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at a400 [size=128]
	Region 2: Memory at dc000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 20 90 dd 01 a4 00 00 00 00 00 dc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

02:0e.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dd904000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at a800 [size=128]
	Region 2: Memory at dc800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 40 90 dd 01 a8 00 00 00 00 80 dc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

02:0f.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dd906000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at ac00 [size=128]
	Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 60 90 dd 01 ac 00 00 00 00 00 dd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00

03:08.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0800000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at b000 [size=128]
	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 00 80 e0 01 b0 00 00 00 00 00 df 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00

03:09.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0802000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at b400 [size=128]
	Region 2: Memory at df800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 20 80 e0 01 b4 00 00 00 00 80 df 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

03:0a.0 Communication controller: Performance Technologies, Inc.: Unknown device 0334 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0801000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at b800 [size=128]
	Region 2: Memory at e0000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 14 12 34 03 07 00 80 02 10 00 80 07 00 20 00 00
10: 00 10 80 e0 01 b8 00 00 00 00 00 e0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00


-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
