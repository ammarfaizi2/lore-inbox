Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRBNVER>; Wed, 14 Feb 2001 16:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRBNVEH>; Wed, 14 Feb 2001 16:04:07 -0500
Received: from mail.templar.com ([208.36.85.194]:22532 "EHLO mail.templar.com")
	by vger.kernel.org with ESMTP id <S129399AbRBNVDu>;
	Wed, 14 Feb 2001 16:03:50 -0500
Date: Wed, 14 Feb 2001 16:03:38 -0500 (EST)
From: David Wood <dwood@templar.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: virtual console corruption (2.4.1/p4/radeon/XFree86 4.0.2)
Message-ID: <Pine.LNX.4.30.0102141451320.9405-100000@mail.templar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] virtual console corruption (2.4.1/p4/radeon/XFree86 4.0.2)

[2.]

Taking a redhat 7 install, upgrading it to currency, and then adding
rawhide RPMS for the required extra pieces, I compiled a 2.4.1 kernel
using kgcc.

Everything actually works rather well, with the exception that when I've
started XFree86 a few times, coupled with switching virtual consoles, I
get irretrievably "corrupted" text virtual consoles. The screen becomes
garbled, sometimes quite colorful, cursor goes to the wrong place, text
appears in odd locations or is not visible at all. Interestingly, the
scrollback buffer allows me to scroll through the garble perfectly.

The problem can only be fixed by rebooting.

X works great throughout, even when the text-mode console is messed up.
It's just the text-mode console that has the problem.

I have tried an alternate compile, omitting support for AGPART and Radeon
DRI - no effect.

The exact same setup, but replacing 2.4.1 with 2.2.17, works perfectly.

[3.] kernel, console, vga, xwindows

[4.]

Linux version 2.4.1 (root@fox.templar.com) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 Wed Feb 14 14:28:33 EST 2001

[5.] No OOPS

[6.] No script

[7.]
[7.1.] Software:

Linux fox.templar.com 2.4.1 #1 Wed Feb 14 14:28:33 EST 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         emu10k1 soundcore

[7.2.]

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 0
model name	: Intel(R) Pentium(R) 4 CPU 1600MHz
stepping	: 5
cpu MHz		: 1396.591
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm
bogomips	: 2785.28

[7.3.]

emu10k1                44944   0
soundcore               3920   4 [emu10k1]

[7.4.]

ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c800-c8ff : PCI device 1002:5144 (ATI Technologies Inc)
d000-dfff : PCI Bus #02
  d800-d8ff : Adaptec AIC-7861
  df00-df3f : Intel Corporation 82557 [Ethernet Pro 100]
    df00-df3f : eepro100
  df80-df9f : Creative Labs SB Live! EMU10000
    df80-df9f : EMU10K1
  dfe0-dfe7 : CONEXANT 56K Winmodem
  dff0-dff7 : Creative Labs SB Live!
ef40-ef5f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A)
  ef40-ef5f : usb-uhci
ef80-ef9f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B)
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corporation 82820 820 (Camino 2) Chipset SMBus
ffa0-ffaf : Intel Corporation 82820 820 (Camino 2) Chipset IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000c8800-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffbffff : System RAM
  00100000-00213ef7 : Kernel code
  00213ef8-002734cf : Kernel data
0ffc0000-0ffdffff : ACPI Tables
0ffe0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
e6900000-f69fffff : PCI Bus #01
  e8000000-efffffff : PCI device 1002:5144 (ATI Technologies Inc)
f6a00000-f6afffff : PCI Bus #02
f8000000-fbffffff : Intel Corporation 82850 850 (Tehama) Chipset Host Bridge (MCH)
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff500000-ff6fffff : PCI Bus #01
  ff680000-ff6fffff : PCI device 1002:5144 (ATI Technologies Inc)
ff700000-ff9fffff : PCI Bus #02
  ff9a0000-ff9bffff : Intel Corporation 82557 [Ethernet Pro 100]
  ff9d0000-ff9dffff : CONEXANT 56K Winmodem
  ff9fe000-ff9fefff : Intel Corporation 82557 [Ethernet Pro 100]
    ff9fe000-ff9fefff : eepro100
  ff9ff000-ff9fffff : Adaptec AIC-7861
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.]

00:00.0 Host bridge: Intel Corporation: Unknown device 2530 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation: Unknown device 2532 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff500000-ff6fffff
	Prefetchable memory behind bridge: e6900000-f69fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff700000-ff9fffff
	Prefetchable memory behind bridge: f6a00000-f6afffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4742
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4742
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 02)
	Subsystem: Intel Corporation: Unknown device 4742
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4742
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 6
	Region 4: I/O ports at ef80 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 000a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at ff680000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at ff660000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs CT4830 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at df80 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at dff0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 Communication controller: CONEXANT 56K Winmodem (rev 08)
	Subsystem: GVC Corporation: Unknown device 02a0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at ff9d0000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at dfe0 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
	Subsystem: Adaptec AHA-2940AU Single
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 6
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at ff9ff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at ff9e0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 09)
	Subsystem: Intel Corporation: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ff9fe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at df00 [size=64]
	Region 2: Memory at ff9a0000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at ff800000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] No SCSI

[7.7.]

It's a Radeon 64MB DDR.

