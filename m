Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTDNHZP (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 03:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTDNHZP (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 03:25:15 -0400
Received: from 82-41-208-76.cable.ubr12.edin.blueyonder.co.uk ([82.41.208.76]:9088
	"EHLO savagelandz.cjb.net") by vger.kernel.org with ESMTP
	id S262810AbTDNHZF (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 03:25:05 -0400
Message-ID: <43885.192.18.240.6.1050305888.squirrel@savagelandz.cjb.net>
Date: Mon, 14 Apr 2003 08:38:08 +0100 (BST)
Subject: Re: PCI: Device 02:04.0 not available because of resource collisions
From: <iain@savagelandz.cjb.net>
To: <rmk@arm.linux.org.uk>
In-Reply-To: <20030413133040.A855@flint.arm.linux.org.uk>
References: <36716.192.18.240.6.1050229446.squirrel@savagelandz.cjb.net>
        <20030413133040.A855@flint.arm.linux.org.uk>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The output of:
>
> lspci -vv
> cat /proc/iomem
> cat /proc/ioports
>
> from both a working and non-working kernel would be most helpful (along
> with the kernel versions used.)

Hi Russel,

Right I have the information you wanted...(I think ;)
I wasent sure what you meant by working/non-working kernels.
I only have a 2.4.20 and 2.5.67 installed and neither of them work with
the Cardbus Controller.
Anyway I will include the output for both (so appologies for the length of
this email)

This is for kernel version:

# uname -a
Linux cerberus.savagelandz.cjb.net 2.4.20-xfs-r2 #1 SMP Sun Apr 13
08:58:11 BST 2003 i686 Pentium III (Katmai) GenuineIntel GNU/Linux

# lspci -vv
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 64
    Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [a0] AGP version 1.0
        Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 00
[Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
    Subsystem: Unex Technology Corp. ND010
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (8000ns min, 16000ns max)
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at 2400 [size=256]
    Region 1: Memory at f4101000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
    Subsystem: Adaptec: Unknown device 0053
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (9750ns min, 6250ns max), cache line size 08
    Interrupt: pin A routed to IRQ 19
    BIST result: 00
    Region 0: I/O ports at 2800 [disabled] [size=256]
    Region 1: Memory at f4102000 (64-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 SCSI storage controller: Adaptec AIC-7896U2/7897U2
    Subsystem: Adaptec: Unknown device 0053
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (9750ns min, 6250ns max), cache line size 08
    Interrupt: pin A routed to IRQ 19
    BIST result: 00
    Region 0: I/O ports at 2c00 [disabled] [size=256]
    Region 1: Memory at f4103000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (4000ns min, 10000ns max)
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at f4105000 (32-bit, prefetchable) [size=4K]

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)
    Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (2000ns min, 14000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 21
    Region 0: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at 2000 [size=64]
    Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:12.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Region 0: [virtual] I/O ports at 01f0
    Region 1: [virtual] I/O ports at 03f4
    Region 2: [virtual] I/O ports at 0170
    Region 3: [virtual] I/O ports at 0374
    Region 4: I/O ports at 2040 [size=16]

00:12.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Interrupt: pin D routed to IRQ 21
    Region 4: I/O ports at 2060 [disabled] [size=32]

00:12.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin ? routed to IRQ 9

00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if
00 [VGA])
    Subsystem: Cirrus Logic CL-GD5480
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (500ns min, 2500ns max)
    Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
    Region 1: Memory at f4104000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=32K]

01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B+
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 240, cache line size 08
    Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Bridge: PM- B3+

02:04.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin A routed to IRQ 20
    Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
[size=4K]
    Bus: primary=02, secondary=03, subordinate=06, sec-latency=0
    I/O window 0: 00000000-00000003 [disabled]
    I/O window 1: 00000000-00000003 [disabled]
    BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
    16-bit legacy interface ports at 0001


# cat /proc/iomem
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000ce000-000cf7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-003b0130 : Kernel code
  003b0131-0045cae3 : Kernel data
0fff0000-0ffffbff : ACPI Tables
0ffffc00-0fffffff : ACPI Non-volatile Storage
f4000000-f40fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f4000000-f40fffff : e100
f4100000-f4100fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f4100000-f4100fff : e100
f4101000-f41010ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  f4101000-f41010ff : 8139too
f4102000-f4102fff : Adaptec AIC-7896U2/7897U2
  f4102000-f4102fff : aic7xxx
f4103000-f4103fff : Adaptec AIC-7896U2/7897U2 (#2)
  f4103000-f4103fff : aic7xxx
f4104000-f4104fff : Cirrus Logic GD 5480
f4105000-f4105fff : Brooktree Corporation Bt848 Video Capture
  f4105000-f4105fff : bttv
f6000000-f7ffffff : Cirrus Logic GD 5480
f8000000-fbffffff : Intel Corp. 440GX - 82443GX Host bridge
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : SoundBlaster
02f8-02ff : serial(auto)
0330-0331 : MPU401 UART
0376-0376 : ide1
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0620-0623 : Emu8000-1
0a20-0a23 : Emu8000-2
0a79-0a79 : isapnp write
0c00-0c3f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
0e20-0e23 : Emu8000-3
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
2000-203f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  2000-203f : e100
2040-204f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  2040-2047 : ide0
  2048-204f : ide1
2060-207f : Intel Corp. 82371AB/EB/MB PIIX4 USB
2400-24ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  2400-24ff : 8139too
2800-28ff : Adaptec AIC-7896U2/7897U2
2c00-2cff : Adaptec AIC-7896U2/7897U2 (#2)

I also noticed this in the dmesg output...

PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
PCI: Failed to allocate resource 0(0-fff) for 02:04.0


Ok Below is all the same stuff from the 2.5.67 kernel

# uname -a
Linux cerberus.savagelandz.cjb.net 2.5.67 #1 SMP Fri Apr 11 12:37:43 BST
2003 i686 Pentium III (Katmai) GenuineIntel GNU/Linux

# lspci -vv
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at f4101000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
	Subsystem: Adaptec: Unknown device 0053
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	BIST result: 00
	Region 0: I/O ports at 2800 [disabled] [size=256]
	Region 1: Memory at f4102000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 SCSI storage controller: Adaptec AIC-7896U2/7897U2
	Subsystem: Adaptec: Unknown device 0053
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	BIST result: 00
	Region 0: I/O ports at 2c00 [disabled] [size=256]
	Region 1: Memory at f4103000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f4105000 (32-bit, prefetchable) [size=4K]

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 2000 [size=64]
	Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:12.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 2040 [size=16]

00:12.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at 2060 [size=32]

00:12.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if
00 [VGA])
	Subsystem: Cirrus Logic CL-GD5480
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 2500ns max)
	Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f4104000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=32K]

01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 240, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

02:04.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
[size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

# cat /proc/iomem
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000ce000-000cf7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00441c26 : Kernel code
  00441c27-0054af5f : Kernel data
0fff0000-0ffffbff : ACPI Tables
0ffffc00-0fffffff : ACPI Non-volatile Storage
f4000000-f40fffff : Intel Corp. 82557/8/9 [Ethernet
  f4000000-f40fffff : e100
f4100000-f4100fff : Intel Corp. 82557/8/9 [Ethernet
  f4100000-f4100fff : e100
f4101000-f41010ff : Realtek Semiconducto RTL-8139/8139C/8139C
  f4101000-f41010ff : 8139too
f4102000-f4102fff : Adaptec AIC-7896U2/7897U2
  f4102000-f4102fff : aic7xxx
f4103000-f4103fff : Adaptec AIC-7896U2/7897U2 (#2)
  f4103000-f4103fff : aic7xxx
f4104000-f4104fff : Cirrus Logic GD 5480
f4105000-f4105fff : Brooktree Corporatio Bt848 Video Capture
  f4105000-f4105fff : bttv0
f6000000-f7ffffff : Cirrus Logic GD 5480
f8000000-fbffffff : Intel Corp. 440GX - 82443GX Host
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0a79-0a79 : isapnp write
0c00-0c3f : Intel Corp. 82371AB/EB/MB PIIX4
0cf8-0cff : PCI conf1
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4
  1040-1047 : piix4-smbus
2000-203f : Intel Corp. 82557/8/9 [Ethernet
  2000-203f : e100
2040-204f : Intel Corp. 82371AB/EB/MB PIIX4
  2040-2047 : ide0
  2048-204f : ide1
2060-207f : Intel Corp. 82371AB/EB/MB PIIX4
  2060-207f : uhci-hcd
2400-24ff : Realtek Semiconducto RTL-8139/8139C/8139C
  2400-24ff : 8139too
2800-28ff : Adaptec AIC-7896U2/7897U2
2c00-2cff : Adaptec AIC-7896U2/7897U2 (#2)

Hope all this helps.

Regards

iain



