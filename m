Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTLHUEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTLHUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:04:24 -0500
Received: from ppp-62-245-161-4.mnet-online.de ([62.245.161.4]:64641 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S261753AbTLHUCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:02:45 -0500
To: Len Brown <len.brown@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: balance interrupts
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
	<1070911748.2408.39.camel@dhcppc4>
	<frodoid.frodo.8765grkrkb.fsf@usenet.frodoid.org>
From: Julien Oster <lkml-2315@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Mon, 08 Dec 2003 21:02:30 +0100
In-Reply-To: <frodoid.frodo.8765grkrkb.fsf@usenet.frodoid.org> (Julien
 Oster's message of "Mon, 08 Dec 2003 21:00:52 +0100")
Message-ID: <frodoid.frodo.871xrfkrhl.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Julien Oster <lkml-2315@mc.frodoid.org> writes:

(quoting myself)

> Hmm. I got pciutils 2.1.11 (those claim to be the latest), but my
> lspci doesn't know "-l". I attached the output of lspci -vvv to this
> mail, however. Maybe it's of any use.
>
> I attached the output of acpidmp to this mail as well. It's a
> collection of hexdumps. Since I have no internal knowledge about ACPI
> or IO-APICs, I can't do anything with it...

Silly me, I forgot actually attaching the files to my mail. Here they
go.


--=-=-=
Content-Disposition: attachment; filename=lspci-vvv.txt
Content-Description: output of lspci -vvv

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at e000 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ed084000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at ed082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at ed083000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at d000 [size=256]
	Region 1: I/O ports at d400 [size=128]
	Region 2: Memory at ed080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000cfff
	Memory behind bridge: e9000000-ecffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e6000000-e8ffffff
	Prefetchable memory behind bridge: e4000000-e5ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:08.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e9000000-eaffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at b000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at b400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 6112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x01 (4 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at b800 [size=8]
	Region 1: I/O ports at bc00 [size=4]
	Region 2: I/O ports at c000 [size=8]
	Region 3: I/O ports at c400 [size=4]
	Region 4: I/O ports at c800 [size=16]
	Region 5: Memory at ec000000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at a800 [size=128]
	Region 1: Memory at ea002000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at ac00 [size=128]
	Region 1: Memory at ea003000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=acpi.dump
Content-Description: output of acpidmp

RSDP "Nvidia" @ 0x000f75e0
  0000: 52 53 44 20 50 54 52 20 18 4e 76 69 64 69 61 00  RSD PTR .Nvidia.
  0010: 00 30 ff 3f                                      .0.?

RSDT @ 0x3fff3000
  0000: 52 53 44 54 2c 00 00 00 01 d1 4e 76 69 64 69 61  RSDT,.....Nvidia
  0010: 41 57 52 44 41 43 50 49 31 2e 30 42 41 57 52 44  AWRDACPI1.0BAWRD
  0020: 00 00 00 00 40 30 ff 3f c0 74 ff 3f              ....@0.?.t.?

FACP @ 0x3fff3040
  0000: 46 41 43 50 74 00 00 00 01 29 4e 76 69 64 69 61  FACPt....)Nvidia
  0010: 41 57 52 44 41 43 50 49 31 2e 30 42 41 57 52 44  AWRDACPI1.0BAWRD
  0020: 00 00 00 00 00 00 ff 3f c0 30 ff 3f 01 00 09 00  .......?.0.?....
  0030: 2e 44 00 00 a1 a0 00 00 00 40 00 00 00 00 00 00  .D.......@......
  0040: 04 40 00 00 00 00 00 00 00 00 00 00 08 40 00 00  .@...........@..
  0050: 20 40 00 00 a0 44 00 00 04 02 00 04 08 10 20 00   @...D........ .
  0060: 65 00 e9 03 00 00 00 00 01 00 7d 7e 32 00 00 00  e.........}~2...
  0070: a5 04 00 00                                      ....

DSDT @ 0x3fff30c0
  0000: 44 53 44 54 e7 43 00 00 01 b2 4e 56 49 44 49 41  DSDT.C....NVIDIA
  0010: 41 57 52 44 41 43 50 49 00 10 00 00 4d 53 46 54  AWRDACPI....MSFT
  0020: 0e 00 00 01 10 19 5c 5f 50 52 5f 5b 83 11 5c 2e  ......\_PR_[..\.
  0030: 5f 50 52 5f 43 50 55 30 00 00 00 00 00 00 08 5c  _PR_CPU0.......\
  0040: 5f 53 30 5f 12 0a 04 0a 00 0a 00 0a 00 0a 00 08  _S0_............
  0050: 5c 5f 53 31 5f 12 0a 04 0a 01 0a 01 0a 00 0a 00  \_S1_...........
  0060: 08 5c 53 53 33 5f 12 0a 04 0a 05 0a 05 0a 00 0a  .\SS3_..........
  0070: 00 08 5c 5f 53 34 5f 12 0a 04 0a 06 0a 06 0a 00  ..\_S4_.........
  0080: 0a 00 08 5c 5f 53 35 5f 12 0a 04 0a 07 0a 07 0a  ...\_S5_........
  0090: 00 0a 00 5b 80 5c 44 45 42 47 01 0a 80 0a 01 5b  ...[.\DEBG.....[
  00a0: 81 0c 5c 44 45 42 47 01 44 42 47 31 08 5b 80 5a  ..\DEBG.DBG1.[.Z
  00b0: 30 30 32 01 0a 21 0a 01 5b 81 0b 5a 30 30 32 01  002..!..[..Z002.
  00c0: 5a 30 30 30 08 5b 80 4b 42 43 5f 01 0a 64 0a 01  Z000.[.KBC_..d..
  00d0: 5b 81 0b 4b 42 43 5f 01 4b 43 4d 44 08 5b 80 45  [..KBC_.KCMD.[.E
  00e0: 58 54 4d 00 0c 30 f8 0f 00 0a 10 5b 81 29 45 58  XTM..0.....[.)EX
  00f0: 54 4d 02 52 4f 4d 31 10 52 4d 53 31 10 52 4f 4d  TM.ROM1.RMS1.ROM
  0100: 32 10 52 4d 53 32 10 52 4f 4d 33 10 52 4d 53 33  2.RMS2.ROM3.RMS3
  0110: 10 41 4d 45 4d 20 5b 80 5c 50 4d 31 53 01 0b 00  .AMEM [.\PM1S...
  0120: 40 0a 02 5b 81 1c 5c 50 4d 31 53 01 00 08 50 42  @..[..\PM1S...PB
  0130: 54 53 01 00 01 52 54 43 53 01 00 04 57 41 4b 53  TS...RTCS...WAKS
  0140: 01 5b 80 45 4c 43 52 01 0b d0 04 0a 02 5b 81 10  .[.ELCR......[..
  0150: 45 4c 43 52 01 45 4c 43 31 08 45 4c 43 32 08 5b  ELCR.ELC1.ELC2.[
  0160: 80 5c 53 54 55 53 01 0b 00 44 0a 04 5b 81 0c 5c  .\STUS...D..[..\
  0170: 53 54 55 53 01 47 5f 53 54 20 5b 80 5c 53 4d 49  STUS.G_ST [.\SMI
  0180: 53 01 0b 20 40 0a 04 5b 81 0c 5c 53 4d 49 53 01  S.. @..[..\SMIS.
  0190: 50 5f 32 30 20 5b 80 5c 53 4d 49 43 01 0b 2e 44  P_20 [.\SMIC...D
  01a0: 0a 01 5b 81 0c 5c 53 4d 49 43 01 53 43 50 5f 08  ..[..\SMIC.SCP_.
  01b0: 5b 80 5c 47 50 31 5f 01 0b c0 44 0a 32 5b 81 4f  [.\GP1_...D.2[.O
  01c0: 0f 5c 47 50 31 5f 01 47 50 30 30 08 47 50 30 31  .\GP1_.GP00.GP01
  01d0: 08 47 50 30 32 08 47 50 30 33 08 47 50 30 34 08  .GP02.GP03.GP04.
  01e0: 47 50 30 35 08 47 50 30 36 08 47 50 30 37 08 47  GP05.GP06.GP07.G
  01f0: 50 30 38 08 47 50 30 39 08 47 50 31 30 08 47 50  P08.GP09.GP10.GP
  0200: 31 31 08 47 50 31 32 08 47 50 31 33 08 47 50 31  11.GP12.GP13.GP1
  0210: 34 08 47 50 31 35 08 47 50 31 36 08 47 50 31 37  4.GP15.GP16.GP17
  0220: 08 47 50 31 38 08 47 50 31 39 08 47 50 32 30 08  .GP18.GP19.GP20.
  0230: 47 50 32 31 08 47 50 32 32 08 00 08 47 50 32 34  GP21.GP22...GP24
  0240: 08 47 50 32 35 08 47 50 32 36 08 47 50 32 37 08  .GP25.GP26.GP27.
  0250: 47 50 32 38 08 47 50 32 39 08 47 50 33 30 08 47  GP28.GP29.GP30.G
  0260: 50 33 31 08 47 50 33 32 08 47 50 33 33 08 47 50  P31.GP32.GP33.GP
  0270: 33 34 08 47 50 33 35 08 47 50 33 36 08 47 50 33  34.GP35.GP36.GP3
  0280: 37 08 47 50 33 38 08 47 50 33 39 08 47 50 34 30  7.GP38.GP39.GP40
  0290: 08 47 50 34 31 08 47 50 34 32 08 47 50 34 33 08  .GP41.GP42.GP43.
  02a0: 47 50 34 34 08 47 50 34 35 08 47 50 34 36 08 47  GP44.GP45.GP46.G
  02b0: 50 34 37 08 47 50 34 38 08 47 50 34 39 08 08 4f  P47.GP48.GP49..O
  02c0: 53 46 58 0a 01 08 4f 53 46 4c 0a 01 14 41 05 53  SFX...OSFL...A.S
  02d0: 54 52 43 02 a0 0a 92 93 87 68 87 69 a4 0a 00 72  TRC......h.i...r
  02e0: 87 68 0a 01 60 08 42 55 46 30 11 02 60 08 42 55  .h..`.BUF0..`.BU
  02f0: 46 31 11 02 60 70 68 42 55 46 30 70 69 42 55 46  F1..`phBUF0piBUF
  0300: 31 a2 1a 60 76 60 a0 15 92 93 83 88 42 55 46 30  1..`v`......BUF0
  0310: 60 00 83 88 42 55 46 31 60 00 a4 00 a4 01 5b 80  `...BUF1`.....[.
  0320: 52 54 43 4d 01 0a 70 0a 02 5b 81 10 52 54 43 4d  RTCM..p..[..RTCM
  0330: 01 43 4d 49 4e 08 43 4d 44 41 08 5b 86 12 43 4d  .CMIN.CMDA.[..CM
  0340: 49 4e 43 4d 44 41 01 00 48 07 53 48 55 54 08 5b  INCMDA..H.SHUT.[
  0350: 80 49 4e 46 4f 00 0c 40 f8 0f 00 0a 01 5b 81 24  .INFO..@.....[.$
  0360: 49 4e 46 4f 01 4b 42 44 49 01 52 54 43 57 01 50  INFO.KBDI.RTCW.P
  0370: 53 32 46 01 49 52 46 4c 02 44 49 53 45 01 53 53  S2F.IRFL.DISE.SS
  0380: 48 55 01 5b 80 42 45 45 50 01 0a 61 0a 01 5b 81  HU.[.BEEP..a..[.
  0390: 0b 42 45 45 50 01 53 31 42 5f 08 5b 80 43 4f 4e  .BEEP.S1B_.[.CON
  03a0: 54 01 0a 40 0a 04 5b 81 1a 43 4f 4e 54 01 43 4e  T..@..[..CONT.CN
  03b0: 54 30 08 43 4e 54 31 08 43 4e 54 32 08 43 54 52  T0.CNT1.CNT2.CTR
  03c0: 4c 08 14 43 06 53 50 4b 52 01 70 53 31 42 5f 60  L..C.SPKR.pS1B_`
  03d0: 70 0a b6 43 54 52 4c 70 0a 55 43 4e 54 32 70 0a  p..CTRLp.UCNT2p.
  03e0: 03 43 4e 54 32 70 68 62 a2 37 94 62 0a 00 7d 53  .CNT2phb.7.b..}S
  03f0: 31 42 5f 0a 03 53 31 42 5f 70 0b ff 5f 63 a2 07  1B_..S1B_p.._c..
  0400: 94 63 0a 00 76 63 7b 53 31 42 5f 0a fc 53 31 42  .c..vc{S1B_..S1B
  0410: 5f 70 0b ff 0e 63 a2 07 94 63 0a 00 76 63 76 62  _p...c...c..vcvb
  0420: 70 60 53 31 42 5f 10 17 5c 00 08 50 49 43 46 0a  p`S1B_..\..PICF.
  0430: 00 14 0c 5f 50 49 43 01 70 68 50 49 43 46 08 53  ..._PIC.phPICF.S
  0440: 49 44 34 0a 00 08 53 4c 47 30 0a 00 08 53 4c 47  ID4...SLG0...SLG
  0450: 31 0a 00 08 53 4c 47 32 0a 00 08 53 4c 47 33 0a  1...SLG2...SLG3.
  0460: 00 08 53 4c 47 34 0a 00 08 53 4c 47 35 0a 00 08  ..SLG4...SLG5...
  0470: 53 4c 47 36 0a 00 08 53 4c 47 37 0a 00 08 53 4c  SLG6...SLG7...SL
  0480: 47 38 0a 00 08 53 4c 47 39 0a 00 08 53 4c 47 41  G8...SLG9...SLGA
  0490: 0a 00 08 53 49 44 35 0a 00 08 53 53 4d 30 0a 00  ...SID5...SSM0..
  04a0: 08 53 53 4d 31 0a 00 08 53 53 4d 32 0a 00 08 53  .SSM1...SSM2...S
  04b0: 53 4d 33 0a 00 08 53 53 4d 34 0a 00 08 53 55 41  SM3...SSM4...SUA
  04c0: 30 0a 00 08 53 55 42 30 0a 00 08 53 58 5f 5f 0a  0...SUB0...SX__.
  04d0: 00 08 53 46 4c 47 0a 00 08 53 49 44 30 0a 00 08  ..SFLG...SID0...
  04e0: 53 49 44 31 0a 00 08 53 49 44 32 0a 00 08 53 49  SID1...SID2...SI
  04f0: 44 33 0a 00 14 45 12 5c 5f 50 54 53 01 70 68 60  D3...E.\_PTS.ph`
  0500: 70 60 53 58 5f 5f 7d 68 0a f0 60 70 60 44 42 47  p`SX__}h..`p`DBG
  0510: 31 4f 53 54 50 70 5c 2f 04 5f 53 42 5f 50 43 49  1OSTPp\/._SB_PCI
  0520: 30 49 44 45 30 49 44 32 30 53 49 44 30 70 5c 2f  0IDE0ID20SID0p\/
  0530: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 49 44 54  ._SB_PCI0IDE0IDT
  0540: 53 53 49 44 31 70 5c 2f 04 5f 53 42 5f 50 43 49  SSID1p\/._SB_PCI
  0550: 30 49 44 45 30 49 44 54 50 53 49 44 32 70 5c 2f  0IDE0IDTPSID2p\/
  0560: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 49 44 32  ._SB_PCI0IDE0ID2
  0570: 32 53 49 44 33 70 5c 2f 04 5f 53 42 5f 50 43 49  2SID3p\/._SB_PCI
  0580: 30 49 44 45 30 55 4d 53 53 53 49 44 34 70 5c 2f  0IDE0UMSSSID4p\/
  0590: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 55 4d 53  ._SB_PCI0IDE0UMS
  05a0: 50 53 49 44 35 a0 2f 93 68 0a 01 70 5c 2f 03 5f  PSID5./.h..p\/._
  05b0: 53 42 5f 50 43 49 30 43 54 4c 30 60 7d 60 0c 00  SB_PCI0CTL0`}`..
  05c0: 00 00 04 60 70 60 5c 2f 03 5f 53 42 5f 50 43 49  ...`p`\/._SB_PCI
  05d0: 30 43 54 4c 30 a0 2f 93 68 0a 03 70 5c 2f 03 5f  0CTL0./.h..p\/._
  05e0: 53 42 5f 50 43 49 30 43 54 4c 30 60 7d 60 0c 00  SB_PCI0CTL0`}`..
  05f0: 00 00 04 60 70 60 5c 2f 03 5f 53 42 5f 50 43 49  ...`p`\/._SB_PCI
  0600: 30 43 54 4c 30 a0 14 93 68 0a 05 a0 0e 92 93 4f  0CTL0...h......O
  0610: 53 46 4c 0a 00 5b 22 0b f4 01 14 49 0c 5c 5f 57  SFL..["....I.\_W
  0620: 41 4b 01 70 0a ff 44 42 47 31 70 0a 00 53 46 4c  AK.p..DBG1p..SFL
  0630: 47 a0 15 93 52 54 43 57 0a 00 86 5c 2e 5f 53 42  G...RTCW...\._SB
  0640: 5f 50 57 52 42 0a 02 86 5c 2f 03 5f 53 42 5f 50  _PWRB...\/._SB_P
  0650: 43 49 30 55 53 42 30 0a 00 86 5c 2f 03 5f 53 42  CI0USB0...\/._SB
  0660: 5f 50 43 49 30 55 53 42 31 0a 00 70 5c 2f 03 5f  _PCI0USB1..p\/._
  0670: 53 42 5f 50 43 49 30 43 54 4c 30 60 7b 60 0c ff  SB_PCI0CTL0`{`..
  0680: ff ff fb 60 70 60 5c 2f 03 5f 53 42 5f 50 43 49  ...`p`\/._SB_PCI
  0690: 30 43 54 4c 30 a0 4e 04 92 95 4f 53 46 4c 0a 01  0CTL0.N...OSFL..
  06a0: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 53 4d  p..\/._SB_PCI0SM
  06b0: 42 30 53 4d 50 4d 70 0b 00 50 5c 2f 04 5f 53 42  B0SMPMp..P\/._SB
  06c0: 5f 50 43 49 30 53 4d 42 30 53 42 31 5f 70 0b 00  _PCI0SMB0SB1_p..
  06d0: 55 5c 2f 04 5f 53 42 5f 50 43 49 30 53 4d 42 30  U\/._SB_PCI0SMB0
  06e0: 53 42 32 5f 10 49 04 5c 5f 53 49 5f 14 20 5f 4d  SB2_.I.\_SI_. _M
  06f0: 53 47 01 70 0d 3d 3d 3d 3d 20 4d 53 47 20 57 6f  SG.p.==== MSG Wo
  0700: 72 6b 69 6e 67 20 3d 3d 3d 3d 00 5b 31 14 20 5f  rking ====.[1. _
  0710: 53 53 54 01 70 0d 3d 3d 3d 3d 20 53 53 54 20 57  SST.p.==== SST W
  0720: 6f 72 6b 69 6e 67 20 3d 3d 3d 3d 00 5b 31 10 48  orking ====.[1.H
  0730: 0e 5c 5f 47 50 45 14 18 5f 4c 30 30 00 86 5c 2f  .\_GPE.._L00..\/
  0740: 03 5f 53 42 5f 50 43 49 30 48 55 42 30 0a 02 14  ._SB_PCI0HUB0...
  0750: 18 5f 4c 30 33 00 86 5c 2f 03 5f 53 42 5f 50 43  ._L03..\/._SB_PC
  0760: 49 30 55 41 52 31 0a 02 14 18 5f 4c 30 42 00 86  I0UAR1...._L0B..
  0770: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 4d 41 43 0a  \/._SB_PCI0MMAC.
  0780: 02 14 18 5f 4c 30 44 00 86 5c 2f 03 5f 53 42 5f  ..._L0D..\/._SB_
  0790: 50 43 49 30 55 53 42 30 0a 02 14 18 5f 4c 30 43  PCI0USB0...._L0C
  07a0: 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42  ..\/._SB_PCI0USB
  07b0: 31 0a 02 14 18 5f 4c 30 35 00 86 5c 2f 03 5f 53  1...._L05..\/._S
  07c0: 42 5f 50 43 49 30 55 53 42 32 0a 02 14 18 5f 4c  B_PCI0USB2...._L
  07d0: 30 46 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 46  0F..\/._SB_PCI0F
  07e0: 31 33 39 0a 02 14 18 5f 4c 30 41 00 86 5c 2f 03  139...._L0A..\/.
  07f0: 5f 53 42 5f 50 43 49 30 48 55 42 31 0a 02 14 18  _SB_PCI0HUB1....
  0800: 5f 4c 30 37 00 86 5c 2f 03 5f 53 42 5f 50 43 49  _L07..\/._SB_PCI
  0810: 30 4d 4d 43 49 0a 02 10 8f bc 03 5c 5f 53 42 5f  0MMCI......\_SB_
  0820: 5b 82 42 18 50 4d 49 4f 08 5f 48 49 44 0c 41 d0  [.B.PMIO._HID.A.
  0830: 0c 02 08 5f 55 49 44 0a 03 14 4a 16 5f 43 52 53  ..._UID...J._CRS
  0840: 00 08 49 4f 44 4d 11 0d 0a 0a 47 01 00 00 00 00  ..IODM....G.....
  0850: 00 00 79 00 08 49 4f 52 54 11 35 0a 32 47 01 00  ..y..IORT.5.2G..
  0860: 00 00 00 01 80 47 01 00 00 00 00 01 80 47 01 00  .....G.......G..
  0870: 00 00 00 01 80 47 01 00 00 00 00 01 80 47 01 00  .....G.......G..
  0880: 00 00 00 01 80 47 01 00 00 00 00 01 80 79 00 8b  .....G.......y..
  0890: 49 4f 52 54 0a 02 49 31 4d 4e 8b 49 4f 52 54 0a  IORT..I1MN.IORT.
  08a0: 04 49 31 4d 58 8b 49 4f 52 54 0a 0a 49 32 4d 4e  .I1MX.IORT..I2MN
  08b0: 8b 49 4f 52 54 0a 0c 49 32 4d 58 8b 49 4f 52 54  .IORT..I2MX.IORT
  08c0: 0a 12 49 33 4d 4e 8b 49 4f 52 54 0a 14 49 33 4d  ..I3MN.IORT..I3M
  08d0: 58 8b 49 4f 52 54 0a 1a 49 34 4d 4e 8b 49 4f 52  X.IORT..I4MN.IOR
  08e0: 54 0a 1c 49 34 4d 58 8b 49 4f 52 54 0a 22 49 35  T..I4MX.IORT."I5
  08f0: 4d 4e 8b 49 4f 52 54 0a 24 49 35 4d 58 8b 49 4f  MN.IORT.$I5MX.IO
  0900: 52 54 0a 2a 49 36 4d 4e 8b 49 4f 52 54 0a 2c 49  RT.*I6MN.IORT.,I
  0910: 36 4d 58 7b 50 4d 42 52 0b fc ff 49 31 4d 4e 70  6MX{PMBR...I1MNp
  0920: 49 31 4d 4e 49 31 4d 58 72 49 31 4d 4e 0a 80 60  I1MNI1MXrI1MN..`
  0930: 70 60 49 32 4d 4e 70 60 49 32 4d 58 7b 4e 56 53  p`I2MNp`I2MX{NVS
  0940: 42 0b fc ff 49 33 4d 4e 70 49 33 4d 4e 49 33 4d  B...I3MNpI3MNI3M
  0950: 58 72 49 33 4d 4e 0a 80 60 70 60 49 34 4d 4e 70  XrI3MN..`p`I4MNp
  0960: 60 49 34 4d 58 7b 41 4e 4c 47 0b fc ff 49 35 4d  `I4MX{ANLG...I5M
  0970: 4e 70 49 35 4d 4e 49 35 4d 58 72 49 35 4d 4e 0a  NpI5MNI5MXrI5MN.
  0980: 80 60 70 60 49 36 4d 4e 70 60 49 36 4d 58 a0 0b  .`p`I6MNp`I6MX..
  0990: 49 31 4d 4e 70 49 4f 52 54 60 a1 07 70 49 4f 44  I1MNpIORT`..pIOD
  09a0: 4d 60 a4 60 5b 82 31 53 4d 49 4f 08 5f 48 49 44  M`.`[.1SMIO._HID
  09b0: 0c 41 d0 0c 02 08 5f 55 49 44 0a 04 08 5f 43 52  .A...._UID..._CR
  09c0: 53 11 15 0a 12 47 01 00 50 00 50 01 40 47 01 00  S....G..P.P.@G..
  09d0: 55 00 55 01 40 79 00 5b 82 19 50 57 52 42 08 5f  U.U.@y.[..PWRB._
  09e0: 48 49 44 0c 41 d0 0c 0c 14 09 5f 53 54 41 00 a4  HID.A....._STA..
  09f0: 0a 0b 5b 82 4a 1c 4d 45 4d 5f 08 5f 48 49 44 0c  ..[.J.MEM_._HID.
  0a00: 41 d0 0c 01 14 49 1b 5f 43 52 53 00 08 42 55 46  A....I._CRS..BUF
  0a10: 30 11 4e 07 0a 7a 86 09 00 01 00 00 0f 00 00 40  0.N..z.........@
  0a20: 00 00 86 09 00 01 00 40 0f 00 00 40 00 00 86 09  .......@...@....
  0a30: 00 01 00 80 0f 00 00 40 00 00 86 09 00 01 00 c0  .......@........
  0a40: 0f 00 00 40 00 00 86 09 00 01 00 00 00 00 00 00  ...@............
  0a50: 01 00 86 09 00 01 00 00 ff ff 00 00 01 00 86 09  ................
  0a60: 00 01 00 00 00 00 00 00 0a 00 86 09 00 01 00 00  ................
  0a70: 10 00 00 00 00 00 86 09 00 01 00 00 c0 fe 00 10  ................
  0a80: 00 00 86 09 00 01 00 00 e0 fe 00 10 00 00 79 00  ..............y.
  0a90: 8a 42 55 46 30 0a 34 41 43 4d 4d 8a 42 55 46 30  .BUF0.4ACMM.BUF0
  0aa0: 0a 04 52 4d 41 31 8a 42 55 46 30 0a 08 52 53 53  ..RMA1.BUF0..RSS
  0ab0: 31 8a 42 55 46 30 0a 10 52 4d 41 32 8a 42 55 46  1.BUF0..RMA2.BUF
  0ac0: 30 0a 14 52 53 53 32 8a 42 55 46 30 0a 1c 52 4d  0..RSS2.BUF0..RM
  0ad0: 41 33 8a 42 55 46 30 0a 20 52 53 53 33 8a 42 55  A3.BUF0. RSS3.BU
  0ae0: 46 30 0a 28 52 4d 41 34 8a 42 55 46 30 0a 2c 52  F0.(RMA4.BUF0.,R
  0af0: 53 53 34 8a 42 55 46 30 0a 5c 45 58 54 4d 74 41  SS4.BUF0.\EXTMtA
  0b00: 4d 45 4d 0c 00 00 10 00 45 58 54 4d a0 35 92 93  MEM.....EXTM.5..
  0b10: 52 4f 4d 31 00 70 52 4d 41 31 52 4d 41 32 79 52  ROM1.pRMA1RMA2yR
  0b20: 4f 4d 31 0a 08 60 70 60 52 4d 41 31 79 52 4d 53  OM1..`p`RMA1yRMS
  0b30: 31 0a 08 60 70 60 52 53 53 31 70 0b 00 80 52 53  1..`p`RSS1p...RS
  0b40: 53 32 a0 35 92 93 52 4f 4d 32 00 70 52 4d 41 32  S2.5..ROM2.pRMA2
  0b50: 52 4d 41 33 79 52 4f 4d 32 0a 08 60 70 60 52 4d  RMA3yROM2..`p`RM
  0b60: 41 32 79 52 4d 53 32 0a 08 60 70 60 52 53 53 32  A2yRMS2..`p`RSS2
  0b70: 70 0b 00 c0 52 53 53 33 a0 37 92 93 52 4f 4d 33  p...RSS3.7..ROM3
  0b80: 00 70 52 4d 41 33 52 4d 41 34 79 52 4f 4d 33 0a  .pRMA3RMA4yROM3.
  0b90: 08 60 70 60 52 4d 41 33 79 52 4d 53 33 0a 08 60  .`p`RMA3yRMS3..`
  0ba0: 70 60 52 53 53 33 70 0c 00 00 01 00 52 53 53 34  p`RSS3p.....RSS4
  0bb0: 70 41 4d 45 4d 41 43 4d 4d a4 42 55 46 30 5b 82  pAMEMACMM.BUF0[.
  0bc0: 87 82 03 50 43 49 30 08 5f 48 49 44 0c 41 d0 0a  ...PCI0._HID.A..
  0bd0: 03 08 5f 41 44 52 0a 00 08 5f 55 49 44 0a 01 08  .._ADR..._UID...
  0be0: 5f 42 42 4e 0a 00 08 4e 41 54 41 12 07 01 0c 00  _BBN...NATA.....
  0bf0: 00 09 00 14 17 53 53 33 44 00 a0 0b 93 4f 53 46  .....SS3D....OSF
  0c00: 4c 0a 02 a4 0a 02 a1 04 a4 0a 03 14 09 5f 53 54  L............_ST
  0c10: 41 00 a4 0a 0f 5b 80 4c 44 54 33 02 0a 6c 0a 04  A....[.LDT3..l..
  0c20: 5b 81 0b 4c 44 54 33 03 55 43 46 47 20 5b 80 53  [..LDT3.UCFG [.S
  0c30: 32 4b 43 02 0a e4 0a 04 5b 81 0b 53 32 4b 43 03  2KC.....[..S2KC.
  0c40: 43 54 4c 30 20 14 40 0d 5f 43 52 53 00 08 42 55  CTL0 .@._CRS..BU
  0c50: 46 30 11 4c 08 0a 88 88 0d 00 02 01 00 00 00 00  F0.L............
  0c60: 00 ff 00 00 00 00 01 47 01 f8 0c f8 0c 01 08 88  .......G........
  0c70: 0d 00 01 0c 03 00 00 00 00 f7 0c 00 00 f8 0c 88  ................
  0c80: 0d 00 01 0c 03 00 00 00 0d ff ff 00 00 00 f3 87  ................
  0c90: 17 00 00 0c 03 00 00 00 00 00 00 0a 00 ff ff 0b  ................
  0ca0: 00 00 00 00 00 00 00 02 00 87 17 00 00 0c 03 00  ................
  0cb0: 00 00 00 00 00 0c 00 ff ff 0d 00 00 00 00 00 00  ................
  0cc0: 00 02 00 87 17 00 00 0c 03 00 00 00 00 00 00 10  ................
  0cd0: 00 ff ff bf fe 00 00 00 00 00 00 f0 ff 79 00 8a  .............y..
  0ce0: 42 55 46 30 0a 76 54 43 4d 4d 8a 42 55 46 30 0a  BUF0.vTCMM.BUF0.
  0cf0: 82 54 4f 4d 4d 72 41 4d 45 4d 0c 00 00 01 00 54  .TOMMrAMEM.....T
  0d00: 43 4d 4d 74 0c 00 00 c0 fe 54 43 4d 4d 54 4f 4d  CMMt.....TCMMTOM
  0d10: 4d a4 42 55 46 30 08 50 49 43 4d 12 49 20 14 12  M.BUF0.PICM.I ..
  0d20: 0f 04 0c ff ff 01 00 0a 00 4c 53 4d 42 0a 00 12  .........LSMB...
  0d30: 0f 04 0c ff ff 01 00 0a 01 4c 53 4d 42 0a 00 12  .........LSMB...
  0d40: 1a 04 0c ff ff 02 00 0a 00 5c 2f 03 5f 53 42 5f  .........\/._SB_
  0d50: 50 43 49 30 4c 55 42 41 0a 00 12 1a 04 0c ff ff  PCI0LUBA........
  0d60: 02 00 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0d70: 55 42 42 0a 00 12 1a 04 0c ff ff 02 00 0a 02 5c  UBB............\
  0d80: 2f 03 5f 53 42 5f 50 43 49 30 4c 55 42 32 0a 00  /._SB_PCI0LUB2..
  0d90: 12 1a 04 0c ff ff 04 00 0a 00 5c 2f 03 5f 53 42  ..........\/._SB
  0da0: 5f 50 43 49 30 4c 4d 41 43 0a 00 12 1a 04 0c ff  _PCI0LMAC.......
  0db0: ff 05 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  0dc0: 4c 41 50 55 0a 00 12 1a 04 0c ff ff 06 00 0a 00  LAPU............
  0dd0: 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 41 43 49 0a  \/._SB_PCI0LACI.
  0de0: 00 12 1a 04 0c ff ff 06 00 0a 01 5c 2f 03 5f 53  ...........\/._S
  0df0: 42 5f 50 43 49 30 4c 4d 43 49 0a 00 12 1a 04 0c  B_PCI0LMCI......
  0e00: ff ff 0d 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  0e10: 30 4c 46 49 52 0a 00 12 1a 04 0c ff ff 0c 00 0a  0LFIR...........
  0e20: 00 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 33 43 4d  .\/._SB_PCI0L3CM
  0e30: 0a 00 12 1a 04 0c ff ff 09 00 0a 00 5c 2f 03 5f  ............\/._
  0e40: 53 42 5f 50 43 49 30 4c 49 44 45 0a 00 12 1a 04  SB_PCI0LIDE.....
  0e50: 0c ff ff 08 00 0a 00 5c 2f 03 5f 53 42 5f 50 43  .......\/._SB_PC
  0e60: 49 30 4c 4e 4b 31 0a 00 12 1a 04 0c ff ff 08 00  I0LNK1..........
  0e70: 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b  ..\/._SB_PCI0LNK
  0e80: 32 0a 00 12 1a 04 0c ff ff 08 00 0a 02 5c 2f 03  2............\/.
  0e90: 5f 53 42 5f 50 43 49 30 4c 4e 4b 33 0a 00 12 1a  _SB_PCI0LNK3....
  0ea0: 04 0c ff ff 08 00 0a 03 5c 2f 03 5f 53 42 5f 50  ........\/._SB_P
  0eb0: 43 49 30 4c 4e 4b 34 0a 00 12 1a 04 0c ff ff 1e  CI0LNK4.........
  0ec0: 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e  ...\/._SB_PCI0LN
  0ed0: 4b 35 0a 00 12 1a 04 0c ff ff 1e 00 0a 01 5c 2f  K5............\/
  0ee0: 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 35 0a 00 12  ._SB_PCI0LNK5...
  0ef0: 1a 04 0c ff ff 1e 00 0a 02 5c 2f 03 5f 53 42 5f  .........\/._SB_
  0f00: 50 43 49 30 4c 4e 4b 35 0a 00 12 1a 04 0c ff ff  PCI0LNK5........
  0f10: 1e 00 0a 03 5c 2f 03 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0f20: 4e 4b 35 0a 00 08 41 50 49 43 12 47 14 0c 12 1a  NK5...APIC.G....
  0f30: 04 0c ff ff 01 00 0a 00 5c 2f 03 5f 53 42 5f 50  ........\/._SB_P
  0f40: 43 49 30 41 50 43 53 0a 00 12 1a 04 0c ff ff 01  CI0APCS.........
  0f50: 00 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50  ...\/._SB_PCI0AP
  0f60: 43 53 0a 00 12 1a 04 0c ff ff 02 00 0a 00 5c 2f  CS............\/
  0f70: 03 5f 53 42 5f 50 43 49 30 41 50 43 46 0a 00 12  ._SB_PCI0APCF...
  0f80: 1a 04 0c ff ff 02 00 0a 01 5c 2f 03 5f 53 42 5f  .........\/._SB_
  0f90: 50 43 49 30 41 50 43 47 0a 00 12 1a 04 0c ff ff  PCI0APCG........
  0fa0: 02 00 0a 02 5c 2f 03 5f 53 42 5f 50 43 49 30 41  ....\/._SB_PCI0A
  0fb0: 50 43 4c 0a 00 12 1a 04 0c ff ff 04 00 0a 00 5c  PCL............\
  0fc0: 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 48 0a 00  /._SB_PCI0APCH..
  0fd0: 12 1a 04 0c ff ff 05 00 0a 00 5c 2f 03 5f 53 42  ..........\/._SB
  0fe0: 5f 50 43 49 30 41 50 43 49 0a 00 12 1a 04 0c ff  _PCI0APCI.......
  0ff0: ff 06 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1000: 41 50 43 4a 0a 00 12 1a 04 0c ff ff 06 00 0a 01  APCJ............
  1010: 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 4b 0a  \/._SB_PCI0APCK.
  1020: 00 12 1a 04 0c ff ff 0d 00 0a 00 5c 2f 03 5f 53  ...........\/._S
  1030: 42 5f 50 43 49 30 41 50 43 4d 0a 00 12 1a 04 0c  B_PCI0APCM......
  1040: ff ff 0c 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  1050: 30 41 50 33 43 0a 00 12 1a 04 0c ff ff 09 00 0a  0AP3C...........
  1060: 00 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 5a  .\/._SB_PCI0APCZ
  1070: 0a 00 14 19 5f 50 52 54 00 a0 0b 92 50 49 43 46  ...._PRT....PICF
  1080: a4 50 49 43 4d a1 06 a4 41 50 49 43 5b 82 42 56  .PICM...APIC[.BV
  1090: 48 55 42 30 08 5f 41 44 52 0c 00 00 08 00 14 09  HUB0._ADR.......
  10a0: 5f 53 54 41 00 a4 0a 0f 08 50 49 43 4d 12 4b 28  _STA.....PICM.K(
  10b0: 18 12 1a 04 0c ff ff 06 00 0a 00 5c 2f 03 5f 53  ...........\/._S
  10c0: 42 5f 50 43 49 30 4c 4e 4b 31 0a 00 12 1a 04 0c  B_PCI0LNK1......
  10d0: ff ff 06 00 0a 01 5c 2f 03 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  10e0: 30 4c 4e 4b 32 0a 00 12 1a 04 0c ff ff 06 00 0a  0LNK2...........
  10f0: 02 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 33  .\/._SB_PCI0LNK3
  1100: 0a 00 12 1a 04 0c ff ff 06 00 0a 03 5c 2f 03 5f  ............\/._
  1110: 53 42 5f 50 43 49 30 4c 4e 4b 34 0a 00 12 1a 04  SB_PCI0LNK4.....
  1120: 0c ff ff 07 00 0a 00 5c 2f 03 5f 53 42 5f 50 43  .......\/._SB_PC
  1130: 49 30 4c 4e 4b 34 0a 00 12 1a 04 0c ff ff 07 00  I0LNK4..........
  1140: 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b  ..\/._SB_PCI0LNK
  1150: 31 0a 00 12 1a 04 0c ff ff 07 00 0a 02 5c 2f 03  1............\/.
  1160: 5f 53 42 5f 50 43 49 30 4c 4e 4b 32 0a 00 12 1a  _SB_PCI0LNK2....
  1170: 04 0c ff ff 07 00 0a 03 5c 2f 03 5f 53 42 5f 50  ........\/._SB_P
  1180: 43 49 30 4c 4e 4b 33 0a 00 12 1a 04 0c ff ff 08  CI0LNK3.........
  1190: 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e  ...\/._SB_PCI0LN
  11a0: 4b 33 0a 00 12 1a 04 0c ff ff 08 00 0a 01 5c 2f  K3............\/
  11b0: 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 34 0a 00 12  ._SB_PCI0LNK4...
  11c0: 1a 04 0c ff ff 08 00 0a 02 5c 2f 03 5f 53 42 5f  .........\/._SB_
  11d0: 50 43 49 30 4c 4e 4b 31 0a 00 12 1a 04 0c ff ff  PCI0LNK1........
  11e0: 08 00 0a 03 5c 2f 03 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  11f0: 4e 4b 32 0a 00 12 1a 04 0c ff ff 09 00 0a 00 5c  NK2............\
  1200: 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 32 0a 00  /._SB_PCI0LNK2..
  1210: 12 1a 04 0c ff ff 09 00 0a 01 5c 2f 03 5f 53 42  ..........\/._SB
  1220: 5f 50 43 49 30 4c 4e 4b 33 0a 00 12 1a 04 0c ff  _PCI0LNK3.......
  1230: ff 09 00 0a 02 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1240: 4c 4e 4b 34 0a 00 12 1a 04 0c ff ff 09 00 0a 03  LNK4............
  1250: 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 31 0a  \/._SB_PCI0LNK1.
  1260: 00 12 1a 04 0c ff ff 0a 00 0a 00 5c 2f 03 5f 53  ...........\/._S
  1270: 42 5f 50 43 49 30 4c 4e 4b 31 0a 00 12 1a 04 0c  B_PCI0LNK1......
  1280: ff ff 0a 00 0a 01 5c 2f 03 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  1290: 30 4c 4e 4b 32 0a 00 12 1a 04 0c ff ff 0a 00 0a  0LNK2...........
  12a0: 02 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 33  .\/._SB_PCI0LNK3
  12b0: 0a 00 12 1a 04 0c ff ff 0a 00 0a 03 5c 2f 03 5f  ............\/._
  12c0: 53 42 5f 50 43 49 30 4c 4e 4b 34 0a 00 12 1a 04  SB_PCI0LNK4.....
  12d0: 0c ff ff 0b 00 0a 00 5c 2f 03 5f 53 42 5f 50 43  .......\/._SB_PC
  12e0: 49 30 4c 4e 4b 33 0a 00 12 1a 04 0c ff ff 0b 00  I0LNK3..........
  12f0: 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b  ..\/._SB_PCI0LNK
  1300: 33 0a 00 12 1a 04 0c ff ff 0b 00 0a 02 5c 2f 03  3............\/.
  1310: 5f 53 42 5f 50 43 49 30 4c 4e 4b 33 0a 00 12 1a  _SB_PCI0LNK3....
  1320: 04 0c ff ff 0b 00 0a 03 5c 2f 03 5f 53 42 5f 50  ........\/._SB_P
  1330: 43 49 30 4c 4e 4b 33 0a 00 08 41 50 49 43 12 4b  CI0LNK3...APIC.K
  1340: 28 18 12 1a 04 0c ff ff 06 00 0a 00 5c 2f 03 5f  (...........\/._
  1350: 53 42 5f 50 43 49 30 41 50 43 31 0a 00 12 1a 04  SB_PCI0APC1.....
  1360: 0c ff ff 06 00 0a 01 5c 2f 03 5f 53 42 5f 50 43  .......\/._SB_PC
  1370: 49 30 41 50 43 32 0a 00 12 1a 04 0c ff ff 06 00  I0APC2..........
  1380: 0a 02 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43  ..\/._SB_PCI0APC
  1390: 33 0a 00 12 1a 04 0c ff ff 06 00 0a 03 5c 2f 03  3............\/.
  13a0: 5f 53 42 5f 50 43 49 30 41 50 43 34 0a 00 12 1a  _SB_PCI0APC4....
  13b0: 04 0c ff ff 07 00 0a 00 5c 2f 03 5f 53 42 5f 50  ........\/._SB_P
  13c0: 43 49 30 41 50 43 34 0a 00 12 1a 04 0c ff ff 07  CI0APC4.........
  13d0: 00 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50  ...\/._SB_PCI0AP
  13e0: 43 31 0a 00 12 1a 04 0c ff ff 07 00 0a 02 5c 2f  C1............\/
  13f0: 03 5f 53 42 5f 50 43 49 30 41 50 43 32 0a 00 12  ._SB_PCI0APC2...
  1400: 1a 04 0c ff ff 07 00 0a 03 5c 2f 03 5f 53 42 5f  .........\/._SB_
  1410: 50 43 49 30 41 50 43 33 0a 00 12 1a 04 0c ff ff  PCI0APC3........
  1420: 08 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49 30 41  ....\/._SB_PCI0A
  1430: 50 43 33 0a 00 12 1a 04 0c ff ff 08 00 0a 01 5c  PC3............\
  1440: 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 34 0a 00  /._SB_PCI0APC4..
  1450: 12 1a 04 0c ff ff 08 00 0a 02 5c 2f 03 5f 53 42  ..........\/._SB
  1460: 5f 50 43 49 30 41 50 43 31 0a 00 12 1a 04 0c ff  _PCI0APC1.......
  1470: ff 08 00 0a 03 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1480: 41 50 43 32 0a 00 12 1a 04 0c ff ff 09 00 0a 00  APC2............
  1490: 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 32 0a  \/._SB_PCI0APC2.
  14a0: 00 12 1a 04 0c ff ff 09 00 0a 01 5c 2f 03 5f 53  ...........\/._S
  14b0: 42 5f 50 43 49 30 41 50 43 33 0a 00 12 1a 04 0c  B_PCI0APC3......
  14c0: ff ff 09 00 0a 02 5c 2f 03 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  14d0: 30 41 50 43 34 0a 00 12 1a 04 0c ff ff 09 00 0a  0APC4...........
  14e0: 03 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 31  .\/._SB_PCI0APC1
  14f0: 0a 00 12 1a 04 0c ff ff 0a 00 0a 00 5c 2f 03 5f  ............\/._
  1500: 53 42 5f 50 43 49 30 41 50 43 31 0a 00 12 1a 04  SB_PCI0APC1.....
  1510: 0c ff ff 0a 00 0a 01 5c 2f 03 5f 53 42 5f 50 43  .......\/._SB_PC
  1520: 49 30 41 50 43 32 0a 00 12 1a 04 0c ff ff 0a 00  I0APC2..........
  1530: 0a 02 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43  ..\/._SB_PCI0APC
  1540: 33 0a 00 12 1a 04 0c ff ff 0a 00 0a 03 5c 2f 03  3............\/.
  1550: 5f 53 42 5f 50 43 49 30 41 50 43 34 0a 00 12 1a  _SB_PCI0APC4....
  1560: 04 0c ff ff 0b 00 0a 00 5c 2f 03 5f 53 42 5f 50  ........\/._SB_P
  1570: 43 49 30 41 50 43 33 0a 00 12 1a 04 0c ff ff 0b  CI0APC3.........
  1580: 00 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50  ...\/._SB_PCI0AP
  1590: 43 33 0a 00 12 1a 04 0c ff ff 0b 00 0a 02 5c 2f  C3............\/
  15a0: 03 5f 53 42 5f 50 43 49 30 41 50 43 33 0a 00 12  ._SB_PCI0APC3...
  15b0: 1a 04 0c ff ff 0b 00 0a 03 5c 2f 03 5f 53 42 5f  .........\/._SB_
  15c0: 50 43 49 30 41 50 43 33 0a 00 14 19 5f 50 52 54  PCI0APC3...._PRT
  15d0: 00 a0 0b 92 50 49 43 46 a4 50 49 43 4d a1 06 a4  ....PICF.PICM...
  15e0: 41 50 49 43 08 5f 50 52 57 12 06 02 0a 00 0a 05  APIC._PRW.......
  15f0: 5b 82 43 69 49 44 45 30 08 5f 41 44 52 0c 00 00  [.CiIDE0._ADR...
  1600: 09 00 5b 80 41 30 39 30 02 0a 50 0a 18 5b 81 26  ..[.A090..P..[.&
  1610: 41 30 39 30 03 49 44 32 30 10 00 30 49 44 54 53  A090.ID20..0IDTS
  1620: 10 49 44 54 50 10 49 44 32 32 20 55 4d 53 53 10  .IDTP.ID22 UMSS.
  1630: 55 4d 53 50 10 08 49 44 45 50 11 03 0a 14 08 49  UMSP..IDEP.....I
  1640: 44 45 53 11 03 0a 14 14 48 16 47 54 4d 5f 01 a0  DES.....H.GTM_..
  1650: 19 93 53 58 5f 5f 0a 01 a0 10 4f 53 46 4c 7d 5a  ..SX__....OSFL}Z
  1660: 30 30 30 0a 01 5a 30 30 30 a0 17 93 68 0a 00 70  000..Z000...h..p
  1670: 49 44 54 50 60 70 55 4d 53 50 61 70 49 44 45 50  IDTP`pUMSPapIDEP
  1680: 62 a1 13 70 49 44 54 53 60 70 55 4d 53 53 61 70  b..pIDTS`pUMSSap
  1690: 49 44 45 53 62 8a 62 0a 00 50 49 4f 30 8a 62 0a  IDESb.b..PIO0.b.
  16a0: 04 44 4d 41 30 8a 62 0a 08 50 49 4f 31 8a 62 0a  .DMA0.b..PIO1.b.
  16b0: 0c 44 4d 41 31 8a 62 0a 10 46 4c 41 47 70 0a 10  .DMA1.b..FLAGp..
  16c0: 46 4c 41 47 7b 60 0b 00 0f 63 7b 60 0b 00 f0 64  FLAG{`...c{`...d
  16d0: 7a 63 0a 08 63 7a 64 0a 0c 64 72 63 64 63 77 72  zc..czd..drcdcwr
  16e0: 63 0a 02 00 0a 1e 50 49 4f 30 a0 14 92 94 50 49  c.....PIO0....PI
  16f0: 4f 30 0a b4 7d 46 4c 41 47 0a 02 46 4c 41 47 a0  O0..}FLAG..FLAG.
  1700: 27 7b 61 0b 00 40 00 7d 46 4c 41 47 0a 01 46 4c  '{a..@.}FLAG..FL
  1710: 41 47 7b 61 0b 00 07 63 7a 63 0a 08 63 70 55 32  AG{a...czc..cpU2
  1720: 54 5f 63 44 4d 41 30 a1 0a 70 50 49 4f 30 44 4d  T_cDMA0..pPIO0DM
  1730: 41 30 7b 60 0a 0f 63 7b 60 0a f0 64 7a 64 0a 04  A0{`..c{`..dzd..
  1740: 64 72 63 64 63 77 72 63 0a 02 00 0a 1e 50 49 4f  drcdcwrc.....PIO
  1750: 31 a0 14 92 94 50 49 4f 31 0a b4 7d 46 4c 41 47  1....PIO1..}FLAG
  1760: 0a 08 46 4c 41 47 a0 20 7b 61 0a 40 00 7d 46 4c  ..FLAG. {a.@.}FL
  1770: 41 47 0a 04 46 4c 41 47 7b 61 0a 07 63 70 55 32  AG..FLAG{a..cpU2
  1780: 54 5f 63 44 4d 41 31 a1 0a 70 50 49 4f 31 44 4d  T_cDMA1..pPIO1DM
  1790: 41 31 a0 10 93 68 0a 00 70 62 49 44 45 50 a4 49  A1...h..pbIDEP.I
  17a0: 44 45 50 a1 0c 70 62 49 44 45 53 a4 49 44 45 53  DEP..pbIDES.IDES
  17b0: 14 49 04 55 32 54 5f 01 a0 08 93 68 0a 00 a4 0a  .I.U2T_....h....
  17c0: 3c a0 08 93 68 0a 01 a4 0a 5a a0 08 93 68 0a 02  <...h....Z...h..
  17d0: a4 0a 78 a0 08 93 68 0a 03 a4 0a 96 a0 08 93 68  ..x...h........h
  17e0: 0a 04 a4 0a 2d a0 08 93 68 0a 05 a4 0a 1e a0 08  ....-...h.......
  17f0: 93 68 0a 06 a4 0a 14 a4 0a 0f 14 49 04 54 32 55  .h.........I.T2U
  1800: 5f 01 a0 08 94 68 0a 78 a4 0a 03 a0 08 94 68 0a  _....h.x......h.
  1810: 5a a4 0a 02 a0 08 94 68 0a 3c a4 0a 01 a0 08 94  Z......h.<......
  1820: 68 0a 2d a4 0a 00 a0 08 94 68 0a 1e a4 0a 04 a0  h.-......h......
  1830: 08 94 68 0a 14 a4 0a 05 a0 08 94 68 0a 0f a4 0a  ..h........h....
  1840: 06 a4 0a 07 14 42 04 54 32 44 5f 01 a0 09 94 68  .....B.T2D_....h
  1850: 0b e0 01 a4 0a a8 a0 09 94 68 0b 86 01 a4 0a 77  .........h.....w
  1860: a0 08 94 68 0a f0 a4 0a 47 a0 08 94 68 0a b4 a4  ...h....G...h...
  1870: 0a 33 a0 08 94 68 0a 96 a4 0a 22 a0 08 94 68 0a  .3...h...."...h.
  1880: 78 a4 0a 21 a4 0a 20 14 43 1b 53 54 4d 5f 04 a0  x..!.. .C.STM_..
  1890: 3b 53 58 5f 5f 70 53 49 44 30 49 44 32 30 70 53  ;SX__pSID0ID20pS
  18a0: 49 44 31 49 44 54 53 70 53 49 44 32 49 44 54 50  ID1IDTSpSID2IDTP
  18b0: 70 53 49 44 33 49 44 32 32 70 53 49 44 34 55 4d  pSID3ID22pSID4UM
  18c0: 53 53 70 53 49 44 35 55 4d 53 50 a1 37 70 49 44  SSpSID5UMSP.7pID
  18d0: 32 30 53 49 44 30 70 49 44 54 53 53 49 44 31 70  20SID0pIDTSSID1p
  18e0: 49 44 54 50 53 49 44 32 70 49 44 32 32 53 49 44  IDTPSID2pID22SID
  18f0: 33 70 55 4d 53 53 53 49 44 34 70 55 4d 53 50 53  3pUMSSSID4pUMSPS
  1900: 49 44 35 70 0a 00 53 58 5f 5f 8a 68 0a 00 50 49  ID5p..SX__.h..PI
  1910: 4f 30 8a 68 0a 04 44 4d 41 30 8a 68 0a 08 50 49  O0.h..DMA0.h..PI
  1920: 4f 31 8a 68 0a 0c 44 4d 41 31 8a 68 0a 10 46 4c  O1.h..DMA1.h..FL
  1930: 41 47 a0 11 93 6b 0a 00 70 53 49 44 32 60 70 53  AG...k..pSID2`pS
  1940: 49 44 35 61 a1 0d 70 53 49 44 31 60 70 53 49 44  ID5a..pSID1`pSID
  1950: 34 61 a0 21 92 93 50 49 4f 30 0c ff ff ff ff 7b  4a.!..PIO0.....{
  1960: 60 0a ff 60 79 54 32 44 5f 50 49 4f 30 0a 08 62  `..`yT2D_PIO0..b
  1970: 7d 60 62 60 a0 1d 92 93 50 49 4f 31 0c ff ff ff  }`b`....PIO1....
  1980: ff 7b 60 0b 00 ff 60 7d 60 54 32 44 5f 50 49 4f  .{`...`}`T2D_PIO
  1990: 31 60 a0 24 7b 46 4c 41 47 0a 01 00 7b 61 0a ff  1`.${FLAG...{a..
  19a0: 61 79 54 32 55 5f 44 4d 41 30 0a 08 62 7d 0b 00  ayT2U_DMA0..b}..
  19b0: c0 62 62 7d 62 61 61 a1 23 a0 21 92 93 44 4d 41  .bb}baa.#.!..DMA
  19c0: 30 0c ff ff ff ff 7b 60 0a ff 60 79 54 32 44 5f  0.....{`..`yT2D_
  19d0: 44 4d 41 30 0a 08 62 7d 60 62 60 a0 1f 7b 46 4c  DMA0..b}`b`..{FL
  19e0: 41 47 0a 04 00 7b 61 0b 00 ff 61 7d 0a c0 54 32  AG...{a...a}..T2
  19f0: 55 5f 44 4d 41 31 62 7d 62 61 61 a1 1f a0 1d 92  U_DMA1b}baa.....
  1a00: 93 44 4d 41 31 0c ff ff ff ff 7b 60 0b 00 ff 60  .DMA1.....{`...`
  1a10: 7d 60 54 32 44 5f 44 4d 41 31 60 a0 11 93 6b 0a  }`T2D_DMA1`...k.
  1a20: 00 70 60 49 44 54 50 70 61 55 4d 53 50 a1 0d 70  .p`IDTPpaUMSP..p
  1a30: 60 49 44 54 53 70 61 55 4d 53 53 14 47 17 47 54  `IDTSpaUMSS.G.GT
  1a40: 46 5f 02 70 11 0a 0a 07 03 00 00 00 00 a0 ef 60  F_.p...........`
  1a50: 8c 60 0a 01 4d 4f 44 45 8c 60 0a 05 44 52 49 56  .`..MODE.`..DRIV
  1a60: 70 69 44 52 49 56 a0 0b 93 68 0a 00 70 49 44 45  piDRIV...h..pIDE
  1a70: 50 61 a1 07 70 49 44 45 53 61 8a 61 0a 00 50 49  Pa..pIDESa.a..PI
  1a80: 4f 30 8a 61 0a 04 44 4d 41 30 8a 61 0a 08 50 49  O0.a..DMA0.a..PI
  1a90: 4f 31 8a 61 0a 0c 44 4d 41 31 8a 61 0a 10 46 4c  O1.a..DMA1.a..FL
  1aa0: 47 58 a0 1c 93 69 0a a0 70 50 49 4f 30 62 70 44  GX...i..pPIO0bpD
  1ab0: 4d 41 30 63 7b 46 4c 47 58 0a 01 46 4c 47 58 a1  MA0c{FLGX..FLGX.
  1ac0: 18 70 50 49 4f 31 62 70 44 4d 41 31 63 7b 46 4c  .pPIO1bpDMA1c{FL
  1ad0: 47 58 0a 04 46 4c 47 58 70 46 4c 47 58 61 a0 0a  GX..FLGXpFLGXa..
  1ae0: 94 62 0b 86 01 70 0a 00 62 a1 29 a0 09 94 62 0a  .b...p..b.)...b.
  1af0: f0 70 0a 01 62 a1 1d a0 09 94 62 0a b4 70 0a 02  .p..b.....b..p..
  1b00: 62 a1 11 a0 09 94 62 0a 78 70 0a 03 62 a1 05 70  b.....b.xp..b..p
  1b10: 0a 04 62 7d 0a 08 62 4d 4f 44 45 70 60 62 a0 4b  ..b}..bMODEp`b.K
  1b20: 05 46 4c 47 58 a0 09 94 63 0a 5a 70 0a 00 63 a1  .FLGX...c.Zp..c.
  1b30: 42 04 a0 09 94 63 0a 3c 70 0a 01 63 a1 35 a0 09  B....c.<p..c.5..
  1b40: 94 63 0a 2d 70 0a 02 63 a1 29 a0 09 94 63 0a 1e  .c.-p..c.)...c..
  1b50: 70 0a 03 63 a1 1d a0 09 94 63 0a 14 70 0a 04 63  p..c.....c..p..c
  1b60: a1 11 a0 09 94 63 0a 0f 70 0a 05 63 a1 05 70 0a  .....c..p..c..p.
  1b70: 06 63 7d 0a 40 63 4d 4f 44 45 a1 32 a0 0a 93 63  .c}.@cMODE.2...c
  1b80: 0c ff ff ff ff a4 60 a1 25 a0 09 94 63 0a 96 70  ......`.%...c..p
  1b90: 0a 00 63 a1 11 a0 09 94 63 0a 78 70 0a 01 63 a1  ..c.....c.xp..c.
  1ba0: 05 70 0a 02 63 7d 0a 20 63 4d 4f 44 45 73 60 62  .p..c}. cMODEs`b
  1bb0: 61 a4 61 5b 82 47 06 50 52 49 30 08 5f 41 44 52  a.a[.G.PRI0._ADR
  1bc0: 0a 00 14 0d 5f 47 54 4d 00 a4 47 54 4d 5f 0a 00  ...._GTM..GTM_..
  1bd0: 14 0f 5f 53 54 4d 03 53 54 4d 5f 68 69 6a 0a 00  .._STM.STM_hij..
  1be0: 5b 82 1c 4d 41 53 54 08 5f 41 44 52 0a 00 14 0f  [..MAST._ADR....
  1bf0: 5f 47 54 46 00 a4 47 54 46 5f 0a 00 0a a0 5b 82  _GTF..GTF_....[.
  1c00: 1c 53 4c 41 56 08 5f 41 44 52 0a 01 14 0f 5f 47  .SLAV._ADR...._G
  1c10: 54 46 00 a4 47 54 46 5f 0a 00 0a b0 5b 82 47 06  TF..GTF_....[.G.
  1c20: 53 45 43 30 08 5f 41 44 52 0a 01 14 0d 5f 47 54  SEC0._ADR...._GT
  1c30: 4d 00 a4 47 54 4d 5f 0a 01 14 0f 5f 53 54 4d 03  M..GTM_...._STM.
  1c40: 53 54 4d 5f 68 69 6a 0a 01 5b 82 1c 4d 41 53 54  STM_hij..[..MAST
  1c50: 08 5f 41 44 52 0a 00 14 0f 5f 47 54 46 00 a4 47  ._ADR...._GTF..G
  1c60: 54 46 5f 0a 01 0a a0 5b 82 1c 53 4c 41 56 08 5f  TF_....[..SLAV._
  1c70: 41 44 52 0a 01 14 0f 5f 47 54 46 00 a4 47 54 46  ADR...._GTF..GTF
  1c80: 5f 0a 01 0a b0 5b 82 43 0e 41 47 50 42 08 5f 41  _....[.C.AGPB._A
  1c90: 44 52 0c 00 00 1e 00 08 4f 4e 42 56 0a 00 08 50  DR......ONBV...P
  1ca0: 49 43 4d 12 1b 01 12 18 04 0b ff ff 0a 00 5c 2f  ICM...........\/
  1cb0: 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 35 0a 00 08  ._SB_PCI0LNK5...
  1cc0: 41 50 49 43 12 1b 01 12 18 04 0b ff ff 0a 00 5c  APIC...........\
  1cd0: 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 35 0a 00  /._SB_PCI0APC5..
  1ce0: 08 41 47 50 30 12 1b 01 12 18 04 0b ff ff 0a 00  .AGP0...........
  1cf0: 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 4e 4b 34 0a  \/._SB_PCI0LNK4.
  1d00: 00 08 41 47 50 31 12 1b 01 12 18 04 0b ff ff 0a  ..AGP1..........
  1d10: 00 5c 2f 03 5f 53 42 5f 50 43 49 30 41 50 43 34  .\/._SB_PCI0APC4
  1d20: 0a 00 14 39 5f 50 52 54 00 a0 1b 92 50 49 43 46  ...9_PRT....PICF
  1d30: a0 0d 93 4f 4e 42 56 0a 01 a4 50 49 43 4d a1 06  ...ONBV...PICM..
  1d40: a4 41 47 50 30 a1 16 a0 0d 93 4f 4e 42 56 0a 01  .AGP0.....ONBV..
  1d50: a4 41 50 49 43 a1 06 a4 41 47 50 31 5b 82 0c 56  .APIC...AGP1[..V
  1d60: 47 41 47 08 5f 41 44 52 0a 00 5b 82 40 12 48 55  GAG._ADR..[.@.HU
  1d70: 42 31 08 5f 41 44 52 0c 00 00 0c 00 08 50 49 43  B1._ADR......PIC
  1d80: 4d 12 4f 06 04 12 1a 04 0c ff ff 01 00 0a 00 5c  M.O............\
  1d90: 2f 03 5f 53 42 5f 50 43 49 30 4c 33 43 4d 0a 00  /._SB_PCI0L3CM..
  1da0: 12 1a 04 0c ff ff 01 00 0a 01 5c 2f 03 5f 53 42  ..........\/._SB
  1db0: 5f 50 43 49 30 4c 33 43 4d 0a 00 12 1a 04 0c ff  _PCI0L3CM.......
  1dc0: ff 01 00 0a 02 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1dd0: 4c 33 43 4d 0a 00 12 1a 04 0c ff ff 01 00 0a 03  L3CM............
  1de0: 5c 2f 03 5f 53 42 5f 50 43 49 30 4c 33 43 4d 0a  \/._SB_PCI0L3CM.
  1df0: 00 08 41 50 49 43 12 4f 06 04 12 1a 04 0c ff ff  ..APIC.O........
  1e00: 01 00 0a 00 5c 2f 03 5f 53 42 5f 50 43 49 30 41  ....\/._SB_PCI0A
  1e10: 50 33 43 0a 00 12 1a 04 0c ff ff 01 00 0a 01 5c  P3C............\
  1e20: 2f 03 5f 53 42 5f 50 43 49 30 41 50 33 43 0a 00  /._SB_PCI0AP3C..
  1e30: 12 1a 04 0c ff ff 01 00 0a 02 5c 2f 03 5f 53 42  ..........\/._SB
  1e40: 5f 50 43 49 30 41 50 33 43 0a 00 12 1a 04 0c ff  _PCI0AP3C.......
  1e50: ff 01 00 0a 03 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1e60: 41 50 33 43 0a 00 14 19 5f 50 52 54 00 a0 0b 92  AP3C...._PRT....
  1e70: 50 49 43 46 a4 50 49 43 4d a1 06 a4 41 50 49 43  PICF.PICM...APIC
  1e80: 08 5f 50 52 57 12 06 02 0a 0a 0a 04 5b 82 3b 53  ._PRW.......[.;S
  1e90: 4d 42 30 08 5f 41 44 52 0c 01 00 01 00 5b 80 53  MB0._ADR.....[.S
  1ea0: 4d 43 46 02 0a 48 0a 10 5b 81 1f 53 4d 43 46 03  MCF..H..[..SMCF.
  1eb0: 53 4d 50 4d 04 53 4d 54 31 1c 53 4d 54 32 20 53  SMPM.SMT1.SMT2 S
  1ec0: 42 31 5f 20 53 42 32 5f 20 5b 82 47 17 56 54 38  B1_ SB2_ [.G.VT8
  1ed0: 36 08 5f 41 44 52 0c 00 00 01 00 5b 80 50 49 4f  6._ADR.....[.PIO
  1ee0: 30 02 0a 04 0a 20 10 29 5c 00 5b 81 24 5c 2f 04  0.... .)\.[.$\/.
  1ef0: 5f 53 42 5f 50 43 49 30 56 54 38 36 50 49 4f 30  _SB_PCI0VT86PIO0
  1f00: 01 53 4d 45 4e 08 00 48 05 00 08 53 4d 49 4f 08  .SMEN..H...SMIO.
  1f10: 10 46 0a 5c 00 5b 80 5c 2f 04 5f 53 42 5f 50 43  .F.\.[.\/._SB_PC
  1f20: 49 30 56 54 38 36 50 36 30 5f 02 0a 60 0a 02 5b  I0VT86P60_..`..[
  1f30: 81 1a 5c 2f 04 5f 53 42 5f 50 43 49 30 56 54 38  ..\/._SB_PCI0VT8
  1f40: 36 50 36 30 5f 00 50 4d 42 52 10 5b 80 5c 2f 04  6P60_.PMBR.[.\/.
  1f50: 5f 53 42 5f 50 43 49 30 56 54 38 36 50 36 34 5f  _SB_PCI0VT86P64_
  1f60: 02 0a 64 0a 02 5b 81 1a 5c 2f 04 5f 53 42 5f 50  ..d..[..\/._SB_P
  1f70: 43 49 30 56 54 38 36 50 36 34 5f 00 4e 56 53 42  CI0VT86P64_.NVSB
  1f80: 10 5b 80 5c 2f 04 5f 53 42 5f 50 43 49 30 56 54  .[.\/._SB_PCI0VT
  1f90: 38 36 50 36 38 5f 02 0a 68 0a 02 5b 81 1a 5c 2f  86P68_..h..[..\/
  1fa0: 04 5f 53 42 5f 50 43 49 30 56 54 38 36 50 36 38  ._SB_PCI0VT86P68
  1fb0: 5f 00 41 4e 4c 47 10 5b 80 50 49 52 51 02 0a 7c  _.ANLG.[.PIRQ..|
  1fc0: 0a 0c 10 4f 07 5c 00 5b 81 49 07 5c 2f 04 5f 53  ...O.\.[.I.\/._S
  1fd0: 42 5f 50 43 49 30 56 54 38 36 50 49 52 51 00 49  B_PCI0VT86PIRQ.I
  1fe0: 4e 54 41 04 49 4e 54 42 04 49 4e 54 43 04 49 4e  NTA.INTB.INTC.IN
  1ff0: 54 44 04 49 4e 54 45 04 00 0c 53 43 49 49 04 54  TD.INTE...SCII.T
  2000: 43 4f 49 04 49 4e 54 46 04 49 4e 54 51 04 49 4e  COI.INTF.INTQ.IN
  2010: 54 55 04 49 4e 54 53 04 00 08 49 4e 54 47 04 49  TU.INTS...INTG.I
  2020: 4e 54 48 04 49 4e 54 4a 04 49 4e 54 4b 04 49 4e  NTH.INTJ.INTK.IN
  2030: 54 4c 04 49 4e 54 4d 04 49 4e 54 4e 04 49 4e 54  TL.INTM.INTN.INT
  2040: 50 04 10 18 5c 00 14 06 44 49 53 44 01 14 06 43  P...\...DISD...C
  2050: 4b 49 4f 02 14 06 53 4c 44 4d 02 5b 82 3d 55 53  KIO...SLDM.[.=US
  2060: 42 30 08 5f 41 44 52 0c 00 00 02 00 14 09 5f 53  B0._ADR......._S
  2070: 31 44 00 a4 0a 01 14 17 53 53 33 44 00 a0 0b 93  1D......SS3D....
  2080: 4f 53 46 4c 0a 02 a4 0a 02 a1 04 a4 0a 03 08 5f  OSFL..........._
  2090: 50 52 57 12 06 02 0a 0d 0a 04 5b 82 3d 55 53 42  PRW.......[.=USB
  20a0: 31 08 5f 41 44 52 0c 01 00 02 00 14 09 5f 53 31  1._ADR......._S1
  20b0: 44 00 a4 0a 01 14 17 53 53 33 44 00 a0 0b 93 4f  D......SS3D....O
  20c0: 53 46 4c 0a 02 a4 0a 02 a1 04 a4 0a 03 08 5f 50  SFL..........._P
  20d0: 52 57 12 06 02 0a 0c 0a 04 5b 82 42 06 55 53 42  RW.......[.B.USB
  20e0: 32 08 5f 41 44 52 0c 02 00 02 00 5b 80 50 30 32  2._ADR.....[.P02
  20f0: 30 02 0a 49 0a 01 5b 81 0b 50 30 32 30 00 55 30  0..I..[..P020.U0
  2100: 57 4b 01 14 19 5f 50 53 57 01 a0 09 68 70 0a 01  WK..._PSW...hp..
  2110: 55 30 57 4b a1 08 70 0a 00 55 30 57 4b 14 09 5f  U0WK..p..U0WK.._
  2120: 53 31 44 00 a4 0a 01 14 09 53 53 33 44 00 a4 0a  S1D......SS3D...
  2130: 01 08 5f 50 52 57 12 06 02 0a 05 0a 03 5b 82 3d  .._PRW.......[.=
  2140: 46 31 33 39 08 5f 41 44 52 0c 00 00 0d 00 14 09  F139._ADR.......
  2150: 5f 53 31 44 00 a4 0a 01 14 17 53 53 33 44 00 a0  _S1D......SS3D..
  2160: 0b 93 4f 53 46 4c 0a 02 a4 0a 02 a1 04 a4 0a 03  ..OSFL..........
  2170: 08 5f 50 52 57 12 06 02 0a 0f 0a 03 5b 82 1b 4d  ._PRW.......[..M
  2180: 4d 41 43 08 5f 41 44 52 0c 00 00 04 00 08 5f 50  MAC._ADR......_P
  2190: 52 57 12 06 02 0a 0b 0a 05 5b 82 0f 4d 41 50 55  RW.......[..MAPU
  21a0: 08 5f 41 44 52 0c 00 00 05 00 5b 82 0f 4d 41 43  ._ADR.....[..MAC
  21b0: 49 08 5f 41 44 52 0c 00 00 06 00 5b 82 1b 4d 4d  I._ADR.....[..MM
  21c0: 43 49 08 5f 41 44 52 0c 01 00 06 00 08 5f 50 52  CI._ADR......_PR
  21d0: 57 12 06 02 0a 07 0a 05 08 42 55 46 41 11 09 0a  W........BUFA...
  21e0: 06 23 f8 dc 18 79 00 08 42 55 46 42 11 09 0a 06  .#...y..BUFB....
  21f0: 23 00 00 18 79 00 8b 42 55 46 42 0a 01 49 52 51  #...y..BUFB..IRQ
  2200: 56 14 1e 43 52 53 5f 01 a0 0a 68 79 0a 01 68 49  V..CRS_...hy..hI
  2210: 52 51 56 a1 07 70 00 49 52 51 56 a4 42 55 46 42  RQV..p.IRQV.BUFB
  2220: 14 18 53 52 53 5f 01 8b 68 0a 01 49 52 51 30 82  ..SRS_..h..IRQ0.
  2230: 49 52 51 30 60 76 60 a4 60 14 43 05 43 52 53 41  IRQ0`v`.`.C.CRSA
  2240: 09 70 0a 00 60 a0 09 93 68 0a 08 70 0a 14 60 a0  .p..`...h..p..`.
  2250: 09 93 68 0a 0d 70 0a 15 60 a0 09 93 68 0a 02 70  ..h..p..`...h..p
  2260: 0a 16 60 08 49 52 5a 35 11 0e 0a 0b 89 06 00 09  ..`.IRZ5........
  2270: 01 07 00 00 00 79 00 8b 49 52 5a 35 0a 05 49 4e  .....y..IRZ5..IN
  2280: 5a 35 70 60 49 4e 5a 35 a4 49 52 5a 35 14 3b 53  Z5p`INZ5.IRZ5.;S
  2290: 52 53 41 09 8b 68 0a 05 49 4e 5a 36 70 0a 08 60  RSA..h..INZ6p..`
  22a0: a0 0c 93 49 4e 5a 36 0a 14 70 0a 08 60 a0 0c 93  ...INZ6..p..`...
  22b0: 49 4e 5a 36 0a 15 70 0a 0d 60 a0 0c 93 49 4e 5a  INZ6..p..`...INZ
  22c0: 36 0a 16 70 0a 02 60 a4 60 5b 82 47 06 4c 4e 4b  6..p..`.`[.G.LNK
  22d0: 31 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44  1._HID.A...._UID
  22e0: 0a 01 14 14 5f 53 54 41 00 a0 08 49 4e 54 41 a4  ...._STA...INTA.
  22f0: 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42  ........._PRS..B
  2300: 55 46 41 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54  UFA.._DIS.p..INT
  2310: 41 14 0f 5f 43 52 53 00 a4 43 52 53 5f 49 4e 54  A.._CRS..CRS_INT
  2320: 41 14 10 5f 53 52 53 01 70 53 52 53 5f 68 49 4e  A.._SRS.pSRS_hIN
  2330: 54 41 5b 82 47 06 4c 4e 4b 32 08 5f 48 49 44 0c  TA[.G.LNK2._HID.
  2340: 41 d0 0c 0f 08 5f 55 49 44 0a 02 14 14 5f 53 54  A...._UID...._ST
  2350: 41 00 a0 08 49 4e 54 42 a4 0a 0b a1 04 a4 0a 09  A...INTB........
  2360: 14 0b 5f 50 52 53 00 a4 42 55 46 41 14 0d 5f 44  .._PRS..BUFA.._D
  2370: 49 53 00 70 0a 00 49 4e 54 42 14 0f 5f 43 52 53  IS.p..INTB.._CRS
  2380: 00 a4 43 52 53 5f 49 4e 54 42 14 10 5f 53 52 53  ..CRS_INTB.._SRS
  2390: 01 70 53 52 53 5f 68 49 4e 54 42 5b 82 47 06 4c  .pSRS_hINTB[.G.L
  23a0: 4e 4b 33 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  NK3._HID.A...._U
  23b0: 49 44 0a 03 14 14 5f 53 54 41 00 a0 08 49 4e 54  ID...._STA...INT
  23c0: 43 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00  C.........._PRS.
  23d0: a4 42 55 46 41 14 0d 5f 44 49 53 00 70 0a 00 49  .BUFA.._DIS.p..I
  23e0: 4e 54 43 14 0f 5f 43 52 53 00 a4 43 52 53 5f 49  NTC.._CRS..CRS_I
  23f0: 4e 54 43 14 10 5f 53 52 53 01 70 53 52 53 5f 68  NTC.._SRS.pSRS_h
  2400: 49 4e 54 43 5b 82 47 06 4c 4e 4b 34 08 5f 48 49  INTC[.G.LNK4._HI
  2410: 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 04 14 14 5f  D.A...._UID...._
  2420: 53 54 41 00 a0 08 49 4e 54 44 a4 0a 0b a1 04 a4  STA...INTD......
  2430: 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 41 14 0d  ...._PRS..BUFA..
  2440: 5f 44 49 53 00 70 0a 00 49 4e 54 44 14 0f 5f 43  _DIS.p..INTD.._C
  2450: 52 53 00 a4 43 52 53 5f 49 4e 54 44 14 10 5f 53  RS..CRS_INTD.._S
  2460: 52 53 01 70 53 52 53 5f 68 49 4e 54 44 5b 82 47  RS.pSRS_hINTD[.G
  2470: 06 4c 4e 4b 35 08 5f 48 49 44 0c 41 d0 0c 0f 08  .LNK5._HID.A....
  2480: 5f 55 49 44 0a 05 14 14 5f 53 54 41 00 a0 08 49  _UID...._STA...I
  2490: 4e 54 45 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52  NTE.........._PR
  24a0: 53 00 a4 42 55 46 41 14 0d 5f 44 49 53 00 70 0a  S..BUFA.._DIS.p.
  24b0: 00 49 4e 54 45 14 0f 5f 43 52 53 00 a4 43 52 53  .INTE.._CRS..CRS
  24c0: 5f 49 4e 54 45 14 10 5f 53 52 53 01 70 53 52 53  _INTE.._SRS.pSRS
  24d0: 5f 68 49 4e 54 45 5b 82 47 06 4c 55 42 41 08 5f  _hINTE[.G.LUBA._
  24e0: 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 06 14  HID.A...._UID...
  24f0: 14 5f 53 54 41 00 a0 08 49 4e 54 47 a4 0a 0b a1  ._STA...INTG....
  2500: 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 41  ......_PRS..BUFA
  2510: 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54 47 14 0f  .._DIS.p..INTG..
  2520: 5f 43 52 53 00 a4 43 52 53 5f 49 4e 54 47 14 10  _CRS..CRS_INTG..
  2530: 5f 53 52 53 01 70 53 52 53 5f 68 49 4e 54 47 5b  _SRS.pSRS_hINTG[
  2540: 82 47 06 4c 55 42 42 08 5f 48 49 44 0c 41 d0 0c  .G.LUBB._HID.A..
  2550: 0f 08 5f 55 49 44 0a 07 14 14 5f 53 54 41 00 a0  .._UID...._STA..
  2560: 08 49 4e 54 48 a4 0a 0b a1 04 a4 0a 09 14 0b 5f  .INTH.........._
  2570: 50 52 53 00 a4 42 55 46 41 14 0d 5f 44 49 53 00  PRS..BUFA.._DIS.
  2580: 70 0a 00 49 4e 54 48 14 0f 5f 43 52 53 00 a4 43  p..INTH.._CRS..C
  2590: 52 53 5f 49 4e 54 48 14 10 5f 53 52 53 01 70 53  RS_INTH.._SRS.pS
  25a0: 52 53 5f 68 49 4e 54 48 5b 82 47 06 4c 4d 41 43  RS_hINTH[.G.LMAC
  25b0: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  25c0: 08 14 14 5f 53 54 41 00 a0 08 49 4e 54 4a a4 0a  ..._STA...INTJ..
  25d0: 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55  ........_PRS..BU
  25e0: 46 41 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54 4a  FA.._DIS.p..INTJ
  25f0: 14 0f 5f 43 52 53 00 a4 43 52 53 5f 49 4e 54 4a  .._CRS..CRS_INTJ
  2600: 14 10 5f 53 52 53 01 70 53 52 53 5f 68 49 4e 54  .._SRS.pSRS_hINT
  2610: 4a 5b 82 47 06 4c 41 50 55 08 5f 48 49 44 0c 41  J[.G.LAPU._HID.A
  2620: d0 0c 0f 08 5f 55 49 44 0a 09 14 14 5f 53 54 41  ...._UID...._STA
  2630: 00 a0 08 49 4e 54 4b a4 0a 0b a1 04 a4 0a 09 14  ...INTK.........
  2640: 0b 5f 50 52 53 00 a4 42 55 46 41 14 0d 5f 44 49  ._PRS..BUFA.._DI
  2650: 53 00 70 0a 00 49 4e 54 4b 14 0f 5f 43 52 53 00  S.p..INTK.._CRS.
  2660: a4 43 52 53 5f 49 4e 54 4b 14 10 5f 53 52 53 01  .CRS_INTK.._SRS.
  2670: 70 53 52 53 5f 68 49 4e 54 4b 5b 82 47 06 4c 41  pSRS_hINTK[.G.LA
  2680: 43 49 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  CI._HID.A...._UI
  2690: 44 0a 0a 14 14 5f 53 54 41 00 a0 08 49 4e 54 4c  D...._STA...INTL
  26a0: a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4  .........._PRS..
  26b0: 42 55 46 41 14 0d 5f 44 49 53 00 70 0a 00 49 4e  BUFA.._DIS.p..IN
  26c0: 54 4c 14 0f 5f 43 52 53 00 a4 43 52 53 5f 49 4e  TL.._CRS..CRS_IN
  26d0: 54 4c 14 10 5f 53 52 53 01 70 53 52 53 5f 68 49  TL.._SRS.pSRS_hI
  26e0: 4e 54 4c 5b 82 47 06 4c 4d 43 49 08 5f 48 49 44  NTL[.G.LMCI._HID
  26f0: 0c 41 d0 0c 0f 08 5f 55 49 44 0a 0b 14 14 5f 53  .A...._UID...._S
  2700: 54 41 00 a0 08 49 4e 54 4d a4 0a 0b a1 04 a4 0a  TA...INTM.......
  2710: 09 14 0b 5f 50 52 53 00 a4 42 55 46 41 14 0d 5f  ..._PRS..BUFA.._
  2720: 44 49 53 00 70 0a 00 49 4e 54 4d 14 0f 5f 43 52  DIS.p..INTM.._CR
  2730: 53 00 a4 43 52 53 5f 49 4e 54 4d 14 10 5f 53 52  S..CRS_INTM.._SR
  2740: 53 01 70 53 52 53 5f 68 49 4e 54 4d 5b 82 47 06  S.pSRS_hINTM[.G.
  2750: 4c 53 4d 42 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  LSMB._HID.A...._
  2760: 55 49 44 0a 0c 14 14 5f 53 54 41 00 a0 08 49 4e  UID...._STA...IN
  2770: 54 46 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53  TF.........._PRS
  2780: 00 a4 42 55 46 41 14 0d 5f 44 49 53 00 70 0a 00  ..BUFA.._DIS.p..
  2790: 49 4e 54 46 14 0f 5f 43 52 53 00 a4 43 52 53 5f  INTF.._CRS..CRS_
  27a0: 49 4e 54 46 14 10 5f 53 52 53 01 70 53 52 53 5f  INTF.._SRS.pSRS_
  27b0: 68 49 4e 54 46 5b 82 47 06 4c 55 42 32 08 5f 48  hINTF[.G.LUB2._H
  27c0: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 0d 14 14  ID.A...._UID....
  27d0: 5f 53 54 41 00 a0 08 49 4e 54 51 a4 0a 0b a1 04  _STA...INTQ.....
  27e0: a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 41 14  ....._PRS..BUFA.
  27f0: 0d 5f 44 49 53 00 70 0a 00 49 4e 54 51 14 0f 5f  ._DIS.p..INTQ.._
  2800: 43 52 53 00 a4 43 52 53 5f 49 4e 54 51 14 10 5f  CRS..CRS_INTQ.._
  2810: 53 52 53 01 70 53 52 53 5f 68 49 4e 54 51 5b 82  SRS.pSRS_hINTQ[.
  2820: 47 06 4c 46 49 52 08 5f 48 49 44 0c 41 d0 0c 0f  G.LFIR._HID.A...
  2830: 08 5f 55 49 44 0a 0e 14 14 5f 53 54 41 00 a0 08  ._UID...._STA...
  2840: 49 4e 54 55 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50  INTU.........._P
  2850: 52 53 00 a4 42 55 46 41 14 0d 5f 44 49 53 00 70  RS..BUFA.._DIS.p
  2860: 0a 00 49 4e 54 55 14 0f 5f 43 52 53 00 a4 43 52  ..INTU.._CRS..CR
  2870: 53 5f 49 4e 54 55 14 10 5f 53 52 53 01 70 53 52  S_INTU.._SRS.pSR
  2880: 53 5f 68 49 4e 54 55 5b 82 47 06 4c 33 43 4d 08  S_hINTU[.G.L3CM.
  2890: 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 0f  _HID.A...._UID..
  28a0: 14 14 5f 53 54 41 00 a0 08 49 4e 54 53 a4 0a 0b  .._STA...INTS...
  28b0: a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46  ......._PRS..BUF
  28c0: 41 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54 53 14  A.._DIS.p..INTS.
  28d0: 0f 5f 43 52 53 00 a4 43 52 53 5f 49 4e 54 53 14  ._CRS..CRS_INTS.
  28e0: 10 5f 53 52 53 01 70 53 52 53 5f 68 49 4e 54 53  ._SRS.pSRS_hINTS
  28f0: 5b 82 48 07 4c 49 44 45 08 5f 48 49 44 0c 41 d0  [.H.LIDE._HID.A.
  2900: 0c 0f 08 5f 55 49 44 0a 10 14 14 5f 53 54 41 00  ..._UID...._STA.
  2910: a0 08 49 4e 54 4e a4 0a 0b a1 04 a4 0a 09 14 0b  ..INTN..........
  2920: 5f 50 52 53 00 a4 42 55 46 41 14 14 5f 44 49 53  _PRS..BUFA.._DIS
  2930: 00 70 0a 00 49 4e 54 4e 70 0a 00 49 4e 54 50 14  .p..INTNp..INTP.
  2940: 0f 5f 43 52 53 00 a4 43 52 53 5f 49 4e 54 4e 14  ._CRS..CRS_INTN.
  2950: 1a 5f 53 52 53 01 70 53 52 53 5f 68 49 4e 54 4e  ._SRS.pSRS_hINTN
  2960: 70 53 52 53 5f 68 49 4e 54 50 08 42 55 46 31 11  pSRS_hINTP.BUF1.
  2970: 0e 0a 0b 89 06 00 09 01 10 00 00 00 79 00 08 42  ............y..B
  2980: 55 46 32 11 0e 0a 0b 89 06 00 09 01 11 00 00 00  UF2.............
  2990: 79 00 08 42 55 46 33 11 0e 0a 0b 89 06 00 09 01  y..BUF3.........
  29a0: 12 00 00 00 79 00 08 42 55 46 34 11 0e 0a 0b 89  ....y..BUF4.....
  29b0: 06 00 09 01 13 00 00 00 79 00 08 42 55 46 46 11  ........y..BUFF.
  29c0: 16 0a 13 89 0e 00 09 03 14 00 00 00 15 00 00 00  ................
  29d0: 16 00 00 00 79 00 08 42 55 46 49 11 0e 0a 0b 89  ....y..BUFI.....
  29e0: 06 00 09 01 17 00 00 00 79 00 08 49 52 5a 31 11  ........y..IRZ1.
  29f0: 0e 0a 0b 89 06 00 09 01 07 00 00 00 79 00 5b 82  ............y.[.
  2a00: 42 07 41 50 43 31 08 5f 48 49 44 0c 41 d0 0c 0f  B.APC1._HID.A...
  2a10: 08 5f 55 49 44 0a 0b 14 14 5f 53 54 41 00 a0 08  ._UID...._STA...
  2a20: 49 4e 54 41 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50  INTA.........._P
  2a30: 52 53 00 a4 42 55 46 31 14 0d 5f 44 49 53 00 70  RS..BUF1.._DIS.p
  2a40: 0a 00 49 4e 54 41 14 1d 5f 43 52 53 00 8b 49 52  ..INTA.._CRS..IR
  2a50: 5a 31 0a 05 49 52 51 31 70 0a 10 49 52 51 31 a4  Z1..IRQ1p..IRQ1.
  2a60: 49 52 5a 31 14 0d 5f 53 52 53 01 70 0a 08 49 4e  IRZ1.._SRS.p..IN
  2a70: 54 41 5b 82 42 07 41 50 43 32 08 5f 48 49 44 0c  TA[.B.APC2._HID.
  2a80: 41 d0 0c 0f 08 5f 55 49 44 0a 0c 14 14 5f 53 54  A...._UID...._ST
  2a90: 41 00 a0 08 49 4e 54 42 a4 0a 0b a1 04 a4 0a 09  A...INTB........
  2aa0: 14 0b 5f 50 52 53 00 a4 42 55 46 32 14 0d 5f 44  .._PRS..BUF2.._D
  2ab0: 49 53 00 70 0a 00 49 4e 54 42 14 1d 5f 43 52 53  IS.p..INTB.._CRS
  2ac0: 00 8b 49 52 5a 31 0a 05 49 52 51 31 70 0a 11 49  ..IRZ1..IRQ1p..I
  2ad0: 52 51 31 a4 49 52 5a 31 14 0d 5f 53 52 53 01 70  RQ1.IRZ1.._SRS.p
  2ae0: 0a 01 49 4e 54 42 5b 82 42 07 41 50 43 33 08 5f  ..INTB[.B.APC3._
  2af0: 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 0d 14  HID.A...._UID...
  2b00: 14 5f 53 54 41 00 a0 08 49 4e 54 43 a4 0a 0b a1  ._STA...INTC....
  2b10: 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 33  ......_PRS..BUF3
  2b20: 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54 43 14 1d  .._DIS.p..INTC..
  2b30: 5f 43 52 53 00 8b 49 52 5a 31 0a 05 49 52 51 31  _CRS..IRZ1..IRQ1
  2b40: 70 0a 12 49 52 51 31 a4 49 52 5a 31 14 0d 5f 53  p..IRQ1.IRZ1.._S
  2b50: 52 53 01 70 0a 02 49 4e 54 43 5b 82 42 07 41 50  RS.p..INTC[.B.AP
  2b60: 43 34 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  C4._HID.A...._UI
  2b70: 44 0a 0e 14 14 5f 53 54 41 00 a0 08 49 4e 54 44  D...._STA...INTD
  2b80: a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4  .........._PRS..
  2b90: 42 55 46 34 14 0d 5f 44 49 53 00 70 0a 00 49 4e  BUF4.._DIS.p..IN
  2ba0: 54 44 14 1d 5f 43 52 53 00 8b 49 52 5a 31 0a 05  TD.._CRS..IRZ1..
  2bb0: 49 52 51 31 70 0a 13 49 52 51 31 a4 49 52 5a 31  IRQ1p..IRQ1.IRZ1
  2bc0: 14 0d 5f 53 52 53 01 70 0a 0d 49 4e 54 44 5b 82  .._SRS.p..INTD[.
  2bd0: 42 07 41 50 43 35 08 5f 48 49 44 0c 41 d0 0c 0f  B.APC5._HID.A...
  2be0: 08 5f 55 49 44 0a 0f 14 14 5f 53 54 41 00 a0 08  ._UID...._STA...
  2bf0: 49 4e 54 45 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50  INTE.........._P
  2c00: 52 53 00 a4 42 55 46 31 14 0d 5f 44 49 53 00 70  RS..BUF1.._DIS.p
  2c10: 0a 00 49 4e 54 45 14 1d 5f 43 52 53 00 8b 49 52  ..INTE.._CRS..IR
  2c20: 5a 31 0a 05 49 52 51 31 70 0a 10 49 52 51 31 a4  Z1..IRQ1p..IRQ1.
  2c30: 49 52 5a 31 14 0d 5f 53 52 53 01 70 0a 08 49 4e  IRZ1.._SRS.p..IN
  2c40: 54 45 5b 82 47 06 41 50 43 46 08 5f 48 49 44 0c  TE[.G.APCF._HID.
  2c50: 41 d0 0c 0f 08 5f 55 49 44 0a 10 14 14 5f 53 54  A...._UID...._ST
  2c60: 41 00 a0 08 49 4e 54 47 a4 0a 0b a1 04 a4 0a 09  A...INTG........
  2c70: 14 0b 5f 50 52 53 00 a4 42 55 46 46 14 0d 5f 44  .._PRS..BUFF.._D
  2c80: 49 53 00 70 0a 00 49 4e 54 47 14 0f 5f 43 52 53  IS.p..INTG.._CRS
  2c90: 00 a4 43 52 53 41 49 4e 54 47 14 10 5f 53 52 53  ..CRSAINTG.._SRS
  2ca0: 01 70 53 52 53 41 68 49 4e 54 47 5b 82 47 06 41  .pSRSAhINTG[.G.A
  2cb0: 50 43 47 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  PCG._HID.A...._U
  2cc0: 49 44 0a 11 14 14 5f 53 54 41 00 a0 08 49 4e 54  ID...._STA...INT
  2cd0: 48 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00  H.........._PRS.
  2ce0: a4 42 55 46 46 14 0d 5f 44 49 53 00 70 0a 00 49  .BUFF.._DIS.p..I
  2cf0: 4e 54 48 14 0f 5f 43 52 53 00 a4 43 52 53 41 49  NTH.._CRS..CRSAI
  2d00: 4e 54 48 14 10 5f 53 52 53 01 70 53 52 53 41 68  NTH.._SRS.pSRSAh
  2d10: 49 4e 54 48 5b 82 47 06 41 50 43 48 08 5f 48 49  INTH[.G.APCH._HI
  2d20: 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 12 14 14 5f  D.A...._UID...._
  2d30: 53 54 41 00 a0 08 49 4e 54 4a a4 0a 0b a1 04 a4  STA...INTJ......
  2d40: 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 46 14 0d  ...._PRS..BUFF..
  2d50: 5f 44 49 53 00 70 0a 00 49 4e 54 4a 14 0f 5f 43  _DIS.p..INTJ.._C
  2d60: 52 53 00 a4 43 52 53 41 49 4e 54 4a 14 10 5f 53  RS..CRSAINTJ.._S
  2d70: 52 53 01 70 53 52 53 41 68 49 4e 54 4a 5b 82 47  RS.pSRSAhINTJ[.G
  2d80: 06 41 50 43 49 08 5f 48 49 44 0c 41 d0 0c 0f 08  .APCI._HID.A....
  2d90: 5f 55 49 44 0a 1a 14 14 5f 53 54 41 00 a0 08 49  _UID...._STA...I
  2da0: 4e 54 4b a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52  NTK.........._PR
  2db0: 53 00 a4 42 55 46 46 14 0d 5f 44 49 53 00 70 0a  S..BUFF.._DIS.p.
  2dc0: 00 49 4e 54 4b 14 0f 5f 43 52 53 00 a4 43 52 53  .INTK.._CRS..CRS
  2dd0: 41 49 4e 54 4b 14 10 5f 53 52 53 01 70 53 52 53  AINTK.._SRS.pSRS
  2de0: 41 68 49 4e 54 4b 5b 82 47 06 41 50 43 4a 08 5f  AhINTK[.G.APCJ._
  2df0: 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 1b 14  HID.A...._UID...
  2e00: 14 5f 53 54 41 00 a0 08 49 4e 54 4c a4 0a 0b a1  ._STA...INTL....
  2e10: 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 46  ......_PRS..BUFF
  2e20: 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54 4c 14 0f  .._DIS.p..INTL..
  2e30: 5f 43 52 53 00 a4 43 52 53 41 49 4e 54 4c 14 10  _CRS..CRSAINTL..
  2e40: 5f 53 52 53 01 70 53 52 53 41 68 49 4e 54 4c 5b  _SRS.pSRSAhINTL[
  2e50: 82 47 06 41 50 43 4b 08 5f 48 49 44 0c 41 d0 0c  .G.APCK._HID.A..
  2e60: 0f 08 5f 55 49 44 0a 1c 14 14 5f 53 54 41 00 a0  .._UID...._STA..
  2e70: 08 49 4e 54 4d a4 0a 0b a1 04 a4 0a 09 14 0b 5f  .INTM.........._
  2e80: 50 52 53 00 a4 42 55 46 46 14 0d 5f 44 49 53 00  PRS..BUFF.._DIS.
  2e90: 70 0a 00 49 4e 54 4d 14 0f 5f 43 52 53 00 a4 43  p..INTM.._CRS..C
  2ea0: 52 53 41 49 4e 54 4d 14 10 5f 53 52 53 01 70 53  RSAINTM.._SRS.pS
  2eb0: 52 53 41 68 49 4e 54 4d 5b 82 42 07 41 50 43 53  RSAhINTM[.B.APCS
  2ec0: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  2ed0: 1d 14 14 5f 53 54 41 00 a0 08 49 4e 54 46 a4 0a  ..._STA...INTF..
  2ee0: 0b a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55  ........_PRS..BU
  2ef0: 46 49 14 0d 5f 44 49 53 00 70 0a 00 49 4e 54 46  FI.._DIS.p..INTF
  2f00: 14 1d 5f 43 52 53 00 8b 49 52 5a 31 0a 05 49 52  .._CRS..IRZ1..IR
  2f10: 51 31 70 0a 17 49 52 51 31 a4 49 52 5a 31 14 0d  Q1p..IRQ1.IRZ1..
  2f20: 5f 53 52 53 01 70 0a 02 49 4e 54 46 5b 82 47 06  _SRS.p..INTF[.G.
  2f30: 41 50 43 4c 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  APCL._HID.A...._
  2f40: 55 49 44 0a 1e 14 14 5f 53 54 41 00 a0 08 49 4e  UID...._STA...IN
  2f50: 54 51 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50 52 53  TQ.........._PRS
  2f60: 00 a4 42 55 46 46 14 0d 5f 44 49 53 00 70 0a 00  ..BUFF.._DIS.p..
  2f70: 49 4e 54 51 14 0f 5f 43 52 53 00 a4 43 52 53 41  INTQ.._CRS..CRSA
  2f80: 49 4e 54 51 14 10 5f 53 52 53 01 70 53 52 53 41  INTQ.._SRS.pSRSA
  2f90: 68 49 4e 54 51 5b 82 47 06 41 50 43 4d 08 5f 48  hINTQ[.G.APCM._H
  2fa0: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 1f 14 14  ID.A...._UID....
  2fb0: 5f 53 54 41 00 a0 08 49 4e 54 55 a4 0a 0b a1 04  _STA...INTU.....
  2fc0: a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46 46 14  ....._PRS..BUFF.
  2fd0: 0d 5f 44 49 53 00 70 0a 00 49 4e 54 55 14 0f 5f  ._DIS.p..INTU.._
  2fe0: 43 52 53 00 a4 43 52 53 41 49 4e 54 55 14 10 5f  CRS..CRSAINTU.._
  2ff0: 53 52 53 01 70 53 52 53 41 68 49 4e 54 55 5b 82  SRS.pSRSAhINTU[.
  3000: 47 06 41 50 33 43 08 5f 48 49 44 0c 41 d0 0c 0f  G.AP3C._HID.A...
  3010: 08 5f 55 49 44 0a 20 14 14 5f 53 54 41 00 a0 08  ._UID. .._STA...
  3020: 49 4e 54 53 a4 0a 0b a1 04 a4 0a 09 14 0b 5f 50  INTS.........._P
  3030: 52 53 00 a4 42 55 46 46 14 0d 5f 44 49 53 00 70  RS..BUFF.._DIS.p
  3040: 0a 00 49 4e 54 53 14 0f 5f 43 52 53 00 a4 43 52  ..INTS.._CRS..CR
  3050: 53 41 49 4e 54 53 14 10 5f 53 52 53 01 70 53 52  SAINTS.._SRS.pSR
  3060: 53 41 68 49 4e 54 53 5b 82 48 07 41 50 43 5a 08  SAhINTS[.H.APCZ.
  3070: 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 21  _HID.A...._UID.!
  3080: 14 14 5f 53 54 41 00 a0 08 49 4e 54 4e a4 0a 0b  .._STA...INTN...
  3090: a1 04 a4 0a 09 14 0b 5f 50 52 53 00 a4 42 55 46  ......._PRS..BUF
  30a0: 46 14 14 5f 44 49 53 00 70 0a 00 49 4e 54 4e 70  F.._DIS.p..INTNp
  30b0: 0a 00 49 4e 54 50 14 0f 5f 43 52 53 00 a4 43 52  ..INTP.._CRS..CR
  30c0: 53 41 49 4e 54 4e 14 1a 5f 53 52 53 01 70 53 52  SAINTN.._SRS.pSR
  30d0: 53 41 68 49 4e 54 4e 70 53 52 53 41 68 49 4e 54  SAhINTNpSRSAhINT
  30e0: 50 10 1e 5c 00 5b 80 5c 53 43 50 50 01 0b 2e 44  P..\.[.\SCPP...D
  30f0: 0a 01 5b 81 0c 5c 53 43 50 50 01 53 4d 49 50 08  ..[..\SCPP.SMIP.
  3100: 14 4f 0a 5c 2f 03 5f 53 42 5f 50 43 49 30 5f 49  .O.\/._SB_PCI0_I
  3110: 4e 49 00 a0 24 53 54 52 43 5c 5f 4f 53 5f 0d 4d  NI..$STRC\_OS_.M
  3120: 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73  icrosoft Windows
  3130: 00 70 0a 56 53 4d 49 50 a1 47 07 a0 44 06 53 54  .p.VSMIP.G..D.ST
  3140: 52 43 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66  RC\_OS_.Microsof
  3150: 74 20 57 69 6e 64 6f 77 73 20 4e 54 00 a0 32 5b  t Windows NT..2[
  3160: 12 5f 4f 53 49 60 a0 29 5c 5f 4f 53 49 0d 57 69  ._OSI`.)\_OSI.Wi
  3170: 6e 64 6f 77 73 20 32 30 30 31 00 70 0a 59 53 4d  ndows 2001.p.YSM
  3180: 49 50 70 0a 00 4f 53 46 4c 70 0a 03 4f 53 46 58  IPp..OSFLp..OSFX
  3190: a1 0f 70 0a 58 53 4d 49 50 70 0a 00 4f 53 46 4c  ..p.XSMIPp..OSFL
  31a0: a1 0f 70 0a 57 53 4d 49 50 70 0a 02 4f 53 46 4c  ..p.WSMIPp..OSFL
  31b0: 10 4c 04 5c 00 14 47 04 4f 53 54 50 00 a0 0f 93  .L.\..G.OSTP....
  31c0: 4f 53 46 4c 0a 01 70 0a 56 53 4d 49 50 a0 0f 93  OSFL..p.VSMIP...
  31d0: 4f 53 46 4c 0a 02 70 0a 57 53 4d 49 50 a0 0f 93  OSFL..p.WSMIP...
  31e0: 4f 53 46 4c 0a 00 70 0a 58 53 4d 49 50 a0 0f 93  OSFL..p.XSMIP...
  31f0: 4f 53 46 58 0a 03 70 0a 59 53 4d 49 50 5b 82 43  OSFX..p.YSMIP[.C
  3200: 07 53 59 53 52 08 5f 48 49 44 0c 41 d0 0c 02 08  .SYSR._HID.A....
  3210: 5f 55 49 44 0a 01 08 5f 43 52 53 11 46 05 0a 52  _UID..._CRS.F..R
  3220: 47 01 10 00 10 00 01 10 47 01 22 00 22 00 01 1e  G.......G."."...
  3230: 47 01 44 00 44 00 01 1c 47 01 62 00 62 00 01 02  G.D.D...G.b.b...
  3240: 47 01 65 00 65 00 01 0b 47 01 74 00 74 00 01 0c  G.e.e...G.t.t...
  3250: 47 01 91 00 91 00 01 03 47 01 a2 00 a2 00 01 1e  G.......G.......
  3260: 47 01 e0 00 e0 00 01 10 47 01 d0 04 d0 04 01 02  G.......G.......
  3270: 79 00 5b 82 2b 50 49 43 5f 08 5f 48 49 44 0b 41  y.[.+PIC_._HID.A
  3280: d0 08 5f 43 52 53 11 18 0a 15 47 01 20 00 20 00  .._CRS....G. . .
  3290: 01 02 47 01 a0 00 a0 00 01 02 22 04 00 79 00 5b  ..G......."..y.[
  32a0: 82 3d 44 4d 41 31 08 5f 48 49 44 0c 41 d0 02 00  .=DMA1._HID.A...
  32b0: 08 5f 43 52 53 11 28 0a 25 2a 10 04 47 01 00 00  ._CRS.(.%*..G...
  32c0: 00 00 01 10 47 01 80 00 80 00 01 11 47 01 94 00  ....G.......G...
  32d0: 94 00 01 0c 47 01 c0 00 c0 00 01 20 79 00 5b 82  ....G...... y.[.
  32e0: 25 54 4d 52 5f 08 5f 48 49 44 0c 41 d0 01 00 08  %TMR_._HID.A....
  32f0: 5f 43 52 53 11 10 0a 0d 47 01 40 00 40 00 01 04  _CRS....G.@.@...
  3300: 22 01 00 79 00 5b 82 25 52 54 43 5f 08 5f 48 49  "..y.[.%RTC_._HI
  3310: 44 0c 41 d0 0b 00 08 5f 43 52 53 11 10 0a 0d 47  D.A...._CRS....G
  3320: 01 70 00 70 00 04 04 22 00 01 79 00 5b 82 22 53  .p.p..."..y.[."S
  3330: 50 4b 52 08 5f 48 49 44 0c 41 d0 08 00 08 5f 43  PKR._HID.A...._C
  3340: 52 53 11 0d 0a 0a 47 01 61 00 61 00 01 01 79 00  RS....G.a.a...y.
  3350: 5b 82 25 43 4f 50 52 08 5f 48 49 44 0c 41 d0 0c  [.%COPR._HID.A..
  3360: 04 08 5f 43 52 53 11 10 0a 0d 47 01 f0 00 f0 00  .._CRS....G.....
  3370: 01 10 22 00 20 79 00 10 4d 0d 5c 00 5b 80 57 49  ..". y..M.\.[.WI
  3380: 4e 31 01 0a 2e 0a 02 5b 81 10 57 49 4e 31 01 49  N1.....[..WIN1.I
  3390: 4e 44 50 08 44 41 54 50 08 5b 86 42 07 49 4e 44  NDP.DATP.[.B.IND
  33a0: 50 44 41 54 50 01 00 10 43 46 47 5f 08 00 20 4c  PDATP...CFG_.. L
  33b0: 44 4e 5f 08 00 40 0c 49 44 48 49 08 49 44 4c 4f  DN_..@.IDHI.IDLO
  33c0: 08 50 4f 57 43 08 00 48 06 41 43 54 52 08 00 48  .POWC..H.ACTR..H
  33d0: 17 49 4f 41 48 08 49 4f 41 4c 08 49 4f 32 48 08  .IOAH.IOAL.IO2H.
  33e0: 49 4f 32 4c 08 00 40 06 49 4e 54 52 08 00 08 49  IO2L..@.INTR...I
  33f0: 4e 54 31 08 00 08 44 4d 43 48 08 00 48 3d 4f 50  NT1...DMCH..H=OP
  3400: 54 31 08 4f 50 54 32 08 4f 50 54 33 08 14 14 45  T1.OPT2.OPT3...E
  3410: 4e 46 47 00 70 0a 87 49 4e 44 50 70 0a 87 49 4e  NFG.p..INDPp..IN
  3420: 44 50 14 0d 45 58 46 47 00 70 0a 02 43 46 47 5f  DP..EXFG.p..CFG_
  3430: 14 11 47 53 52 47 01 70 68 49 4e 44 50 a4 44 41  ..GSRG.phINDP.DA
  3440: 54 50 14 12 53 53 52 47 02 70 68 49 4e 44 50 70  TP..SSRG.phINDPp
  3450: 69 44 41 54 50 5b 82 46 15 46 44 43 30 08 5f 48  iDATP[.F.FDC0._H
  3460: 49 44 0c 41 d0 07 00 14 3a 5f 53 54 41 00 45 4e  ID.A....:_STA.EN
  3470: 46 47 70 00 4c 44 4e 5f a0 0c 41 43 54 52 45 58  FGp.LDN_..ACTREX
  3480: 46 47 a4 0a 0f a1 1c a0 11 91 49 4f 41 48 49 4f  FG........IOAHIO
  3490: 41 4c 45 58 46 47 a4 0a 0d a1 08 45 58 46 47 a4  ALEXFG.....EXFG.
  34a0: 0a 00 14 2b 5f 44 49 53 00 45 4e 46 47 70 0a 00  ...+_DIS.ENFGp..
  34b0: 4c 44 4e 5f 70 00 41 43 54 52 53 4c 44 4d 44 4d  LDN_p.ACTRSLDMDM
  34c0: 43 48 0a 04 45 58 46 47 44 49 53 44 0a 03 14 41  CH..EXFGDISD...A
  34d0: 06 5f 43 52 53 00 08 42 55 46 30 11 1b 0a 18 47  ._CRS..BUF0....G
  34e0: 01 f0 03 f0 03 01 06 47 01 f7 03 f7 03 01 01 22  .......G......."
  34f0: 40 00 2a 04 00 79 00 8c 42 55 46 30 0a 02 49 4f  @.*..y..BUF0..IO
  3500: 4c 4f 8c 42 55 46 30 0a 03 49 4f 48 49 8c 42 55  LO.BUF0..IOHI.BU
  3510: 46 30 0a 04 49 4f 52 4c 8c 42 55 46 30 0a 05 49  F0..IORL.BUF0..I
  3520: 4f 52 48 45 4e 46 47 45 58 46 47 a4 42 55 46 30  ORHENFGEXFG.BUF0
  3530: 08 5f 50 52 53 11 1d 0a 1a 30 47 01 f0 03 f0 03  ._PRS....0G.....
  3540: 01 06 47 01 f7 03 f7 03 01 01 22 40 00 2a 04 00  ..G......."@.*..
  3550: 38 79 00 14 49 05 5f 53 52 53 01 8c 68 0a 02 49  8y..I._SRS..h..I
  3560: 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8b 68 0a 02 49  OLO.h..IOHI.h..I
  3570: 4f 41 44 8b 68 0a 19 49 52 51 57 8c 68 0a 1c 44  OAD.h..IRQW.h..D
  3580: 4d 41 56 45 4e 46 47 70 00 4c 44 4e 5f 70 01 41  MAVENFGp.LDN_p.A
  3590: 43 54 52 53 4c 44 4d 44 4d 43 48 44 4d 43 48 43  CTRSLDMDMCHDMCHC
  35a0: 4b 49 4f 49 4f 41 44 0a 03 45 58 46 47 5b 82 46  KIOIOAD..EXFG[.F
  35b0: 1b 55 41 52 31 08 5f 48 49 44 0c 41 d0 05 01 08  .UAR1._HID.A....
  35c0: 5f 55 49 44 0a 01 14 3f 5f 53 54 41 00 45 4e 46  _UID...?_STA.ENF
  35d0: 47 70 0a 01 4c 44 4e 5f a0 0c 41 43 54 52 45 58  Gp..LDN_..ACTREX
  35e0: 46 47 a4 0a 0f a1 1c a0 11 91 49 4f 41 48 49 4f  FG........IOAHIO
  35f0: 41 4c 45 58 46 47 a4 0a 0d a1 08 45 58 46 47 a4  ALEXFG.....EXFG.
  3600: 0a 00 45 58 46 47 14 21 5f 44 49 53 00 45 4e 46  ..EXFG.!_DIS.ENF
  3610: 47 70 0a 01 4c 44 4e 5f 70 00 41 43 54 52 45 58  Gp..LDN_p.ACTREX
  3620: 46 47 44 49 53 44 0a 00 14 49 09 5f 43 52 53 00  FGDISD...I._CRS.
  3630: 08 42 55 46 31 11 10 0a 0d 47 01 00 00 00 00 01  .BUF1....G......
  3640: 08 22 00 00 79 00 8c 42 55 46 31 0a 02 49 4f 4c  ."..y..BUF1..IOL
  3650: 4f 8c 42 55 46 31 0a 03 49 4f 48 49 8c 42 55 46  O.BUF1..IOHI.BUF
  3660: 31 0a 04 49 4f 52 4c 8c 42 55 46 31 0a 05 49 4f  1..IORL.BUF1..IO
  3670: 52 48 8b 42 55 46 31 0a 09 49 52 51 57 45 4e 46  RH.BUF1..IRQWENF
  3680: 47 70 0a 01 4c 44 4e 5f 70 49 4f 41 4c 49 4f 4c  Gp..LDN_pIOALIOL
  3690: 4f 70 49 4f 41 4c 49 4f 52 4c 70 49 4f 41 48 49  OpIOALIORLpIOAHI
  36a0: 4f 48 49 70 49 4f 41 48 49 4f 52 48 70 01 60 79  OHIpIOAHIORHp.`y
  36b0: 60 49 4e 54 52 49 52 51 57 45 58 46 47 a4 42 55  `INTRIRQWEXFG.BU
  36c0: 46 31 08 5f 50 52 53 11 36 0a 33 30 47 01 f8 03  F1._PRS.6.30G...
  36d0: f8 03 01 08 22 b8 1e 30 47 01 f8 02 f8 02 01 08  ...."..0G.......
  36e0: 22 b8 1e 30 47 01 e8 03 e8 03 01 08 22 b8 1e 30  "..0G......."..0
  36f0: 47 01 e8 02 e8 02 01 08 22 b8 1e 38 79 00 14 46  G......."..8y..F
  3700: 06 5f 53 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68  ._SRS..h..IOLO.h
  3710: 0a 03 49 4f 48 49 8b 68 0a 02 49 4f 41 44 8b 68  ..IOHI.h..IOAD.h
  3720: 0a 09 49 52 51 57 45 4e 46 47 70 0a 01 4c 44 4e  ..IRQWENFGp..LDN
  3730: 5f 70 01 41 43 54 52 70 49 4f 4c 4f 49 4f 41 4c  _p.ACTRpIOLOIOAL
  3740: 70 49 4f 48 49 49 4f 41 48 82 49 52 51 57 60 74  pIOHIIOAH.IRQW`t
  3750: 60 0a 01 49 4e 54 52 45 58 46 47 43 4b 49 4f 49  `..INTREXFGCKIOI
  3760: 4f 41 44 0a 00 5b 82 43 1f 55 41 52 32 14 31 5f  OAD..[.C.UAR2.1_
  3770: 48 49 44 00 45 4e 46 47 70 0a 02 4c 44 4e 5f 7b  HID.ENFGp..LDN_{
  3780: 4f 50 54 32 0a 07 60 a0 0b 93 60 0a 04 a4 0c 26  OPT2..`...`....&
  3790: 85 87 05 a1 07 a4 0c 41 d0 05 01 45 58 46 47 08  .......A...EXFG.
  37a0: 5f 55 49 44 0a 02 14 44 05 5f 53 54 41 00 45 4e  _UID...D._STA.EN
  37b0: 46 47 70 0a 02 4c 44 4e 5f 7b 4f 50 54 32 0a 07  FGp..LDN_{OPT2..
  37c0: 60 a0 30 92 93 60 0a 01 a0 0c 41 43 54 52 45 58  `.0..`....ACTREX
  37d0: 46 47 a4 0a 0f a1 1c a0 11 91 49 4f 41 48 49 4f  FG........IOAHIO
  37e0: 41 4c 45 58 46 47 a4 0a 0d a1 08 45 58 46 47 a4  ALEXFG.....EXFG.
  37f0: 0a 00 a1 08 45 58 46 47 a4 0a 00 14 21 5f 44 49  ....EXFG....!_DI
  3800: 53 00 45 4e 46 47 70 0a 02 4c 44 4e 5f 70 00 41  S.ENFGp..LDN_p.A
  3810: 43 54 52 45 58 46 47 44 49 53 44 0a 01 14 49 09  CTREXFGDISD...I.
  3820: 5f 43 52 53 00 08 42 55 46 32 11 10 0a 0d 47 01  _CRS..BUF2....G.
  3830: 00 00 00 00 01 08 22 10 00 79 00 8c 42 55 46 32  ......"..y..BUF2
  3840: 0a 02 49 4f 4c 4f 8c 42 55 46 32 0a 03 49 4f 48  ..IOLO.BUF2..IOH
  3850: 49 8c 42 55 46 32 0a 04 49 4f 52 4c 8c 42 55 46  I.BUF2..IORL.BUF
  3860: 32 0a 05 49 4f 52 48 8b 42 55 46 32 0a 09 49 52  2..IORH.BUF2..IR
  3870: 51 57 45 4e 46 47 70 0a 02 4c 44 4e 5f 70 49 4f  QWENFGp..LDN_pIO
  3880: 41 4c 49 4f 4c 4f 70 49 4f 41 4c 49 4f 52 4c 70  ALIOLOpIOALIORLp
  3890: 49 4f 41 48 49 4f 48 49 70 49 4f 41 48 49 4f 52  IOAHIOHIpIOAHIOR
  38a0: 48 70 01 60 79 60 49 4e 54 52 49 52 51 57 45 58  Hp.`y`INTRIRQWEX
  38b0: 46 47 a4 42 55 46 32 08 5f 50 52 53 11 36 0a 33  FG.BUF2._PRS.6.3
  38c0: 30 47 01 f8 03 f8 03 01 08 22 b8 1e 30 47 01 f8  0G......."..0G..
  38d0: 02 f8 02 01 08 22 b8 1e 30 47 01 e8 03 e8 03 01  ....."..0G......
  38e0: 08 22 b8 1e 30 47 01 e8 02 e8 02 01 08 22 b8 1e  ."..0G......."..
  38f0: 38 79 00 14 46 06 5f 53 52 53 01 8c 68 0a 02 49  8y..F._SRS..h..I
  3900: 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8b 68 0a 02 49  OLO.h..IOHI.h..I
  3910: 4f 41 44 8b 68 0a 09 49 52 51 57 45 4e 46 47 70  OAD.h..IRQWENFGp
  3920: 0a 02 4c 44 4e 5f 70 01 41 43 54 52 70 49 4f 4c  ..LDN_p.ACTRpIOL
  3930: 4f 49 4f 41 4c 70 49 4f 48 49 49 4f 41 48 82 49  OIOALpIOHIIOAH.I
  3940: 52 51 57 60 74 60 0a 01 49 4e 54 52 45 58 46 47  RQW`t`..INTREXFG
  3950: 43 4b 49 4f 49 4f 41 44 0a 01 5b 82 4d 1c 49 52  CKIOIOAD..[.M.IR
  3960: 44 41 08 5f 48 49 44 0c 41 d0 05 10 14 43 05 5f  DA._HID.A....C._
  3970: 53 54 41 00 45 4e 46 47 70 0a 02 4c 44 4e 5f 7b  STA.ENFGp..LDN_{
  3980: 4f 50 54 32 0a 07 60 a0 2f 93 60 0a 01 a0 0c 41  OPT2..`./.`....A
  3990: 43 54 52 45 58 46 47 a4 0a 0f a1 1c a0 11 91 49  CTREXFG........I
  39a0: 4f 41 48 49 4f 41 4c 45 58 46 47 a4 0a 0d a1 08  OAHIOALEXFG.....
  39b0: 45 58 46 47 a4 0a 00 a1 08 45 58 46 47 a4 0a 00  EXFG.....EXFG...
  39c0: 14 2d 5f 44 49 53 00 a0 23 93 44 49 53 45 0a 01  .-_DIS..#.DISE..
  39d0: 45 4e 46 47 70 0a 02 4c 44 4e 5f 70 00 41 43 54  ENFGp..LDN_p.ACT
  39e0: 52 45 58 46 47 44 49 53 44 0a 01 70 60 60 14 47  REXFGDISD..p``.G
  39f0: 09 5f 43 52 53 00 08 42 55 46 34 11 10 0a 0d 47  ._CRS..BUF4....G
  3a00: 01 00 00 00 00 01 08 22 00 00 79 00 8c 42 55 46  ......."..y..BUF
  3a10: 34 0a 02 49 4f 4c 4f 8c 42 55 46 34 0a 03 49 4f  4..IOLO.BUF4..IO
  3a20: 48 49 8c 42 55 46 34 0a 04 49 4f 52 4c 8c 42 55  HI.BUF4..IORL.BU
  3a30: 46 34 0a 05 49 4f 52 48 8b 42 55 46 34 0a 09 49  F4..IORH.BUF4..I
  3a40: 52 51 57 45 4e 46 47 70 0a 02 4c 44 4e 5f 70 49  RQWENFGp..LDN_pI
  3a50: 4f 41 4c 49 4f 4c 4f 70 49 4f 41 4c 49 4f 52 4c  OALIOLOpIOALIORL
  3a60: 70 49 4f 41 48 49 4f 48 49 70 49 4f 41 48 49 4f  pIOAHIOHIpIOAHIO
  3a70: 52 48 79 0a 01 49 4e 54 52 49 52 51 57 45 58 46  RHy..INTRIRQWEXF
  3a80: 47 a4 42 55 46 34 08 5f 50 52 53 11 36 0a 33 30  G.BUF4._PRS.6.30
  3a90: 47 01 f8 03 f8 03 01 08 22 b8 1e 30 47 01 f8 02  G......."..0G...
  3aa0: f8 02 01 08 22 b8 1e 30 47 01 e8 03 e8 03 01 08  ...."..0G.......
  3ab0: 22 b8 1e 30 47 01 e8 02 e8 02 01 08 22 b8 1e 38  "..0G......."..8
  3ac0: 79 00 14 46 06 5f 53 52 53 01 8c 68 0a 02 49 4f  y..F._SRS..h..IO
  3ad0: 4c 4f 8c 68 0a 03 49 4f 48 49 8b 68 0a 02 49 4f  LO.h..IOHI.h..IO
  3ae0: 41 44 8b 68 0a 09 49 52 51 57 45 4e 46 47 70 0a  AD.h..IRQWENFGp.
  3af0: 02 4c 44 4e 5f 70 01 41 43 54 52 70 49 4f 4c 4f  .LDN_p.ACTRpIOLO
  3b00: 49 4f 41 4c 70 49 4f 48 49 49 4f 41 48 82 49 52  IOALpIOHIIOAH.IR
  3b10: 51 57 60 74 60 0a 01 49 4e 54 52 45 58 46 47 43  QW`t`..INTREXFGC
  3b20: 4b 49 4f 49 4f 41 44 0a 01 5b 82 42 1f 4c 50 54  KIOIOAD..[.B.LPT
  3b30: 31 08 5f 48 49 44 0c 41 d0 04 00 14 44 05 5f 53  1._HID.A....D._S
  3b40: 54 41 00 45 4e 46 47 70 0a 03 4c 44 4e 5f 7b 4f  TA.ENFGp..LDN_{O
  3b50: 50 54 31 0a 02 60 a0 30 92 93 60 0a 02 a0 0c 41  PT1..`.0..`....A
  3b60: 43 54 52 45 58 46 47 a4 0a 0f a1 1c a0 11 91 49  CTREXFG........I
  3b70: 4f 41 48 49 4f 41 4c 45 58 46 47 a4 0a 0d a1 08  OAHIOALEXFG.....
  3b80: 45 58 46 47 a4 0a 00 a1 08 45 58 46 47 a4 0a 00  EXFG.....EXFG...
  3b90: 14 21 5f 44 49 53 00 45 4e 46 47 70 0a 03 4c 44  .!_DIS.ENFGp..LD
  3ba0: 4e 5f 70 00 41 43 54 52 45 58 46 47 44 49 53 44  N_p.ACTREXFGDISD
  3bb0: 0a 02 14 40 0c 5f 43 52 53 00 08 42 55 46 35 11  ...@._CRS..BUF5.
  3bc0: 10 0a 0d 47 01 00 00 00 00 01 08 22 00 00 79 00  ...G......."..y.
  3bd0: 8c 42 55 46 35 0a 02 49 4f 4c 4f 8c 42 55 46 35  .BUF5..IOLO.BUF5
  3be0: 0a 03 49 4f 48 49 8c 42 55 46 35 0a 04 49 4f 52  ..IOHI.BUF5..IOR
  3bf0: 4c 8c 42 55 46 35 0a 05 49 4f 52 48 8c 42 55 46  L.BUF5..IORH.BUF
  3c00: 35 0a 07 49 4f 4c 45 8b 42 55 46 35 0a 09 49 52  5..IOLE.BUF5..IR
  3c10: 51 57 45 4e 46 47 70 0a 03 4c 44 4e 5f 70 49 4f  QWENFGp..LDN_pIO
  3c20: 41 4c 49 4f 4c 4f 70 49 4f 4c 4f 49 4f 52 4c 70  ALIOLOpIOLOIORLp
  3c30: 49 4f 41 48 49 4f 48 49 70 49 4f 48 49 49 4f 52  IOAHIOHIpIOHIIOR
  3c40: 48 a0 0f 93 49 4f 4c 4f 0a bc 70 0a 04 49 4f 4c  H...IOLO..p..IOL
  3c50: 45 a1 08 70 0a 08 49 4f 4c 45 70 01 60 70 49 4e  E..p..IOLEp.`pIN
  3c60: 54 52 65 79 60 65 49 52 51 57 45 58 46 47 a4 42  TRey`eIRQWEXFG.B
  3c70: 55 46 35 08 5f 50 52 53 11 2a 0a 27 30 47 01 78  UF5._PRS.*.'0G.x
  3c80: 03 78 03 01 08 22 b8 1e 30 47 01 78 02 78 02 01  .x..."..0G.x.x..
  3c90: 08 22 b8 1e 30 47 01 bc 03 bc 03 01 04 22 b8 1e  ."..0G......."..
  3ca0: 38 79 00 14 49 07 5f 53 52 53 01 8c 68 0a 02 49  8y..I._SRS..h..I
  3cb0: 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8b 68 0a 02 49  OLO.h..IOHI.h..I
  3cc0: 4f 41 44 8c 68 0a 04 49 4f 52 4c 8c 68 0a 05 49  OAD.h..IORL.h..I
  3cd0: 4f 52 48 8b 68 0a 09 49 52 51 57 45 4e 46 47 70  ORH.h..IRQWENFGp
  3ce0: 0a 03 4c 44 4e 5f 70 01 41 43 54 52 70 49 4f 4c  ..LDN_p.ACTRpIOL
  3cf0: 4f 49 4f 41 4c 70 49 4f 48 49 49 4f 41 48 81 49  OIOALpIOHIIOAH.I
  3d00: 52 51 57 60 74 60 0a 01 60 70 60 49 4e 54 52 45  RQW`t`..`p`INTRE
  3d10: 58 46 47 43 4b 49 4f 49 4f 41 44 0a 02 5b 82 4d  XFGCKIOIOAD..[.M
  3d20: 2a 45 43 50 31 08 5f 48 49 44 0c 41 d0 04 01 14  *ECP1._HID.A....
  3d30: 43 05 5f 53 54 41 00 45 4e 46 47 70 0a 03 4c 44  C._STA.ENFGp..LD
  3d40: 4e 5f 7b 4f 50 54 31 0a 02 60 a0 2f 93 60 0a 02  N_{OPT1..`./.`..
  3d50: a0 0c 41 43 54 52 45 58 46 47 a4 0a 0f a1 1c a0  ..ACTREXFG......
  3d60: 11 91 49 4f 41 48 49 4f 41 4c 45 58 46 47 a4 0a  ..IOAHIOALEXFG..
  3d70: 0d a1 08 45 58 46 47 a4 0a 00 a1 08 45 58 46 47  ...EXFG.....EXFG
  3d80: a4 0a 00 14 2b 5f 44 49 53 00 45 4e 46 47 70 0a  ....+_DIS.ENFGp.
  3d90: 03 4c 44 4e 5f 70 00 41 43 54 52 53 4c 44 4d 44  .LDN_p.ACTRSLDMD
  3da0: 4d 43 48 0a 04 45 58 46 47 44 49 53 44 0a 02 14  MCH..EXFGDISD...
  3db0: 4b 13 5f 43 52 53 00 08 42 55 46 36 11 1b 0a 18  K._CRS..BUF6....
  3dc0: 47 01 00 00 00 00 01 04 47 01 00 00 00 00 01 04  G.......G.......
  3dd0: 22 00 00 2a 00 00 79 00 8c 42 55 46 36 0a 02 49  "..*..y..BUF6..I
  3de0: 4f 4c 4f 8c 42 55 46 36 0a 03 49 4f 48 49 8c 42  OLO.BUF6..IOHI.B
  3df0: 55 46 36 0a 04 49 4f 52 4c 8c 42 55 46 36 0a 05  UF6..IORL.BUF6..
  3e00: 49 4f 52 48 8c 42 55 46 36 0a 07 49 4f 4c 45 8c  IORH.BUF6..IOLE.
  3e10: 42 55 46 36 0a 0a 49 4f 45 4c 8c 42 55 46 36 0a  BUF6..IOEL.BUF6.
  3e20: 0b 49 4f 45 48 8c 42 55 46 36 0a 0c 49 4f 4d 4c  .IOEH.BUF6..IOML
  3e30: 8c 42 55 46 36 0a 0d 49 4f 4d 48 8b 42 55 46 36  .BUF6..IOMH.BUF6
  3e40: 0a 11 49 52 51 57 8c 42 55 46 36 0a 14 44 4d 41  ..IRQW.BUF6..DMA
  3e50: 43 45 4e 46 47 70 0a 03 4c 44 4e 5f 70 49 4f 41  CENFGp..LDN_pIOA
  3e60: 4c 62 70 62 49 4f 4c 4f 70 49 4f 41 48 63 70 63  LbpbIOLOpIOAHcpc
  3e70: 49 4f 48 49 7d 63 0a 04 63 70 63 49 4f 45 48 70  IOHI}c..cpcIOEHp
  3e80: 63 49 4f 4d 48 70 49 4f 4c 4f 49 4f 52 4c 70 49  cIOMHpIOLOIORLpI
  3e90: 4f 4c 4f 49 4f 45 4c 70 49 4f 4c 4f 49 4f 4d 4c  OLOIOELpIOLOIOML
  3ea0: 70 49 4f 48 49 49 4f 52 48 a0 0f 93 49 4f 4c 4f  pIOHIIORH...IOLO
  3eb0: 0a bc 70 0a 04 49 4f 4c 45 a1 08 70 0a 08 49 4f  ..p..IOLE..p..IO
  3ec0: 4c 45 70 01 60 70 49 4e 54 52 65 79 60 65 49 52  LEp.`pINTRey`eIR
  3ed0: 51 57 70 01 60 70 44 4d 43 48 65 79 60 65 44 4d  QWp.`pDMCHey`eDM
  3ee0: 41 43 45 58 46 47 a4 42 55 46 36 08 5f 50 52 53  ACEXFG.BUF6._PRS
  3ef0: 11 4c 04 0a 48 30 47 01 78 03 78 03 00 08 47 01  .L..H0G.x.x...G.
  3f00: 78 07 78 07 00 04 22 b8 1e 2a 0b 00 30 47 01 78  x.x..."..*..0G.x
  3f10: 02 78 02 00 08 47 01 78 06 78 06 00 04 22 b8 1e  .x...G.x.x..."..
  3f20: 2a 0b 00 30 47 01 bc 03 bc 03 00 04 47 01 bc 07  *..0G.......G...
  3f30: bc 07 00 04 22 b8 1e 2a 0b 00 38 79 00 14 4e 08  ...."..*..8y..N.
  3f40: 5f 53 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a  _SRS..h..IOLO.h.
  3f50: 03 49 4f 48 49 8b 68 0a 02 49 4f 41 44 8b 68 0a  .IOHI.h..IOAD.h.
  3f60: 11 49 52 51 57 8c 68 0a 14 44 4d 41 43 45 4e 46  .IRQW.h..DMACENF
  3f70: 47 70 0a 03 4c 44 4e 5f 70 01 41 43 54 52 70 49  Gp..LDN_p.ACTRpI
  3f80: 4f 4c 4f 49 4f 41 4c 70 49 4f 48 49 49 4f 41 48  OLOIOALpIOHIIOAH
  3f90: 81 49 52 51 57 60 74 60 0a 01 60 70 60 49 4e 54  .IRQW`t`..`p`INT
  3fa0: 52 81 44 4d 41 43 61 70 44 4d 43 48 60 74 61 0a  R.DMACapDMCH`ta.
  3fb0: 01 44 4d 43 48 53 4c 44 4d 60 44 4d 43 48 45 58  .DMCHSLDM`DMCHEX
  3fc0: 46 47 43 4b 49 4f 49 4f 41 44 0a 02 5b 80 4b 42  FGCKIOIOAD..[.KB
  3fd0: 43 54 01 0a 60 0a 05 5b 81 12 4b 42 43 54 01 50  CT..`..[..KBCT.P
  3fe0: 30 36 30 08 00 18 50 30 36 34 08 5b 82 4f 08 50  060...P064.[.O.P
  3ff0: 53 32 4d 08 5f 48 49 44 0c 41 d0 0f 13 14 17 5f  S2M._HID.A....._
  4000: 53 54 41 00 a0 0b 93 50 53 32 46 0a 00 a4 0a 0f  STA....PS2F.....
  4010: a1 04 a4 0a 00 14 46 06 5f 43 52 53 00 08 42 55  ......F._CRS..BU
  4020: 46 31 11 08 0a 05 22 00 10 79 00 08 42 55 46 32  F1...."..y..BUF2
  4030: 11 18 0a 15 47 01 60 00 60 00 01 01 47 01 64 00  ....G.`.`...G.d.
  4040: 64 00 01 01 22 00 10 79 00 a0 2b 93 4b 42 44 49  d..."..y..+.KBDI
  4050: 0a 01 a0 0d 93 4f 53 46 4c 0a 02 a4 42 55 46 31  .....OSFL...BUF1
  4060: a0 0d 93 4f 53 46 4c 0a 01 a4 42 55 46 31 a1 06  ...OSFL...BUF1..
  4070: a4 42 55 46 32 a1 06 a4 42 55 46 31 5b 82 40 05  .BUF2...BUF1[.@.
  4080: 50 53 32 4b 08 5f 48 49 44 0c 41 d0 03 03 08 5f  PS2K._HID.A...._
  4090: 43 49 44 0c 41 d0 03 0b 14 17 5f 53 54 41 00 a0  CID.A....._STA..
  40a0: 0b 93 4b 42 44 49 0a 01 a4 0a 00 a1 04 a4 0a 0f  ..KBDI..........
  40b0: 08 5f 43 52 53 11 18 0a 15 47 01 60 00 60 00 01  ._CRS....G.`.`..
  40c0: 01 47 01 64 00 64 00 01 01 22 02 00 79 00 5b 82  .G.d.d..."..y.[.
  40d0: 47 19 4d 49 44 49 08 5f 48 49 44 0c 41 d0 b0 06  G.MIDI._HID.A...
  40e0: 14 3f 5f 53 54 41 00 45 4e 46 47 70 0a 0a 4c 44  .?_STA.ENFGp..LD
  40f0: 4e 5f a0 0c 41 43 54 52 45 58 46 47 a4 0a 0f a1  N_..ACTREXFG....
  4100: 1c a0 11 91 49 4f 41 48 49 4f 41 4c 45 58 46 47  ....IOAHIOALEXFG
  4110: a4 0a 0d a1 08 45 58 46 47 a4 0a 00 45 58 46 47  .....EXFG...EXFG
  4120: 14 21 5f 44 49 53 00 45 4e 46 47 70 0a 0a 4c 44  .!_DIS.ENFGp..LD
  4130: 4e 5f 70 00 41 43 54 52 45 58 46 47 44 49 53 44  N_p.ACTREXFGDISD
  4140: 0a 05 14 49 09 5f 43 52 53 00 08 42 55 46 31 11  ...I._CRS..BUF1.
  4150: 10 0a 0d 47 01 00 00 00 00 01 02 22 00 00 79 00  ...G......."..y.
  4160: 8c 42 55 46 31 0a 02 49 4f 4c 4f 8c 42 55 46 31  .BUF1..IOLO.BUF1
  4170: 0a 03 49 4f 48 49 8c 42 55 46 31 0a 04 49 4f 52  ..IOHI.BUF1..IOR
  4180: 4c 8c 42 55 46 31 0a 05 49 4f 52 48 8b 42 55 46  L.BUF1..IORH.BUF
  4190: 31 0a 09 49 52 51 57 45 4e 46 47 70 0a 0a 4c 44  1..IRQWENFGp..LD
  41a0: 4e 5f 70 49 4f 41 4c 49 4f 4c 4f 70 49 4f 41 4c  N_pIOALIOLOpIOAL
  41b0: 49 4f 52 4c 70 49 4f 41 48 49 4f 48 49 70 49 4f  IORLpIOAHIOHIpIO
  41c0: 41 48 49 4f 52 48 70 01 60 79 60 49 4e 54 52 49  AHIORHp.`y`INTRI
  41d0: 52 51 57 45 58 46 47 a4 42 55 46 31 08 5f 50 52  RQWEXFG.BUF1._PR
  41e0: 53 11 1e 0a 1b 30 47 01 30 03 30 03 01 02 22 b8  S....0G.0.0...".
  41f0: 1e 30 47 01 00 03 00 03 01 02 22 b8 1e 38 79 00  .0G......."..8y.
  4200: 14 46 06 5f 53 52 53 01 8c 68 0a 02 49 4f 4c 4f  .F._SRS..h..IOLO
  4210: 8c 68 0a 03 49 4f 48 49 8b 68 0a 02 49 4f 41 44  .h..IOHI.h..IOAD
  4220: 8b 68 0a 09 49 52 51 57 45 4e 46 47 70 0a 0a 4c  .h..IRQWENFGp..L
  4230: 44 4e 5f 70 01 41 43 54 52 70 49 4f 4c 4f 49 4f  DN_p.ACTRpIOLOIO
  4240: 41 4c 70 49 4f 48 49 49 4f 41 48 82 49 52 51 57  ALpIOHIIOAH.IRQW
  4250: 60 74 60 0a 01 49 4e 54 52 45 58 46 47 43 4b 49  `t`..INTREXFGCKI
  4260: 4f 49 4f 41 44 0a 05 5b 82 40 16 47 41 4d 45 08  OIOAD..[.@.GAME.
  4270: 5f 48 49 44 0c 41 d0 b0 2f 14 3f 5f 53 54 41 00  _HID.A../.?_STA.
  4280: 45 4e 46 47 70 0a 08 4c 44 4e 5f a0 0c 41 43 54  ENFGp..LDN_..ACT
  4290: 52 45 58 46 47 a4 0a 0f a1 1c a0 11 91 49 4f 41  REXFG........IOA
  42a0: 48 49 4f 41 4c 45 58 46 47 a4 0a 0d a1 08 45 58  HIOALEXFG.....EX
  42b0: 46 47 a4 0a 00 45 58 46 47 14 21 5f 44 49 53 00  FG...EXFG.!_DIS.
  42c0: 45 4e 46 47 70 0a 08 4c 44 4e 5f 70 00 41 43 54  ENFGp..LDN_p.ACT
  42d0: 52 45 58 46 47 44 49 53 44 0a 04 14 4e 07 5f 43  REXFGDISD...N._C
  42e0: 52 53 00 08 42 55 46 31 11 0d 0a 0a 47 01 00 00  RS..BUF1....G...
  42f0: 00 00 01 01 79 00 8c 42 55 46 31 0a 02 49 4f 4c  ....y..BUF1..IOL
  4300: 4f 8c 42 55 46 31 0a 03 49 4f 48 49 8c 42 55 46  O.BUF1..IOHI.BUF
  4310: 31 0a 04 49 4f 52 4c 8c 42 55 46 31 0a 05 49 4f  1..IORL.BUF1..IO
  4320: 52 48 45 4e 46 47 70 0a 08 4c 44 4e 5f 70 49 4f  RHENFGp..LDN_pIO
  4330: 41 4c 49 4f 4c 4f 70 49 4f 41 4c 49 4f 52 4c 70  ALIOLOpIOALIORLp
  4340: 49 4f 41 48 49 4f 48 49 70 49 4f 41 48 49 4f 52  IOAHIOHIpIOAHIOR
  4350: 48 45 58 46 47 a4 42 55 46 31 08 5f 50 52 53 11  HEXFG.BUF1._PRS.
  4360: 18 0a 15 30 47 01 01 02 01 02 01 01 30 47 01 09  ...0G.......0G..
  4370: 02 09 02 01 01 38 79 00 14 40 05 5f 53 52 53 01  .....8y..@._SRS.
  4380: 8c 68 0a 02 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49  .h..IOLO.h..IOHI
  4390: 8b 68 0a 02 49 4f 41 44 45 4e 46 47 70 0a 08 4c  .h..IOADENFGp..L
  43a0: 44 4e 5f 70 01 41 43 54 52 70 49 4f 4c 4f 49 4f  DN_p.ACTRpIOLOIO
  43b0: 41 4c 70 49 4f 48 49 49 4f 41 48 45 58 46 47 43  ALpIOHIIOAHEXFGC
  43c0: 4b 49 4f 49 4f 41 44 0a 04 14 1d 5c 2f 04 5f 53  KIOIOAD....\/._S
  43d0: 42 5f 50 43 49 30 55 41 52 31 5f 50 52 57 00 a4  B_PCI0UAR1_PRW..
  43e0: 12 06 02 0a 03 0a 05                             .......

FACS @ 0x3fff0000
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

APIC @ 0x3fff74c0
  0000: 41 50 49 43 6e 00 00 00 01 75 4e 76 69 64 69 61  APICn....uNvidia
  0010: 41 57 52 44 41 43 50 49 31 2e 30 42 41 57 52 44  AWRDACPI1.0BAWRD
  0020: 00 00 00 00 00 00 e0 fe 01 00 00 00 00 08 00 00  ................
  0030: 01 00 00 00 01 0c 02 00 00 00 c0 fe 00 00 00 00  ................
  0040: 02 0a 00 00 02 00 00 00 00 00 02 0a 00 09 09 00  ................
  0050: 00 00 0d 00 02 0a 00 0e 0e 00 00 00 05 00 02 0a  ................
  0060: 00 0f 0f 00 00 00 05 00 04 06 00 05 00 01        ..............


--=-=-=--
