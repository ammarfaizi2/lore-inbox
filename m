Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTJTSHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTJTSHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:07:15 -0400
Received: from mail2.intermedia.net ([206.40.48.152]:65298 "EHLO
	mail2.intermedia.net") by vger.kernel.org with ESMTP
	id S262726AbTJTSG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:06:57 -0400
From: "Mario \"jorge\" Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8-mm1 failure..
Date: Mon, 20 Oct 2003 20:08:23 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310202008.23294.jorge78@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all!
This is my first post on LKML!!! 
On my acer 272xv, 2.6.0-test6 works fine with mm series:
I've just tryed 2.6.0-test8-mm1 and I've got this failure at boot (last 100 
lines of /var/log/messages):

Oct 20 17:34:46 D998 kernel: intel8x0_measure_ac97_clock: measured 49337 usecs
Oct 20 17:34:46 D998 kernel: intel8x0: clocking to 48000
Oct 20 17:34:46 D998 kernel: NTFS driver 2.1.4 [Flags: R/O MODULE].
Oct 20 17:34:46 D998 kernel: NTFS volume version 3.1.
Oct 20 17:34:46 D998 kernel: eth0: link down
Oct 20 17:34:50 D998 kernel: Linux Kernel Card Services
Oct 20 17:34:50 D998 kernel:   options:  [pci] [cardbus] [pm]
Oct 20 17:34:50 D998 kernel: Intel PCIC probe: not found.
Oct 20 17:34:50 D998 kernel: PCI: Found IRQ 10 for device 0000:00:09.0
Oct 20 17:34:50 D998 kernel: PCI: Sharing IRQ 10 with 0000:01:00.0
Oct 20 17:34:50 D998 kernel: Yenta: CardBus bridge found at 0000:00:09.0 
[1025:001a]
Oct 20 17:34:50 D998 kernel: Yenta: ISA IRQ list 0098, PCI irq10
Oct 20 17:34:50 D998 kernel: Socket status: 30000006
Oct 20 17:34:50 D998 kernel: PCI: Found IRQ 10 for device 0000:00:09.1
Oct 20 17:34:50 D998 kernel: PCI: Sharing IRQ 10 with 0000:00:06.0
Oct 20 17:34:50 D998 kernel: Yenta: CardBus bridge found at 0000:00:09.1 
[1025:001a]
Oct 20 17:34:51 D998 kernel: Yenta: ISA IRQ list 0000, PCI irq10
Oct 20 17:34:51 D998 kernel: Socket status: 30000006
Oct 20 17:34:51 D998 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 20 17:34:51 D998 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 20 17:34:51 D998 kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x200-0x20f 0x3c0-0x3df 0x480-0x48f 0x4d0-0x4d7
Oct 20 17:34:51 D998 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 20 17:34:57 D998 kernel:  printing eip:
Oct 20 17:34:57 D998 kernel: 000067ae
Oct 20 17:34:57 D998 kernel: Oops: 0004 [#1]
Oct 20 17:34:57 D998 kernel: PREEMPT
Oct 20 17:34:57 D998 kernel: CPU:    0
Oct 20 17:34:57 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 20 17:34:57 D998 kernel: EFLAGS: 00033246
Oct 20 17:34:57 D998 kernel: EIP is at 0x67ae
Oct 20 17:34:57 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   
edx: 00000000
Oct 20 17:34:57 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   
esp: 1e825f24
Oct 20 17:34:57 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 20 17:34:57 D998 kernel: Process XFree86 (pid: 337, threadinfo=1e824000 
task=1e827940)
Oct 20 17:34:57 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 
00000000 00000000 00000000 00000000
Oct 20 17:34:57 D998 kernel:        00000005 ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff 
Oct 20 17:34:57 D998 kernel:        ffffffff ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:34:57 D998 kernel: Call Trace:
Oct 20 17:34:57 D998 kernel:
Oct 20 17:34:57 D998 kernel: Code:  Bad EIP value.
Oct 20 17:34:59 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address 00002000
Oct 20 17:34:59 D998 kernel:  printing eip:
Oct 20 17:34:59 D998 kernel: 000067ae
Oct 20 17:34:59 D998 kernel: Oops: 0004 [#2]
Oct 20 17:34:59 D998 kernel: PREEMPT
Oct 20 17:34:59 D998 kernel: CPU:    0
Oct 20 17:34:59 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 20 17:34:59 D998 kernel: EFLAGS: 00033246
Oct 20 17:34:59 D998 kernel: EIP is at 0x67ae
Oct 20 17:34:59 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   
edx: 00000000
Oct 20 17:34:59 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   
esp: 1e723f24
Oct 20 17:34:59 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 20 17:34:59 D998 kernel: Process XFree86 (pid: 364, threadinfo=1e722000 
task=1e827310)
Oct 20 17:34:59 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 
00000000 00000000 00000000 00000000
Oct 20 17:34:59 D998 kernel:        00000005 ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:34:59 D998 kernel:        ffffffff ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:34:59 D998 kernel: Call Trace:
Oct 20 17:34:59 D998 kernel:
Oct 20 17:34:59 D998 kernel: Code:  Bad EIP value.
Oct 20 17:35:01 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address 00002000
Oct 20 17:35:01 D998 kernel:  printing eip:
Oct 20 17:35:01 D998 kernel: 000067ae
Oct 20 17:35:01 D998 kernel: Oops: 0004 [#3]
Oct 20 17:35:01 D998 kernel: PREEMPT
Oct 20 17:35:01 D998 kernel: CPU:    0
Oct 20 17:35:01 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 20 17:35:01 D998 kernel: EFLAGS: 00033246
Oct 20 17:35:01 D998 kernel: EIP is at 0x67ae
Oct 20 17:35:01 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   
edx: 00000000
Oct 20 17:35:01 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   
esp: 1e825f24
Oct 20 17:35:01 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 20 17:35:01 D998 kernel: Process XFree86 (pid: 368, threadinfo=1e824000 
task=1e827940)
Oct 20 17:35:01 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 
00000000 00000000 00000000 00000000
Oct 20 17:35:01 D998 kernel:        00000005 ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:35:01 D998 kernel:        ffffffff ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:35:01 D998 kernel: Call Trace:
Oct 20 17:35:01 D998 kernel:
Oct 20 17:35:01 D998 kernel: Code:  Bad EIP value.
Oct 20 17:35:03 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address 00002000
Oct 20 17:35:03 D998 kernel:  printing eip:
Oct 20 17:35:03 D998 kernel: 000067ae
Oct 20 17:35:03 D998 kernel: Oops: 0004 [#4]
Oct 20 17:35:03 D998 kernel: PREEMPT
Oct 20 17:35:03 D998 kernel: CPU:    0
Oct 20 17:35:03 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 20 17:35:03 D998 kernel: EFLAGS: 00033246
Oct 20 17:35:03 D998 kernel: EIP is at 0x67ae
Oct 20 17:35:03 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   
edx: 00000000
Oct 20 17:35:03 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   
esp: 1e723f24
Oct 20 17:35:03 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 20 17:35:03 D998 kernel: Process XFree86 (pid: 372, threadinfo=1e722000 
task=1e827310)
Oct 20 17:35:03 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 
00000000 00000000 00000000 00000000 
Oct 20 17:35:03 D998 kernel:        00000005 ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:35:03 D998 kernel:        ffffffff ffffffff ffffffff ffffffff 
ffffffff ffffffff ffffffff ffffffff
Oct 20 17:35:03 D998 kernel: Call Trace:
Oct 20 17:35:03 D998 kernel:
Oct 20 17:35:03 D998 kernel: Code:  Bad EIP value.
Oct 20 17:37:51 D998 kernel:  spurious 8259A interrupt: IRQ7.
Oct 20 17:38:01 D998 kernel: NET: Registered protocol family 10
Oct 20 17:38:01 D998 kernel: IPv6 over IPv4 tunneling driver

************************** Lspci -vvv output for 2.4.22-ck2 ******************

D998:/home/io# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: ec100000-ec1fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at 9480 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev 
a0) (prog-if 00 [Generic])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 173 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Region 1: I/O ports at 9000 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound 
Controller (rev a0)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 173 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 8800 [size=256]
        Region 1: I/O ports at 9080 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec002000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at 9400 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8c00 [size=256]
        Region 1: Memory at ec002800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 1e400000-1e7ff000 (prefetchable)
        Memory window 1: 1e800000-1ebff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:09.1 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 1e001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
        Memory window 0: 1ec00000-1efff000 (prefetchable)
        Memory window 1: 1f000000-1f3ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ec100000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at a000 [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>


Obviously the graphical layout (xfree4.3-ds4) doesn't start.
Did I forget anything in the .config?

							Jorge
PS: sorry for all mistakes I made, I'm learning English!

