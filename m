Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDACNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 21:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUDACNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 21:13:40 -0500
Received: from ppp01.ts1.Fredericksburg.visi.net ([209.96.245.1]:3712 "EHLO
	bassett.home.org") by vger.kernel.org with ESMTP id S261928AbUDACNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 21:13:30 -0500
From: "James B. Hiller" <jhiller@visi.net>
Message-Id: <200404010155.i311tuGL001097@bassett.home.org>
Subject: PROBLEM: 1/2 Video RAM not found by video card BIOS after shutdown -r
To: linux-kernel@vger.kernel.org
Date: Wed, 31 Mar 2004 20:55:56 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  PROBLEM:  1/2 Video RAM not found at video BIOS POST after shutdown -r.
2.  FULL DESCRIPTION:

When rebooting, and only rebooting, the video BIOS reports only 64MB when the
card actually has 128 MB.  Exact sequence that produces this is:

  a.  Power on.
  b.  Video card BIOS POST reports 128 MB (always).
  c.  Log in as root.
  d.  reboot -or- shutdown -r -or- telinit 6
  e.  Video card BIOS POST reports 68 MB (always).

I can't get this to happen using a hard reboot (front panel button) or using
a cold boot.  I also can't get this to happen using Win2K.  It does occur
always with kernel 2.6.4, 2.6.5-rc1, 2.6.5-rc2, and the -mm patches for each
of these.  Also, if I do run XFree86, it clearly reports finding the amount
that the video BIOS POST reported, so it's not an error in the video BIOS
POST report itself.  I've tried two video cards, both NVidia GE Force FX 5200
128 MB AGP cards, both eVGA.com cards, but different models, and both behave
exactly the same way.  Never had a similar problem using this motherboard
(Tyan S2460) with 64 MB AGP card.  No 128 MB PCI cards to check it with.

3.  KEYWORDS:  kernel, PCI bus, AGP, Video RAM.
4.  KERNEL VERSION:  Linux version 2.6.4 (root@bassett) (gcc version 3.2.3) #1
                     SMP Mon Mar 22 23:28:59 EST 2004
5.  OOPS:  None.
6.  EXAMPLE:  See #2.
7.  ENVIRONMENT:
7.1  Software:
Linux bassett 2.6.4 #1 SMP Mon Mar 22 23:28:59 EST 2004 i686 unknown
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.14
e2fsprogs              1.34
PPP                    2.4.2b3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         

7.2.  PROCESSOR INFORMATION:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1200.156
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2367.48

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1200.156
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2392.06

7.3.  MODULE INFORMATION:

{None}

7.4.  LOADED DRIVER AND HARDWARE INFO:

/proc/ioports:

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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-101f : 0000:00:0a.0
  1000-101f : EMU10K1
1030-103f : 0000:00:0d.0
1040-1043 : 0000:00:00.0
1048-104f : 0000:00:0a.1
  1048-104f : emu10k1-gp
1050-1057 : 0000:00:0d.0
1058-105f : 0000:00:0d.0
1060-1067 : 0000:00:0d.0
1068-106f : 0000:00:0d.0
1070-1077 : 0000:00:0d.0
  1070-1072 : parport1
  1073-1077 : parport1
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem:

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000dc000-000dcfff : 0000:00:07.4
  000dc000-000dcfff : ohci_hcd
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0038a718 : Kernel code
  0038a719-0047eeff : Kernel data
1fff0000-1ffffbff : ACPI Tables
1ffffc00-1fffffff : ACPI Non-volatile Storage
e1000000-e1ffffff : PCI Bus #01
  e1000000-e1ffffff : 0000:01:05.0
e2000000-e2000fff : 0000:00:00.0
e2001000-e2001fff : 0000:00:0c.0
e8000000-efffffff : 0000:00:00.0
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:05.0
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

7.5.  PCI info:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e2000000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1040 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e1000000-e1ffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB (rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
	Subsystem: Creative Labs CT4760 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 1000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 1048 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
	Subsystem: D-Link System Inc DWL-520 Wireless PCI Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e2001000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Communication controller: NetMos Technology: Unknown device 9805 (rev 01)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 0010
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 1070 [size=8]
	Region 1: I/O ports at 1068 [size=8]
	Region 2: I/O ports at 1060 [size=8]
	Region 3: I/O ports at 1058 [size=8]
	Region 4: I/O ports at 1050 [size=8]
	Region 5: I/O ports at 1030 [size=16]

01:05.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

7.6.  SCSI info:

{None}

7.7.  Other info:

Thx!

jbh
