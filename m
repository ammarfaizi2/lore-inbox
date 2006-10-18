Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422626AbWJRP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422626AbWJRP5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWJRP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:57:39 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:38573 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S1161183AbWJRP5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:57:37 -0400
Message-ID: <45364EEF.7010901@mnsu.edu>
Date: Wed, 18 Oct 2006 10:57:35 -0500
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per request of the kernel logs:

PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try 
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 11) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]


Let me know if you'd like more information.  I don't see anything 
misbehaving.
The system is a Del Latitude D820 with the most recent BIOS (A03).
The kernel is a Debian kernel... but the same thing occurs with 2.6.18.
The kernel reports:
Linux version 2.6.18-1-686 (Debian 2.6.18-2) (waldi@debian.org) (gcc 
version 4.1.2 20060920 (prerelease) (Debian 4.1.1-14)) #1 SMP Fri Sep 29 
16:25:40 UTC 2006

lspci:

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 
945GT Express Memory Controller Hub (rev 03)
    Subsystem: Dell Unknown device 01cc
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile 
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03) 
(prog-if 00 [VGA])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin A routed to IRQ 169
    Region 0: Memory at dff00000 (32-bit, non-prefetchable) [size=512K]
    Region 1: I/O ports at eff8 [size=8]
    Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
    Region 3: Memory at dfec0000 (32-bit, non-prefetchable) [size=256K]
    Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable-
        Address: 00000000  Data: 0000
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML 
Express Integrated Graphics Controller (rev 03)
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Region 0: Memory at dff80000 (32-bit, non-prefetchable) [size=512K]
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
    Subsystem: Dell Unknown device 01cc
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 58
    Region 0: Memory at dfebc000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express Unknown type IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <64ns, L1 <1us
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
        Link: Latency L0s <64ns, L1 <1us
        Link: ASPM Disabled CommClk- ExtSynch-
        Link: Speed unknown, Width x0
    Capabilities: [100] Virtual Channel
    Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 1 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s unlimited, L1 unlimited
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
        Link: Latency L0s <1us, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x0
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
        Slot: Number 2, PowerLimit 6.500000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
        Slot: AttnInd Unknown, PwrInd Unknown, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable+
        Address: fee00000  Data: 40d1
    Capabilities: [90] Subsystem: Gammagraphx, Inc. Unknown device 0000
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 2 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
    Memory behind bridge: dfd00000-dfdfffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s unlimited, L1 unlimited
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
        Link: Latency L0s <256ns, L1 <4us
        Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
        Slot: Number 3, PowerLimit 6.500000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
        Slot: AttnInd Unknown, PwrInd Unknown, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable+
        Address: fee00000  Data: 40d9
    Capabilities: [90] Subsystem: Dell Unknown device 01cc
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 3 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
    Memory behind bridge: dfc00000-dfcfffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s unlimited, L1 unlimited
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
        Link: Latency L0s <256ns, L1 <4us
        Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
        Slot: Number 4, PowerLimit 6.500000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
        Slot: AttnInd Unknown, PwrInd Unknown, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable+
        Address: fee00000  Data: 40e1
    Capabilities: [90] Subsystem: Dell Unknown device 01cc
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 4 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=0d, subordinate=0e, sec-latency=0
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: dfa00000-dfbfffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000d01fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s unlimited, L1 unlimited
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
        Link: Latency L0s <1us, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x0
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
        Slot: Number 5, PowerLimit 6.500000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
        Slot: AttnInd Unknown, PwrInd Unknown, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable+
        Address: fee00000  Data: 40e9
    Capabilities: [90] Subsystem: Dell Unknown device 01cc
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#1 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin A routed to IRQ 50
    Region 4: I/O ports at bf80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#2 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin B routed to IRQ 58
    Region 4: I/O ports at bf60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#3 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin C routed to IRQ 66
    Region 4: I/O ports at bf40 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#4 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin D routed to IRQ 74
    Region 4: I/O ports at bf20 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 01) (prog-if 20 [EHCI])
    Subsystem: Dell Unknown device 01cc
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin A routed to IRQ 50
    Region 0: Memory at ffa80000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1) 
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=03, subordinate=07, sec-latency=32
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: df900000-df9fffff
    Prefetchable memory behind bridge: 0000000088000000-0000000089ffffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR+
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    Capabilities: [50] Subsystem: Dell Unknown device 01cc

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface 
Bridge (rev 01)
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) 
Serial ATA Storage Controller IDE (rev 01) (prog-if 80 [Master])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin B routed to IRQ 177
    Region 0: I/O ports at <ignored>
    Region 1: I/O ports at <ignored>
    Region 2: I/O ports at <ignored>
    Region 3: I/O ports at <ignored>
    Region 4: I/O ports at bfa0 [size=16]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller 
(rev 01)
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin B routed to IRQ 177
    Region 4: I/O ports at 10c0 [size=32]

03:01.0 CardBus bridge: O2 Micro, Inc. Cardbus bridge (rev 21)
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 168
    Interrupt: pin A routed to IRQ 193
    Region 0: Memory at df900000 (32-bit, non-prefetchable) [size=4K]
    Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
    Memory window 0: 88000000-89fff000 (prefetchable)
    Memory window 1: 8a000000-8bfff000
    I/O window 0: 00002000-000020ff
    I/O window 1: 00002400-000024ff
    BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
    16-bit legacy interface ports at 0001

03:01.4 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev 
02) (prog-if 10 [OHCI])
    Subsystem: Dell Unknown device 01cc
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 193
    Region 0: Memory at df9ff000 (32-bit, non-prefetchable) [size=4K]
    Region 1: Memory at df9fe800 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME+

09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5752 
Gigabit Ethernet PCI Express (rev 02)
    Subsystem: Dell Unknown device 01cc
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 82
    Region 0: Memory at dfcf0000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [50] Vital Product Data
    Capabilities: [58] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/3 Enable+
        Address: 00000000fee00000  Data: 4052
    Capabilities: [d0] Express Endpoint IRQ 0
        Device: Supported: MaxPayload 512 bytes, PhantFunc 0, ExtTag+
        Device: Latency L0s <4us, L1 unlimited
        Device: AtnBtn- AtnInd- PwrInd-
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
        Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
        Link: Latency L0s <2us, L1 <64us
        Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [13c] Virtual Channel

0c:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
Network Connection (rev 02)
    Subsystem: Intel Corporation Unknown device 1020
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at dfdff000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [e0] Express Legacy Endpoint IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <512ns, L1 unlimited
        Device: AtnBtn- AtnInd- PwrInd-
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
        Link: Latency L0s <128ns, L1 <64us
        Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [140] Device Serial Number 02-c6-98-ff-ff-02-13-00



