Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTE3VTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTE3VTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:19:13 -0400
Received: from ew-dsl-80-245-51-194.eweka.nl ([80.245.51.194]:65040 "EHLO
	hoendiep.ath.cx") by vger.kernel.org with ESMTP id S263976AbTE3VTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:19:04 -0400
Date: Fri, 30 May 2003 23:32:21 +0200 (CEST)
From: Fabio Bracci <fabio@hoendiep.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.70 compilation fails
Message-ID: <Pine.LNX.4.53.0305302318530.31546@hoendiep.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
	The compilation of the kernel 2.5.70 fails
[2.] Full description of the problem/report:
	While making the bzImage, the process exits with the following
messages:
...
  CC      arch/i386/lib/usercopy.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/dec_and_lock.o
  AR      arch/i386/lib/lib.a
  CPP     arch/i386/vmlinux.lds.s
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
sound/built-in.o(.text+0x9abb): In function `snd_rawmidi_dev_register':
: undefined reference to `snd_seq_device_new'
make: *** [vmlinux] Error 1
bolidino:~/linux-2.5.70# ls -l
total 312

[3.] Keywords (i.e., modules, networking, kernel):
	kernel - make bzImage
[4.] Kernel version (from /proc/version):

Linux version 2.4.20 (root@bolidino) (gcc version 3.2.3) #1 SMP Thu May 29
23:45:20 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

no oops seen

[6.] A small shell script or example program which triggers the
     problem (if possible)

make bzImage

[7.] Environment

Debian testing distribution - bash shell - gcc 3.2

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bolidino 2.4.20 #1 SMP Thu May 29 23:45:20 CEST 2003 i686 GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.21
e2fsprogs              1.34-WIP
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         nvidia rtc


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 551.266
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 1101.00

[7.3.] Module information (from /proc/modules):

nvidia               1540320  10 (autoclean)
rtc                     7612   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
c000-c01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
c400-c41f : Creative Labs SB Live! EMU10k1
  c400-c41f : EMU10K1
c800-c807 : Creative Labs SB Live! MIDI/Game Port
cc00-ccff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  cc00-ccff : 8139too
d000-d007 : Triones Technologies, Inc. HPT366/368/370/370A/372
  d000-d007 : ide2
d400-d403 : Triones Technologies, Inc. HPT366/368/370/370A/372
  d402-d402 : ide2
d800-d8ff : Triones Technologies, Inc. HPT366/368/370/370A/372
  d800-d807 : ide2
  d810-d8ff : HPT366
dc00-dc07 : Triones Technologies, Inc. HPT366/368/370/370A/372 (#2)
e000-e003 : Triones Technologies, Inc. HPT366/368/370/370A/372 (#2)
e400-e4ff : Triones Technologies, Inc. HPT366/368/370/370A/372 (#2)
  e400-e407 : ide3
  e410-e4ff : HPT366
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

=====
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0028ab4a : Kernel code
  0028ab4b-00311d23 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 [GeForce2 MX DDR]
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation NV11 [GeForce2 MX DDR]
e3000000-e30000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e3000000-e30000ff : 8139too
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

bolidino:~/linux-2.5.70/scripts#  lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
05)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 05)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at c800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372 (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at d400 [size=4]
        Region 4: I/O ports at d800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=256]

01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX
100 DDR/200 DDR] (rev b2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
Rate=x2

[7.6.] SCSI information (from /proc/scsi/scsi)

cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):



[X.] Other notes, patches, fixes, workarounds:

	the ue of gcc-3.3 in place of gcc-3.2 did not help.

Hopefully will this bug report be in some way useful. Good Luck!

