Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbTH0A4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 20:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbTH0A4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 20:56:00 -0400
Received: from newmx2.fast.net ([209.92.1.32]:14455 "HELO newmx2.fast.net")
	by vger.kernel.org with SMTP id S263003AbTH0Azt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 20:55:49 -0400
Subject: PROBLEM: keyboard shift not registered under fast typing or
	auto-repeat
From: Carl Nygard <cjnygard@fast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1061944729.14320.74.camel@finland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Aug 2003 20:38:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: Keyboard shift state not registered under fast typing or
autorepeat

If someone can help point me where to look at the code, I've already
looked into ./drivers/char/keyboard.c but didn't see anything obvious. 
More specific help would be appreciated.

Kernel doesn't register shift state when typing quickly.  Example, 'ls
*' shows up as 'ls 8' when typed fast.  Also, holding '-' key down, once
it's repeating, shift key makes no difference.  Interesting info:
keyboard delay settings of 500/30 allowed me to press shift key soon
(8-10 chars) into the repeat and have it change to '_', while delay
settings of 250/30 shortened that to the delay between the first and
second character.

Holding shift key down first, allows the repeating '_' character to
change to '-', but thereafter stays '-' regardless of shift state.

NB: This is not necessarily related to XFree86 at all.  I logged in on
console, behaviour is mostly identical with one caveat.  When starting
with '-', pressing the shift key before the repeating starts shows the
next 2 '-' but stops the repeat.  Pressing shift after it's started
repeating does nothing.  Otherwise, behaviour is identical


Kernel version: Linux version 2.6.0-test4 (gcc version 3.2.2 20030222
(RedHat Linux 3.2.2-5)
Also on kernel versions 2.4.20 (RedHat 9)) and 2.4.21 stock and 2.4.21
patched with acpi/laptop patches

No OOPS

No example scripts

Special note, this is a Compaq Presario X1000 Laptop.

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Intel(R) Pentium(R) M processor 1600MHz
stepping	: 5
cpu MHz		: 1594.909
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat
clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips	: 3153.92

autofs 15136 - - Live 0xe88e3000
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
  1000-10ff : 0000:03:00.0
1400-14ff : PCI CardBus #03
15e0-15e3 : pc110pad
2000-20ff : 0000:02:01.0
2400-247f : 0000:02:00.0
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
4000-40ff : 0000:00:1f.5
4400-44ff : 0000:00:1f.6
4800-487f : 0000:00:1f.6
4880-48bf : 0000:00:1f.5
48c0-48df : 0000:00:1d.0
  48c0-48df : uhci-hcd
48e0-48ff : 0000:00:1d.1
  48e0-48ff : uhci-hcd
4c00-4c1f : 0000:00:1d.2
  4c00-4c1f : uhci-hcd
4c20-4c3f : 0000:00:1f.3
4c40-4c4f : 0000:00:1f.1
  4c40-4c47 : ide0
  4c48-4c4f : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-27fcffff : System RAM
  00100000-0032f082 : Kernel code
  0032f083-004105ff : Kernel data
27fd0000-27ff0bff : reserved
27ff0c00-27ffbfff : ACPI Non-volatile Storage
27ffc000-27ffffff : reserved
28000000-280003ff : 0000:00:1f.1
28400000-287fffff : PCI CardBus #03
28800000-28bfffff : PCI CardBus #03
  28800000-288001ff : 0000:03:00.0
90000000-90000fff : 0000:02:02.0
90100000-90100fff : 0000:02:04.0
  90100000-90100fff : yenta_socket
90200000-902007ff : 0000:02:00.0
  90200000-902007ff : ohci1394
90300000-903000ff : 0000:02:01.0
90400000-904fffff : PCI Bus #01
  90400000-9040ffff : 0000:01:00.0
98000000-9fffffff : PCI Bus #01
  98000000-9fffffff : 0000:01:00.0
a0000000-a00003ff : 0000:00:1d.7
  a0000000-a00003ff : ehci_hcd
a0200000-a02001ff : 0000:00:1f.5
a0300000-a03000ff : 0000:00:1f.5
b0000000-bfffffff : 0000:00:00.0
00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at b0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 90400000-904fffff
	Prefetchable memory behind bridge: 98000000-9fffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
(prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 48c0 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
(prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 48e0 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
(prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 4c00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
(prog-if 20 [EHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at a0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 90000000-903fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01)
(prog-if 8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 4c40 [size=16]
	Region 5: Memory at 28000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 4c20 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio
(rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 4000 [size=256]
	Region 1: I/O ports at 4880 [size=64]
	Region 2: Memory at a0200000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at a0300000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01) (prog-if 00
[Generic])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 4400 [size=256]
	Region 1: I/O ports at 4800 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
[Radeon Mobility 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 98000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at 90400000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 90200000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at 2400 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 20)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2000 [size=256]
	Region 1: Memory at 90300000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:04.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 90100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 28400000-287ff000 (prefetchable)
	Memory window 1: 28800000-28bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown
device 8180 (rev 20)
	Subsystem: Netgear: Unknown device 4700
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000 [disabled] [size=256]
	Region 1: Memory at 28800000 (32-bit, non-prefetchable) [disabled]
[size=512]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-




-- 
Carl Nygard <cjnygard@fast.net>

