Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFXO4b>; Mon, 24 Jun 2002 10:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSFXO4a>; Mon, 24 Jun 2002 10:56:30 -0400
Received: from student.uci.agh.edu.pl ([149.156.98.60]:31672 "EHLO
	student.uci.agh.edu.pl") by vger.kernel.org with ESMTP
	id <S313773AbSFXO4V>; Mon, 24 Jun 2002 10:56:21 -0400
Message-ID: <200206241656080720.00BB8ABC@student.uci.agh.edu.pl>
X-Mailer: Calypso Version 3.30.00.00 (3)
Date: Mon, 24 Jun 2002 16:56:08 +0200
From: =?ISO-8859-2?B?IqN1a2FzeiBH83JhbGN6eWsi?= 
	<liku@student.uci.agh.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Problem with CMD64X and ACPI (bug report)
Content-Type: text/plain; charset="ISO-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Formula used form REPORTING-BUGS from kernel source tree:

1. Problem with CMD64X and ACPI
2. If there's ACPI and CMD64X (IDE controller) compiled together
   and one (or more) disk is connected to CMD64X controller - kernel
   crashes while booting. It just shows "Spurious 8259 IRQ9" (or
   something like that) right after detecting that drive connected
   to CMD64X. System is halted, no keyboard input, anything, not
   even "kernel panic". Only cold boot helps.
3. kernel, cmd64x, acpi, bug, spurious, ide, disk, irq9, zoltrix,
device, linux, crash
4. Linux version 2.4.18 (root@tesis) (gcc version 2.95.3 20010315
(release)) #4 Wed Jun 12 02:12:05 CEST 2002
   4a (under gcc 3.1 it's the same)
5. [nothing]
6. [nothing]
7.
   7.1.
--- start ---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tesis 2.4.18 #4 Wed Jun 12 02:12:05 CEST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         3c59x ppp_deflate ppp_async ppp_generic slip
slhc lp parport_pc parport rtc ide-cd cdrom isofs vfat fat

--- end ---
   7.2.
--- start ---
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) processor
stepping	: 1
cpu MHz		: 801.442
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1599.07

--- end --
   7.3.
--- start ---
3c59x                  24992   1
ppp_deflate            39968   0 (unused)
ppp_async               6288   0 (unused)
ppp_generic            18080   0 [ppp_deflate ppp_async]
slip                    8592   0 (unused)
slhc                    4672   0 [ppp_generic slip]
lp                      6176   0 (unused)
parport_pc             14768   1
parport                24928   1 [lp parport_pc]
rtc                     5600   0 (autoclean)
ide-cd                 26656   0 (autoclean)
cdrom                  28960   0 (autoclean) [ide-cd]
isofs                  24880   0 (autoclean)
vfat                    9520   3 (autoclean)
fat                    29728   0 (autoclean) [vfat]
--- end ---
   7.4.
--- start ---
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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
a000-afff : PCI Bus #01
  a000-a0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
b000-b00f : VIA Technologies, Inc. Bus Master IDE
  b000-b007 : ide0
  b008-b00f : ide1
b400-b41f : VIA Technologies, Inc. UHCI USB
b800-b81f : VIA Technologies, Inc. UHCI USB (#2)
bc00-bcff : VIA Technologies, Inc. AC97 Audio Controller
c000-c003 : VIA Technologies, Inc. AC97 Audio Controller
c400-c403 : VIA Technologies, Inc. AC97 Audio Controller
cc00-cc1f : 3Com Corporation 3c590 10BaseT [Vortex]
  cc00-cc1f : 00:0b.0
d000-d03f : Olicom Token-Ring 16/4 PCI Adapter (3136/3137)
d400-d407 : CMD Technology Inc PCI0649
d800-d803 : CMD Technology Inc PCI0649
dc00-dc07 : CMD Technology Inc PCI0649
e000-e003 : CMD Technology Inc PCI0649
e400-e40f : CMD Technology Inc PCI0649
  e400-e407 : ide2
  e408-e40f : ide3
--- end ---
--- start ---
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-0020adaa : Kernel code
  0020adab-0025cdbf : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d6ffffff : PCI Bus #01
  d4000000-d4ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    d4000000-d47fffff : vesafb
  d6000000-d6000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ffff0000-ffffffff : reserved
--- end ---
   7.5.
--- start ---
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev
03)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: d4000000-d6ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super]
(rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo]
(rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
ACPI] (rev 40)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 50)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at bc00 [size=256]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at c400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at cc00 [size=32]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Token ring network controller: Olicom Token-Ring 16/4 PCI
Adapter (3136/3137) (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d000 [size=64]

00:0d.0 RAID bus controller: CMD Technology Inc: Unknown device 0649
(rev 02)
	Subsystem: CMD Technology Inc: Unknown device 0649
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d800 [size=4]
	Region 2: I/O ports at dc00 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at e400 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro
AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0084
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at a000 [size=256]
	Region 2: Memory at d6000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

--- end ---
   7.6. [I don't have scsi :) ]
   7.7. Hmm... don't have any idea
8. I think that it's hardware specyfic problem and it could be only
on my
   computer. I've posted this problem to pl.comp.os.linux but onone
had
   such problem. This CMD64X is Zoltrix IDE controller.
9. Few days ago I found another problem:
   I have 2 ATAPI devices, first Teac 540E, second Lite-Ion cdwriter
(48x/12x/48x)
   both of them reside on 2 diffrent channels on my Zoltrix IDE
controller; they
   both work in ide-scsi emulation => teac doesn't work, lite-ion
works. When I
   turn off ide-scsi emulation on teac and use it as an ordinary
cd-rom drive
   evrythings works fine. Problems: can't mount cdrom drive (I mean
teac) mount
   generates input/output error.
   Thanks, and have a good day (or night) :)

