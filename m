Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRDATNL>; Sun, 1 Apr 2001 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRDATNC>; Sun, 1 Apr 2001 15:13:02 -0400
Received: from [204.181.25.74] ([204.181.25.74]:43269 "HELO theblackfire.net")
	by vger.kernel.org with SMTP id <S132537AbRDATMt>;
	Sun, 1 Apr 2001 15:12:49 -0400
Date: Sun, 1 Apr 2001 12:07:22 -0700 (MST)
From: Greg von Beck <gregvb@theblackfire.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM:Bug when installing NVidia Driver Module
Message-ID: <Pine.LNX.4.30.0104011147300.10910-100000@www.theblackfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Bug when installing NVidia Driver Module on "athlon" architecture
[2.] the following error comes up when i attempt to install NVdriver
module from NVidia.

I build the Nvidia driver from the NVIDIA_kernel-0.9-769.tar.gz found at
www.nvidia.com

command insmod /lib/modules/2.4.3/video/NVDriver

reports this error
/lib/modules/2.4.3/video/NVDriver: unresolved symbol _mmx_memcpy

however if i rebuild my kernel using an "i686" architecture this problem
no longer comes up.

It is quite possible that this is NVidia's problem, however it seemed
reasonable that the "athlon" architecture should support MMX.

[3.] modules, video, nvidia
[4.] Linux version 2.4.3 (root@greg.theblackfire.net) (gcc version 2.96
20000731 (Red Hat Linux 7.0)) #4 Sun Apr 1 11:20:57 MST 2001
[5.] /lib/modules/2.4.3/video/NVDriver: unresolved symbol _mmx_memcpy
[6.] NA
[7.]
[7.1.]If some fields are empty or look unusual you may have an old
version.
Compare to the current minimal requirements in Documentation/Changes.

Linux greg.theblackfire.net 2.4.3 #4 Sun Apr 1 11:20:57 MST 2001 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.3.14
e2fsprogs              1.18
pcmcia-cs              3.1.19
PPP                    2.3.11
isdn4k-utils           3.1pre1
Linux C Library        2.1.92
Dynamic linker (ldd)   2.1.92
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         NVdriver nls_cp437 emu10k1

[7.2.]processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 900.068
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1795.68

[7.3.] NVdriver              630008   0 (unused)
nls_cp437               4408   1 (autoclean)
emu10k1                45400   0

[7.4.] 0000-001f : dma1
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
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  d800-d81f : usb-uhci
dc00-dc7f : Digital Equipment Corporation DECchip 21140 [FasterNet]
  dc00-dc7f : eth0
e000-e01f : Creative Labs SB Live! EMU10000
  e000-e01f : EMU10K1
e400-e407 : Creative Labs SB Live!


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-0022162b : Kernel code
  0022162c-002918b7 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11
d8000000-dbffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation NV11
df000000-df00007f : Digital Equipment Corporation DECchip 21140
[FasterNet]
  df000000-df00007f : eth0
ffff0000-ffffffff : reserved

[7.5.] 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 3
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 3
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 22)
        Subsystem: Kingston Technologies KNE100TX Fast Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00 [size=128]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev
06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! (rev 06)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at e400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)
(prog-if 00 [VGA])
        Subsystem: Guillemot Corporation: Unknown device 7100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] NA

[7.7.] cat /proc/nv/card0
----- Driver Info -----
NVRM Version: 1.0-769
------ Card Info ------
Model:        GeForce2 MX
IRQ:          10
------ AGP Info -------
AGP status:   Disabled
AGP Driver:
Bridge:       Via Apollo Pro KT133
SBA:          Supported [disabled]
FW:           Supported [disabled]
Rates:        4x 2x 1x  [-]
Registers:    0x1f000217:0x00000000

[X.] WORKAROUND: compling the kernel with an "i686" architecture allows
the module to be loaded.

