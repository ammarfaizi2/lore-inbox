Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbTC1Uv7>; Fri, 28 Mar 2003 15:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263140AbTC1Uv7>; Fri, 28 Mar 2003 15:51:59 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:50304 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S263135AbTC1Uv5>;
	Fri, 28 Mar 2003 15:51:57 -0500
Subject: RE: [2.5.66] Enormous interrupt load with ACPI
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A239@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A239@orsmsx401.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048885449.701.8.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Mar 2003 23:04:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> Can you look at /proc/interrupts and tell me if irq 9 is shared with
> anyone else, especially PCI devices?

Doesn't seem that way.

	MikaL
--
           CPU0       CPU1
  0:     722746     889567    IO-APIC-edge  timer
  1:       2929          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  5:       2625          1    IO-APIC-edge  soundblaster
  8:          4          0    IO-APIC-edge  rtc
  9:   69687588   62077091   IO-APIC-level  acpi
 12:      49989          1    IO-APIC-edge  i8042
 14:      28147          1    IO-APIC-edge  ide0
 15:         95          1    IO-APIC-edge  ide1
 18:       8663          0   IO-APIC-level  eth0
NMI:    1612256    1612116
LOC:    1612201    1612200
ERR:          0
MIS:          0


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e8ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e400 [size=32]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2



