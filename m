Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSG1VTS>; Sun, 28 Jul 2002 17:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSG1VTS>; Sun, 28 Jul 2002 17:19:18 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:6786 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S317366AbSG1VTO>;
	Sun, 28 Jul 2002 17:19:14 -0400
Date: Sun, 28 Jul 2002 23:22:31 +0200 (CEST)
From: bege <bege@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: ld error
Message-ID: <Pine.A41.4.31.0207282320470.22292-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG REPORT:
===========

1.
--
ld error while compiling kernel

2.
--
ld produced the following error while compiling kernel version 2.4.18 :

make -C drm modules
make[3]: Entering directory `/usr/src/linux/drivers/char/drm'
ld -m elf_i386 -r -o radeon.o radeon_drv.o radeon_cp.o radeon_state.o
ld: BFD 2.12.90.0.1 20020307 Debian/GNU Linux internal error, aborting at ../../bfd/elflink.h line 6208 in elf_link_output_extsym

ld: Please report this bug.

make[3]: *** [radeon.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/char/drm'
make[2]: *** [_modsubdir_drm] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

4.
--
Linux version 2.4.18 (root@boutique) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Jul 26 00:05:59 CEST 2002

7.1 (ver_linux)
---
Linux void 2.4.18 #1 Fri Jul 26 00:05:59 CEST 2002 i686 unknown

Gnu C                  3.0.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

7.2 (/proc/cpuinfo)
---
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1800+
stepping        : 2
cpu MHz         : 1532.941
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

7.3 (/proc/modules)
---
not exists

7.4 (/proc/ioports & /proc/iomem)
---
/proc/ioports:

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
9000-901f : VIA Technologies, Inc. UHCI USB (#4)
9400-941f : VIA Technologies, Inc. UHCI USB (#3)
9800-980f : VIA Technologies, Inc. Bus Master IDE
  9800-9807 : ide0
  9808-980f : ide1
a000-a0ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  a000-a0ff : tulip
a400-a407 : Creative Labs SB Live!
a800-a81f : Creative Labs SB Live! EMU10k1
b000-b01f : VIA Technologies, Inc. UHCI USB (#2)
b400-b41f : VIA Technologies, Inc. UHCI USB
b800-b8ff : C-Media Electronics Inc CM8738
d000-dfff : PCI Bus #01
  d800-d8ff : PCI device 1002:514c (ATI Technologies Inc)

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-00275bd1 : Kernel code
  00275bd2-002ddb77 : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
d6000000-d60003ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  d6000000-d60003ff : tulip
d6800000-d68000ff : PCI device 1106:3104 (VIA Technologies, Inc.)
d7000000-d7dfffff : PCI Bus #01
  d7000000-d700ffff : PCI device 1002:514c (ATI Technologies Inc)
d7f00000-dfffffff : PCI Bus #01
  d8000000-dfffffff : PCI device 1002:514c (ATI Technologies Inc)
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5 (pci info)
---
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51) (prog-if 20)
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at d6800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a800 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet Adapter (rev 11)
	Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 4
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 9800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 7
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 7
	Region 4: I/O ports at 9000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 514c (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 013a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 (scsi)
---
not exists


					bege

