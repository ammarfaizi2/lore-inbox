Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280572AbRKJSDQ>; Sat, 10 Nov 2001 13:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKJSC5>; Sat, 10 Nov 2001 13:02:57 -0500
Received: from 200191178200-dial-user-UOL.acessonet.com.br ([200.191.178.200]:384
	"HELO techie") by vger.kernel.org with SMTP id <S280570AbRKJSCw>;
	Sat, 10 Nov 2001 13:02:52 -0500
Date: Sat, 10 Nov 2001 16:01:02 -0300 (ART)
From: Logoth Dragon <logoth@saboto.com.br>
X-X-Sender: <logoth@BlackTower.com>
To: <linux-kernel@vger.kernel.org>
Subject: Bug Report
Message-ID: <Pine.LNX.4.33.0111101556270.334-100000@BlackTower.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. System crashes when switching from console (frame buffer using VESA) to X session.
2. When I change to X from the console and back, after a few changes (around 3) it'll either crash the entire system (ala Windows), requiring a cold boot, or screw up the video but allow me to reboot. I have the Magic SysRq key on, and when there's a full crash even that won't work. I'm using the frame buffer with the VESA card at 1024x768x64k. This problem started after the 2.4.9 patched (including Alan's patches). The plain original 2.4.9 worked just fine.
3. kernel, video, frame buffer, X, VESA, crash, lock
4. Linux 2.4.13-ac8
5. No oops. Just plain crashing.
6. Just keep switching to and fro the console to X and it'll crash.
7.
7.1. Linux BlackTower 2.4.13-ac8 #2 SMP Wed Nov 7 13:54:22 ART 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11l
mount                  2.11l
modutils               2.4.6
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         sb sb_lib uart401 sound soundcore
7.2 processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 350.799
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 699.59
7.3 sb                      7408   0 (unused)
sb_lib                 33456   0 [sb]
uart401                 6192   0 [sb_lib]
sound                  53504   0 [sb_lib uart401]
soundcore               3472   5 [sb_lib sound]
7.4 0000-001f : dma1
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
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
b800-b83f : Ensoniq ES1370 [AudioPCI]
d000-d0ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d000-d0ff : sis900
d400-d41f : Intel Corporation 82371AB PIIX4 USB
d800-d80f : Intel Corporation 82371AB PIIX4 IDE
  d800-d807 : ide0
  d808-d80f : ide1
e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
  e400-e43f : PnPBIOS PNP0c02
e800-e81f : Intel Corporation 82371AB PIIX4 ACPI
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-09ffcfff : System RAM
  00100000-00223153 : Kernel code
  00223154-00277c5f : Kernel data
09ffd000-09ffefff : ACPI Tables
09fff000-09ffffff : ACPI Non-volatile Storage
d6800000-d6800fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d6800000-d6800fff : sis900
d7000000-d7dfffff : PCI Bus #01
  d7000000-d707ffff : S3 Inc. Savage 4
d7f00000-e3ffffff : PCI Bus #01
  d8000000-dfffffff : S3 Inc. Savage 4
    d8000000-d9ffffff : vesafb
e4000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
ffff0000-ffffffff : reserved
7.5
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 02)
	Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at d6800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
	Subsystem: Unknown device 4942:4c4c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at b800 [size=64]

01:00.0 VGA compatible controller: S3 Inc. Savage 4 (rev 02) (prog-if 00 [VGA])
	Subsystem: Creative Labs 3d Blaster Savage 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d7000000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
7.6
7.7


