Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318916AbSHSOQa>; Mon, 19 Aug 2002 10:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSHSOQa>; Mon, 19 Aug 2002 10:16:30 -0400
Received: from 134dyn83.com21.casema.net ([62.234.47.83]:26766 "EHLO
	drebbelstraat20.dyndns.org") by vger.kernel.org with ESMTP
	id <S318916AbSHSOQQ>; Mon, 19 Aug 2002 10:16:16 -0400
Subject: More VIA chipset fun?
From: Mart van de Wege <mvdwege@drebbelstraat20.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-bWX+K6pqnwWvmCI3IjVP"
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 16:20:16 +0200
Message-Id: <1029766816.17665.36.camel@drebbelstraat20>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bWX+K6pqnwWvmCI3IjVP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Folks,

Here's what I hope is a minor question: On my system I am getting
persistent lockups when doing anything that requires high-volume
transfers to the graphics card.

It appears mostly in texture-heavy OpenGL applications (like Return to
Castle Wolfenstein), but it will also sporadically happen when playing
DVDs.

I've tried to diagnose it more specifically, but I'm currently stumped.
My kernel just locks up, not even being responsive to the magic SysRq-K
combination. It has gotten a little more stable after I switched the
cards around so the Soundblaster Live! is no longer sharing an IRQ with
the graphics card, and removing my old RTL8139 NIC seems to have helped
a little too, but the problem persists to this day.

A bug report in the DRI bug database has some people with comparable
configurations reporting the same problem. The common factor seems to be
a VIA 686b Southbridge. Because of this, I finally decided to ask your
advice, as this may be outside the scope of the DRI project.

<URL:
http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D522096&group_i=
d=3D387&atid=3D100387>
Some generic info (output of lspci, dmesg, lsmod and XFree86.log
follows):

System:

AMD Athlon XP1600 CPU
MSI K7T Pro2 Motherboard (VIA KT266a chipset)
Matrox MG450DH video card
512M DDR RAM

Kernel:

2.4.18 with O(1) scheduler and pre-empt patches.
I2C modules (for monitoring my motherboard sensors)
ALSA 0.9

Problems have also been observed on an unpatched 2.4.17 and 2.4.18.

Anybody not trying to do diagnostics can skip the rest of this message,
as this is the promised output of above commands.

If more information is needed, I am willing to provide it. Just ask what
is necessary. This is not urgent for me, but I'd like to see it fixed,
and if I can help fix it, I would be grateful for the experience it
would give me.

Thanks,

Mart van de Wege

lspci -vv output:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4
		Command: RQ=3D0 SBA+ AGP+ 64bit- FW- Rate=3Dx1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [=
Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	Memory behind bridge: dee00000-dfefffff
	Prefetchable memory behind bridge: dac00000-decfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capt=
ure (rev 11)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 31 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dedfe000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (r=
ev 11)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dedff000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07=
)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 16 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at e400 [size=3D32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at ec00 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=
 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e000 [size=3D128]
	Region 1: Memory at dfffef80 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at dffa0000 [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:08.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
	Subsystem: Adaptec 19160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	BIST result: 00
	Region 0: I/O ports at e800 [disabled] [size=3D256]
	Region 1: Memory at dffff000 (64-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at dffc0000 [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at fc00 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at dc00 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev =
85) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 16 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=3D32M]
	Region 1: Memory at dfefc000 (32-bit, non-prefetchable) [size=3D16K]
	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=3D8M]
	Expansion ROM at dfec0000 [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2,x4
		Command: RQ=3D31 SBA+ AGP+ 64bit- FW- Rate=3Dx1

dmesg output (with some ext3 diagnostics snipped, this was after a lockup):

00
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 001 01  1    1    0   1   0    1    1    71
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    79
 0d 001 01  0    0    0   0   0    1    1    81
 0e 001 01  0    0    0   0   0    1    1    89
 0f 001 01  0    0    0   0   0    1    1    91
 10 001 01  1    1    0   1   0    1    1    99
 11 001 01  1    1    0   1   0    1    1    A1
 12 001 01  1    1    0   1   0    1    1    A9
 13 001 01  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.7491 MHz.
..... host bus clock speed is 266.6187 MHz.
cpu: 0, clocks: 2666187, slice: 1333093
CPU0<T0:2666176,T1:1333072,D:11,S:1333093,C:2666187>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router default [1106/3074] at 00:11.0
PCI->APIC IRQ transform: (B0,I5,P0) -> 16
PCI->APIC IRQ transform: (B0,I5,P0) -> 16
PCI->APIC IRQ transform: (B0,I6,P0) -> 17
PCI->APIC IRQ transform: (B0,I7,P0) -> 18
PCI->APIC IRQ transform: (B0,I8,P0) -> 19
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hdc: LITEON DVD-ROM LTD122, ATAPI CD/DVD-ROM drive
hdd: R/RW 12x8x32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-cd: passing drive hdd to ide-scsi emulation.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

  Vendor: QUANTUM   Model: ATLAS_V__9_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V__9_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V__9_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
scsi0:A:4:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IDE-CD    Model: R/RW 12x8x32      Rev:  1.2
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
SCSI device sda: 17930694 512-byte hdwr sectors (9181 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
SCSI device sdb: 17930694 512-byte hdwr sectors (9181 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1 p2
SCSI device sdc: 17930694 512-byte hdwr sectors (9181 MB)
 /dev/scsi/host0/bus0/target4/lun0: p1
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sd(8,1): orphan cleanup on readonly fs
<snip>
EXT3-fs: sd(8,1): 77 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 208k freed
Adding Swap: 498004k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
gameport0: Emu10k1 Gameport at 0xec00 size 8 speed 1193 kHz
input0: Analog 3-axis 4-button joystick at gameport0.0 [TSC timer, 1397 MHz=
 clock, 863 ns res]
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:07.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.16
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
w83781d.o version 2.6.3 (20020322)
i2c-core.o: driver W83781D sensor driver registered.
i2c-isa.o version 2.6.3 (20020322)
i2c-core.o: client [W83627HF chip] registered to adapter [ISA main adapter]=
(pos. 0).
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
reiserfs: checking transaction log (device 08:03) ...
reiserfs: replayed 63 transactions in 2 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,33), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,18), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: compatibility mode
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
VFS: Disk change detected on device ide1(22,0)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack (4095 buckets, 32760 max)
Linux video capture interface: v1.00
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.83 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge is VIA Technologies, Inc. VT8367 [KT266]
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 00:05.0, irq: 16, latency: 31, memory: 0xdedfe000
bttv0: detected: Terratec TValue [card=3D33], PCI subsystem ID is 153b:1134
bttv0: using: BT878(Terratec TerraTValue) [card=3D33,autodetected]
i2c-core.o: adapter bt848 #0 registered as adapter 1.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874a,tda9850,tda9855,tea6300,tea=
6420,tda8425,pic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0xc0
bttv0: i2c attach [client=3DPhilips PAL,ok]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 0).
bttv0: PLL: 28636363 =3D> 35468950 ... ok
(scsi0:A:2:0): Locking max tag count at 64
(scsi0:A:0:0): Locking max tag count at 64
lp0: compatibility mode
lp0: compatibility mode
lp0: compatibility mode
lp0: compatibility mode
VFS: Disk change detected on device ide1(22,0)

lsmod output:

Module                  Size  Used by    Not tainted
tuner                   8160   1 (autoclean)
tvaudio                 9852   0 (autoclean) (unused)
bttv                   61120   0
i2c-algo-bit            7112   1 [bttv]
videodev                4960   2 [bttv]
ipt_MASQUERADE          1304   1 (autoclean)
iptable_nat            13816   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           14552   1 (autoclean) [ipt_MASQUERADE iptable_nat]
iptable_filter          1704   1 (autoclean)
ip_tables              10872   5 [ipt_MASQUERADE iptable_nat iptable_filter=
]
mousedev                3928   1
hid                    19300   0 (unused)
usbcore                50912   1 [hid]
nfsd                   66928   8 (autoclean)
lockd                  48528   1 (autoclean) [nfsd]
sunrpc                 63484   1 (autoclean) [nfsd lockd]
parport_pc             21992   1 (autoclean)
lp                      6240   0 (autoclean)
parport                25632   1 (autoclean) [parport_pc lp]
snd-seq-midi            3232   0 (autoclean) (unused)
snd-emu10k1-synth       3932   0 (autoclean) (unused)
snd-emux-synth         24544   0 (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       4480   0 (autoclean) [snd-emux-synth]
snd-seq-virmidi         2696   0 (autoclean) [snd-emux-synth]
snd-seq-oss            23616   0 (unused)
snd-seq-midi-event      3288   0 [snd-seq-midi snd-seq-virmidi snd-seq-oss]
snd-seq                39120   2 [snd-seq-midi snd-emux-synth snd-seq-midi-=
emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            36036   1
snd-mixer-oss           9404   0
snd-emu10k1            57964   1 [snd-emu10k1-synth]
snd-pcm                51712   0 [snd-pcm-oss snd-emu10k1]
snd-timer              10984   0 [snd-seq snd-pcm]
snd-rawmidi            13536   0 [snd-seq-midi snd-seq-virmidi snd-emu10k1]
snd-seq-device          3888   0 [snd-seq-midi snd-emu10k1-synth snd-emux-s=
ynth snd-seq-oss snd-seq snd-emu10k1 snd-rawmidi]
snd-ac97-codec         23492   0 [snd-emu10k1]
snd-util-mem            1216   0 [snd-emux-synth snd-emu10k1]
snd-hwdep               3680   0 [snd-emu10k1]
snd                    27020   0 [snd-seq-midi snd-emux-synth snd-seq-virmi=
di snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-emu=
10k1 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd-util-m=
em snd-hwdep]
soundcore               3812  10 [snd]
reiserfs              156016   1 (autoclean)
i2c-isa                 1196   0 (unused)
w83781d                18748   0 (unused)
i2c-proc                6320   0 [w83781d]
i2c-core               12932   0 [tuner tvaudio bttv i2c-algo-bit i2c-isa w=
83781d i2c-proc]
3c59x                  25232   1
mga                   104504   1
agpgart                13544   3
analog                  7488   0 (unused)
emu10k1-gp              1224   0 (unused)
gameport                1548   0 [analog emu10k1-gp]
joydev                  6880   0 (unused)

XFree86 startup log:

This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.1.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 21 December 2001
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Build Operating System: Linux 2.4.18 i686 [ELF]=20
Module Loader present
(=3D=3D) Log file: "/var/log/XFree86.0.log", Time: Sun Aug 18 16:20:26 2002
(=3D=3D) Using config file: "/etc/X11/XF86Config-4"
Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(=3D=3D) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Medion 1772ie"
(**) |   |-->Device "Matrox G450DH"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "us_intl"
(**) XKB: layout: "us_intl"
(**) Option "XkbOptions" "grp:switch"
(**) XKB: options: "grp:switch"
(=3D=3D) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(**) |-->Input Device "Generic Mouse"
(WW) `fonts.dir' not found (or not valid) in "/usr/lib/X11/fonts/cyrillic".
	Entry deleted from font path.
	(Run 'mkfontdir' on "/usr/lib/X11/fonts/cyrillic").
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts=
/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/Typ=
e1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/7=
5dpi,/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID,/var/lib/defoma/x-ttcidfon=
t-conf.d/dirs/TrueType"
(=3D=3D) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(=3D=3D) ModulePath set to "/usr/X11R6/lib/modules"
(++) using VT number 7

(II) Open APM successful
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.1
	XFree86 Video Driver: 0.4
	XFree86 XInput driver : 0.2
	XFree86 Server Extension : 0.1
	XFree86 Font Renderer : 0.2
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages =3D 0x03, oldVal1 =3D 0x8001000c, mode1Res1 =3D 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1106,3099 card 1106,0000 rev 00 class 06,00,00 hdr =
00
(II) PCI: 00:01:0: chip 1106,b099 card 0000,0000 rev 00 class 06,04,00 hdr =
01
(II) PCI: 00:05:0: chip 109e,036e card 153b,1134 rev 11 class 04,00,00 hdr =
80
(II) PCI: 00:05:1: chip 109e,0878 card 153b,1134 rev 11 class 04,80,00 hdr =
80
(II) PCI: 00:06:0: chip 1102,0002 card 1102,8061 rev 07 class 04,01,00 hdr =
80
(II) PCI: 00:06:1: chip 1102,7002 card 1102,0020 rev 07 class 09,80,00 hdr =
80
(II) PCI: 00:07:0: chip 10b7,9200 card 10b7,1000 rev 78 class 02,00,00 hdr =
00
(II) PCI: 00:08:0: chip 9005,0081 card 9005,62a1 rev 02 class 01,00,00 hdr =
00
(II) PCI: 00:11:0: chip 1106,3074 card 1106,0000 rev 00 class 06,01,00 hdr =
80
(II) PCI: 00:11:1: chip 1106,0571 card 1106,0571 rev 06 class 01,01,8a hdr =
00
(II) PCI: 00:11:2: chip 1106,3038 card 0925,1234 rev 1b class 0c,03,00 hdr =
00
(II) PCI: 00:11:3: chip 1106,3038 card 0925,1234 rev 1b class 0c,03,00 hdr =
00
(II) PCI: 00:11:4: chip 1106,3038 card 0925,1234 rev 1b class 0c,03,00 hdr =
00
(II) PCI: 01:00:0: chip 102b,0525 card 102b,0641 rev 85 class 03,00,00 hdr =
00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) PCI-to-ISA bridge:
(II) PCI-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1 0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1 0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1 0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x0c (VGA_EN is set)
(II) Bus 1 I/O range:
(II) Bus 1 non-prefetchable memory range:
	[0] -1 0	0xdee00000 - 0xdfefffff (0x1100000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1 0	0xdac00000 - 0xdecfffff (0x4100000) MX[B]
(II) Bus -1: bridge is at (0:17:0), (0,-1,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus -1 I/O range:
(II) Bus -1 non-prefetchable memory range:
(II) Bus -1 prefetchable memory range:
(--) PCI: (0:5:0) BrookTree unknown chipset (0x036e) rev 17, Mem @ 0xdedfe0=
00/12
(--) PCI:*(1:0:0) Matrox MGA G400 AGP rev 133, Mem @ 0xdc000000/25, 0xdfefc=
000/14, 0xdf000000/23, BIOS @ 0xdfec0000/17
(II) Addressable bus resource ranges are
	[0] -1 0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1 0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
	[0] -1 0	0xdfffef80 - 0xdfffefff (0x80) MX[B]
	[1] -1 0	0xdedff000 - 0xdedfffff (0x1000) MX[B]
	[2] -1 0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[3] -1 0	0xdfec0000 - 0xdfedffff (0x20000) MX[B](B)
	[4] -1 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B](B)
	[5] -1 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B](B)
	[6] -1 0	0xdc000000 - 0xddffffff (0x2000000) MX[B](B)
	[7] -1 0	0xdedfe000 - 0xdedfefff (0x1000) MX[B](B)
	[8] -1 0	0x0000dc00 - 0x0000dc1f (0x20) IX[B]
	[9] -1 0	0x0000d800 - 0x0000d81f (0x20) IX[B]
	[10] -1 0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[11] -1 0	0x0000fc00 - 0x0000fc0f (0x10) IX[B]
	[12] -1 0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[13] -1 0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[14] -1 0	0x0000ec00 - 0x0000ec07 (0x8) IX[B]
	[15] -1 0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1 0	0xdfffef80 - 0xdfffefff (0x80) MX[B]
	[1] -1 0	0xdedff000 - 0xdedfffff (0x1000) MX[B]
	[2] -1 0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[3] -1 0	0xdfec0000 - 0xdfedffff (0x20000) MX[B](B)
	[4] -1 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B](B)
	[5] -1 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B](B)
	[6] -1 0	0xdc000000 - 0xddffffff (0x2000000) MX[B](B)
	[7] -1 0	0xdedfe000 - 0xdedfefff (0x1000) MX[B](B)
	[8] -1 0	0x0000dc00 - 0x0000dc1f (0x20) IX[B]
	[9] -1 0	0x0000d800 - 0x0000d81f (0x20) IX[B]
	[10] -1 0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[11] -1 0	0x0000fc00 - 0x0000fc0f (0x10) IX[B]
	[12] -1 0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[13] -1 0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[14] -1 0	0x0000ec00 - 0x0000ec07 (0x8) IX[B]
	[15] -1 0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0xdfffef80 - 0xdfffefff (0x80) MX[B]
	[6] -1 0	0xdedff000 - 0xdedfffff (0x1000) MX[B]
	[7] -1 0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[8] -1 0	0xdfec0000 - 0xdfedffff (0x20000) MX[B](B)
	[9] -1 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B](B)
	[10] -1 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B](B)
	[11] -1 0	0xdc000000 - 0xddffffff (0x2000000) MX[B](B)
	[12] -1 0	0xdedfe000 - 0xdedfefff (0x1000) MX[B](B)
	[13] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1 0	0x0000dc00 - 0x0000dc1f (0x20) IX[B]
	[16] -1 0	0x0000d800 - 0x0000d81f (0x20) IX[B]
	[17] -1 0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[18] -1 0	0x0000fc00 - 0x0000fc0f (0x10) IX[B]
	[19] -1 0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[20] -1 0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[21] -1 0	0x0000ec00 - 0x0000ec07 (0x8) IX[B]
	[22] -1 0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.1.9
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "pex5"
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension X3D-PEX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "xie"
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XIE
(II) LoadModule: "mga"
(II) Loading /usr/X11R6/lib/modules/drivers/mga_drv.o
(II) Module mga: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.2
(II) MGA: driver for Matrox chipsets: mga2064w, mga1064sg, mga2164w,
	mga2164w AGP, mgag100, mgag100 PCI, mgag200, mgag200 PCI, mgag400
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset mgag400 found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0xdfffef80 - 0xdfffefff (0x80) MX[B]
	[6] -1 0	0xdedff000 - 0xdedfffff (0x1000) MX[B]
	[7] -1 0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[8] -1 0	0xdfec0000 - 0xdfedffff (0x20000) MX[B](B)
	[9] -1 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B](B)
	[10] -1 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B](B)
	[11] -1 0	0xdc000000 - 0xddffffff (0x2000000) MX[B](B)
	[12] -1 0	0xdedfe000 - 0xdedfefff (0x1000) MX[B](B)
	[13] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1 0	0x0000dc00 - 0x0000dc1f (0x20) IX[B]
	[16] -1 0	0x0000d800 - 0x0000d81f (0x20) IX[B]
	[17] -1 0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[18] -1 0	0x0000fc00 - 0x0000fc0f (0x10) IX[B]
	[19] -1 0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[20] -1 0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[21] -1 0	0x0000ec00 - 0x0000ec07 (0x8) IX[B]
	[22] -1 0	0x0000e400 - 0x0000e41f (0x20) IX[B]
(II) resource ranges after probing:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0xdfffef80 - 0xdfffefff (0x80) MX[B]
	[6] -1 0	0xdedff000 - 0xdedfffff (0x1000) MX[B]
	[7] -1 0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[8] -1 0	0xdfec0000 - 0xdfedffff (0x20000) MX[B](B)
	[9] -1 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B](B)
	[10] -1 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B](B)
	[11] -1 0	0xdc000000 - 0xddffffff (0x2000000) MX[B](B)
	[12] -1 0	0xdedfe000 - 0xdedfefff (0x1000) MX[B](B)
	[13] 0 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[14] 0 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[15] 0 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[16] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[17] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[18] -1 0	0x0000dc00 - 0x0000dc1f (0x20) IX[B]
	[19] -1 0	0x0000d800 - 0x0000d81f (0x20) IX[B]
	[20] -1 0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[21] -1 0	0x0000fc00 - 0x0000fc0f (0x10) IX[B]
	[22] -1 0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[23] -1 0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[24] -1 0	0x0000ec00 - 0x0000ec07 (0x8) IX[B]
	[25] -1 0	0x0000e400 - 0x0000e41f (0x20) IX[B]
	[26] 0 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[27] 0 0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(**) MGA(0): Depth 24, (--) framebuffer bpp 32
(=3D=3D) MGA(0): RGB weight 888
(II) Loading sub module "mga_hal"
(II) LoadModule: "mga_hal"
(WW) Warning, couldn't open module mga_hal
(II) UnloadModule: "mga_hal"
(EE) MGA: Failed to load module "mga_hal" (module does not exist, 0)
(II) MGA(0): Matrox HAL module not found - using builtin mode setup instead
(--) MGA(0): Chipset: "mgag400"
(=3D=3D) MGA(0): Using AGP 1x mode
(--) MGA(0): Linear framebuffer at 0xDC000000
(--) MGA(0): MMIO registers at 0xDFEFC000
(--) MGA(0): Pseudo-DMA transfer window at 0xDF000000
(--) MGA(0): BIOS at 0xDFEC0000
(--) MGA(0): Video BIOS info block at offset 0x07CA0
(WW) MGA(0): Video BIOS info block not detected!
(II) MGA(0): MGABios.RamdacType =3D 0x0
(=3D=3D) MGA(0): Write-combining range (0xdc000000,0x2000000)
(--) MGA(0): VideoRAM: 32768 kByte
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.2.0
	ABI class: XFree86 Video Driver, version 0.4
(=3D=3D) MGA(0): Write-combining range (0xdc000000,0x2000000)
(II) MGA(0): I2C bus "DDC" initialized.
(II) MGA(0): I2C device "DDC:ddc2" registered.
(II) MGA(0): I2C device "DDC:ddc2" removed.
(II) MGA(0): I2C device "DDC:ddc2" registered.
(II) MGA(0): I2C device "DDC:ddc2" removed.
(II) MGA(0): I2C Monitor info: 0x862af60
(II) MGA(0): Manufacturer: MED  Model: 1772  Serial#: 4184
(II) MGA(0): Year: 1999  Week: 23
(II) MGA(0): EDID Version: 1.1
(II) MGA(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) MGA(0): Sync:  Separate  Composite
(II) MGA(0): Max H-Image Size [cm]: horiz.: 31  vert.: 23
(II) MGA(0): Gamma: 2.67
(II) MGA(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) MGA(0): redX: 0.619 redY: 0.345   greenX: 0.290 greenY: 0.609
(II) MGA(0): blueX: 0.154 blueY: 0.064   whiteX: 0.280 whiteY: 0.311
(II) MGA(0): Supported VESA Video Modes:
(II) MGA(0): 720x400@70Hz
(II) MGA(0): 640x480@60Hz
(II) MGA(0): 640x480@75Hz
(II) MGA(0): 800x600@72Hz
(II) MGA(0): 800x600@75Hz
(II) MGA(0): 1024x768@60Hz
(II) MGA(0): 1024x768@70Hz
(II) MGA(0): 1024x768@75Hz
(II) MGA(0): Manufacturer's mask: 0
(II) MGA(0): Supported Future Video Modes:
(II) MGA(0): #0: hsize: 800  vsize 600  refresh: 85  vid: 22853
(II) MGA(0): #1: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) MGA(0): #2: hsize: 640  vsize 480  refresh: 85  vid: 22833
(II) MGA(0): #3: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) MGA(0):  Monitor
(II) MGA(0):  Monitor
(II) MGA(0):  Monitor
(II) MGA(0):  Monitor
(II) MGA(0): end of I2C Monitor info

(=3D=3D) MGA(0): Using gamma correction (1.0, 1.0, 1.0)
(=3D=3D) MGA(0): Min pixel clock is 12 MHz
(=3D=3D) MGA(0): Max pixel clock is 360 MHz
(II) MGA(0): Medion 1772ie: Using hsync range of 31.50-72.00 kHz
(II) MGA(0): Medion 1772ie: Using vrefresh range of 50.00-120.00 Hz
(II) MGA(0): Clock range:  12.00 to 360.00 MHz
(II) MGA(0): Not using default mode "1280x960" (hsync out of range)
(II) MGA(0): Not using default mode "1280x1024" (hsync out of range)
(II) MGA(0): Not using default mode "1280x1024" (hsync out of range)
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "1600x1200" (hsync out of range)
(II) MGA(0): Not using default mode "1792x1344" (hsync out of range)
(II) MGA(0): Not using default mode "1792x1344" (hsync out of range)
(II) MGA(0): Not using default mode "1856x1392" (hsync out of range)
(II) MGA(0): Not using default mode "1856x1392" (hsync out of range)
(II) MGA(0): Not using default mode "1920x1440" (hsync out of range)
(II) MGA(0): Not using default mode "1920x1440" (hsync out of range)
(II) MGA(0): Not using default mode "1400x1050" (hsync out of range)
(--) MGA(0): Has SDRAM
(--) MGA(0): Virtual size is 1280x1024 (pitch 1280)
(**) MGA(0): Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(II) MGA(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1=
028 1066 +hsync +vsync
(**) MGA(0): Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(II) MGA(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 =
900 +hsync +vsync
(**) MGA(0): Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(II) MGA(0): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 772 =
808 +hsync +vsync
(**) MGA(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(II) MGA(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 =
+hsync +vsync
(**) MGA(0): Mode "768x576": 50.0 MHz, 50.0 kHz, 79.4 Hz
(II) MGA(0): Modeline "768x576"   50.00  768 832 856 1000  576 590 595 630 =
-hsync -vsync
(--) MGA(0): Display dimensions: (31, 23) cm
(--) MGA(0): DPI set to (104, 113)
(II) MGA(0): YDstOrg is set to 0
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor=3D"The XFree86 Project"
	compiled for 4.1.0.1, module version =3D 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B]
	[1] 0 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B]
	[2] 0 0	0xdc000000 - 0xddffffff (0x2000000) MX[B]
	[3] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[4] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[5] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[6] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[7] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[8] -1 0	0xdfffef80 - 0xdfffefff (0x80) MX[B]
	[9] -1 0	0xdedff000 - 0xdedfffff (0x1000) MX[B]
	[10] -1 0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[11] -1 0	0xdfec0000 - 0xdfedffff (0x20000) MX[B](B)
	[12] -1 0	0xdf000000 - 0xdf7fffff (0x800000) MX[B](B)
	[13] -1 0	0xdfefc000 - 0xdfefffff (0x4000) MX[B](B)
	[14] -1 0	0xdc000000 - 0xddffffff (0x2000000) MX[B](B)
	[15] -1 0	0xdedfe000 - 0xdedfefff (0x1000) MX[B](B)
	[16] 0 0	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
	[17] 0 0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
	[18] 0 0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
	[19] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[20] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[21] -1 0	0x0000dc00 - 0x0000dc1f (0x20) IX[B]
	[22] -1 0	0x0000d800 - 0x0000d81f (0x20) IX[B]
	[23] -1 0	0x0000d400 - 0x0000d41f (0x20) IX[B]
	[24] -1 0	0x0000fc00 - 0x0000fc0f (0x10) IX[B]
	[25] -1 0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[26] -1 0	0x0000e000 - 0x0000e07f (0x80) IX[B]
	[27] -1 0	0x0000ec00 - 0x0000ec07 (0x8) IX[B]
	[28] -1 0	0x0000e400 - 0x0000e41f (0x20) IX[B]
	[29] 0 0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[30] 0 0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(=3D=3D) MGA(0): Write-combining range (0xdc000000,0x2000000)
(--) MGA(0): 16 DWORD fifo
(=3D=3D) MGA(0): Default visual is TrueColor
(II) MGA(0): [drm] bpp: 32 depth: 24
(II) MGA(0): [drm] Sarea 2200+664: 2864
(II) MGA(0): [drm] created "mga" driver at busid "PCI:1:0:0"
(II) MGA(0): [drm] added 4096 byte SAREA at 0xe0a94000
(II) MGA(0): [drm] mapped SAREA 0xe0a94000 to 0x40018000
(II) MGA(0): [drm] framebuffer handle =3D 0xdc000000
(II) MGA(0): [drm] added 1 reserved context for kernel
(II) MGA(0): [agp] Mode 0x1f000211 [AGP 0x1106/0x3099; Card 0x102b/0x0525]
(II) MGA(0): [agp] 12288 kB allocated with handle 0xe2a97000
(II) MGA(0): [agp] WARP microcode handle =3D 0xe0000000
(II) MGA(0): [agp] WARP microcode mapped at 0x40019000
(II) MGA(0): [agp] Primary DMA handle =3D 0xe0008000
(II) MGA(0): [agp] Primary DMA mapped at 0x429a9000
(II) MGA(0): [agp] DMA buffers handle =3D 0xe0108000
(II) MGA(0): [agp] DMA buffers mapped at 0x42aa9000
(II) MGA(0): [drm] Added 128 65536 byte DMA buffers
(II) MGA(0): [drm] Registers handle =3D 0xdfefc000
(II) MGA(0): [drm] Status handle =3D 0xe2aa0000
(II) MGA(0): [agp] Status page mapped at 0x40021000
(II) MGA(0): [dri] visual configs initialized
(II) MGA(0): Memory manager initialized to (0,0) (1280,2047)
(II) MGA(0): Largest offscreen area available: 1280 x 1023
(II) MGA(0): Reserved back buffer at offset 0xa00000
(II) MGA(0): Reserved depth buffer at offset 0xf00000
(II) MGA(0): Reserved 12288 kb for textures at offset 0x1400000
(II) MGA(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	Solid filled trapezoids
	8x8 mono pattern filled rectangles
	8x8 mono pattern filled trapezoids
	Indirect CPU to Screen color expansion
	Screen to Screen color expansion
	Solid Lines
	Dashed Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		9 256x256 slots
(=3D=3D) MGA(0): Backing store disabled
(=3D=3D) MGA(0): Silken mouse enabled
(**) Option "dpms"
(**) MGA(0): DPMS enabled
(II) MGA(0): Using overlay video
(II) MGA(0): X context handle =3D 0x00000001
(II) MGA(0): [drm] installed DRM signal handler
(II) MGA(0): [DRI] installation complete
(II) MGA(0): [drm] Mapped 128 DMA buffers
(=3D=3D) MGA(0): Direct rendering enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Keyboard "Generic Keyboard" handled by legacy driver
(**) Option "Protocol" "ImPS/2"
(**) Configured Mouse: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/misc/psaux"
(=3D=3D) Configured Mouse: Buttons: 3
(**) Option "ZAxisMapping" "4 5"
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Option "Resolution" "800"
(**) Configured Mouse: Resolution: 800
(**) Option "Protocol" "ImPS/2"
(**) Generic Mouse: Protocol: "ImPS/2"
(**) Option "SendCoreEvents" "true"
(**) Generic Mouse: always reports core events
(**) Option "Device" "/dev/input/mice"
(=3D=3D) Generic Mouse: Buttons: 3
(**) Option "ZAxisMapping" "4 5"
(**) Generic Mouse: ZAxisMapping: buttons 4 and 5
(II) XINPUT: Adding extended input device "Generic Mouse" (type: MOUSE)
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
Could not init font path element unix/:7100, removing from list!
(II) Open APM successful
SetKbdSettings - type: 2 rate: 30 delay: 500 snumlk: 0
SetKbdSettings - Succeeded
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Unreported Prefix0 scancode: 0x24
(II) Unreported Prefix0 scancode: 0x24
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Unreported Prefix0 scancode: 0x22
(II) Unreported Prefix0 scancode: 0x22
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) MGA(0): [drm] removed 1 reserved context for kernel
(II) MGA(0): [drm] unmapping 4096 bytes of SAREA 0xe0a94000 at 0x40018000
(II) Open APM successful
(=3D=3D) MGA(0): Write-combining range (0xdc000000,0x2000000)
(=3D=3D) MGA(0): Default visual is TrueColor
(II) MGA(0): [drm] bpp: 32 depth: 24
(II) MGA(0): [drm] Sarea 2200+664: 2864
(II) MGA(0): [drm] created "mga" driver at busid "PCI:1:0:0"
(II) MGA(0): [drm] added 4096 byte SAREA at 0xe0a94000
(II) MGA(0): [drm] mapped SAREA 0xe0a94000 to 0x40018000
(II) MGA(0): [drm] framebuffer handle =3D 0xdc000000
(II) MGA(0): [drm] added 1 reserved context for kernel
(II) MGA(0): [agp] Mode 0x1f000211 [AGP 0x1106/0x3099; Card 0x102b/0x0525]
(II) MGA(0): [agp] 12288 kB allocated with handle 0xe2a97000
(II) MGA(0): [agp] WARP microcode handle =3D 0xe0000000
(II) MGA(0): [agp] WARP microcode mapped at 0x40019000
(II) MGA(0): [agp] Primary DMA handle =3D 0xe0008000
(II) MGA(0): [agp] Primary DMA mapped at 0x429a9000
(II) MGA(0): [agp] DMA buffers handle =3D 0xe0108000
(II) MGA(0): [agp] DMA buffers mapped at 0x42aa9000
(II) MGA(0): [drm] Added 128 65536 byte DMA buffers
(II) MGA(0): [drm] Registers handle =3D 0xdfefc000
(II) MGA(0): [drm] Status handle =3D 0xe2aa0000
(II) MGA(0): [agp] Status page mapped at 0x40021000
(II) MGA(0): [dri] visual configs initialized
(II) MGA(0): Memory manager initialized to (0,0) (1280,2047)
(II) MGA(0): Largest offscreen area available: 1280 x 1023
(II) MGA(0): Reserved back buffer at offset 0xa00000
(II) MGA(0): Reserved depth buffer at offset 0xf00000
(II) MGA(0): Reserved 12288 kb for textures at offset 0x1400000
(**) MGA(0): DPMS enabled
(II) MGA(0): Using overlay video
(II) MGA(0): X context handle =3D 0x00000001
(II) MGA(0): [drm] installed DRM signal handler
(II) MGA(0): [DRI] installation complete
(II) MGA(0): [drm] Mapped 128 DMA buffers
(=3D=3D) MGA(0): Direct rendering enabled
Could not init font path element unix/:7100, removing from list!
AUDIT: Mon Aug 19 03:23:01 2002: 947 X: client 4 rejected from local host
SetKbdSettings - type: 2 rate: 30 delay: 500 snumlk: 0
SetKbdSettings - Succeeded
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
(II) Unreported Prefix0 scancode: 0x12
(II) Unreported Prefix0 scancode: 0x12
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
(II) Open APM successful
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1280 hbeg: 1328 hend: 1440 httl: 1688
              vdsp: 1024 vbeg: 1025 vend: 1028 vttl: 1066 flags: 5
(II) Open APM successful

--=-bWX+K6pqnwWvmCI3IjVP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9YP6gFZ+y5hhCJLURAne1AKChncXDuqfExfTPT35/EXWAmgjygQCfRjQb
YdMFLcULrxLJLFhAfR6BmeE=
=0aCK
-----END PGP SIGNATURE-----

--=-bWX+K6pqnwWvmCI3IjVP--
