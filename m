Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHXEbW>; Sat, 24 Aug 2002 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHXEbW>; Sat, 24 Aug 2002 00:31:22 -0400
Received: from adsl-216-62-231-61.dsl.snantx.swbell.net ([216.62.231.61]:18949
	"HELO phlare.wyrms.net") by vger.kernel.org with SMTP
	id <S315278AbSHXEbQ>; Sat, 24 Aug 2002 00:31:16 -0400
Message-ID: <3D670D0F.1040400@wyrms.net>
Date: Fri, 23 Aug 2002 23:35:27 -0500
From: Robin Cook <rcook@wyrms.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020820
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: events0 and joystick nodes not being created by devfs.
Content-Type: multipart/mixed;
 boundary="------------010507050308060001060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010507050308060001060702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

For kernel 2.4.19 and the events0 and joystick node are not being 
created by devfs.

I have turn on in InputCore
keyboard
mouse
  1600 H
  1200 V
Joystick
Events

In USB I have turned on
full HID support
  HID input
  /dev/hiddev
wacom tablet

The tablet is being seen by the usb driver at boot but the joystick is not.

All USB,tablet,joystick drivers etc are built into the kernel and not as 
modules.

/proc/version:

Linux version 2.4.20-pre2-ac6 (root@pheuri) (gcc version 3.2) #1 SMP Fri 
Aug 23 22:33:38 CDT 2002

Environment:

HZ=100
SHELL=/bin/bash
TERM=xterm-color
OLDPWD=/proc
USER=root
LS_COLORS=
GDK_USE_XFT=1
MAIL=/var/spool/mail/root
PATH=/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/games:/usr/local/games:/usr/bin/X11:/root/bin:.:/usr/bin/RealPlayer8:/usr/bin/Acrobat4/bin
INPUTRC=/etc/inputrc
PWD=/home/rcook/kernel-prob
LANG=en_US
PS1=\u@\h:\w\$
SHLVL=1
HOME=/root
LOGNAME=root
_=/usr/bin/env

ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pheuri 2.4.20-pre2-ac6 #1 SMP Fri Aug 23 22:33:38 CDT 2002 i686 
unknown

Gnu C                  gcc (GCC) 3.2 Copyright (C) 2002 Free Software 
Foundation, Inc. This is free software; see the source for copying 
conditions. There is NO warranty; not even for MERCHANTABILITY or 
FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.0
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         snd-emu10k1-synth snd-emux-synth 
snd-seq-midi-emul snd-seq-virmidi snd-seq-midi-event snd-seq snd-emu10k1 
snd-rawmidi snd-pcm snd-timer snd-hwdep snd-util-mem snd-seq-device 
snd-ac97-codec snd soundcore rtc nls_iso8859-1 nls_cp437

/proc/cpuinfo:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP 2000+
stepping	: 2
cpu MHz		: 1666.739
cache size	: 256 KB
physical id	: 0
siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3322.67

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1666.739
cache size	: 256 KB
physical id	: 0
siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3329.22

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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1010-1013 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
2000-2fff : PCI Bus #01
   2000-20ff : ATI Technologies Inc Radeon QL
3000-3fff : PCI Bus #02
   3000-30ff : Adaptec AHA-2930CU
   3400-347f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
     3400-347f : 02:08.0
   3480-349f : Creative Labs SB Live! EMU10k1
     3480-349f : EMU10K1
   34a0-34af : Artop Electronic Corp ATP865
     34a0-34a7 : ide2
     34a8-34af : ide3
   34b0-34b3 : Artop Electronic Corp ATP865
   34b4-34b7 : Artop Electronic Corp ATP865
     34b6-34b6 : ide2
   34b8-34bf : Artop Electronic Corp ATP865
   34c0-34c7 : Artop Electronic Corp ATP865
     34c0-34c7 : ide2
   34c8-34cf : Creative Labs SB Live! MIDI/Game Port
     34c8-34cf : emu10k1-gp
f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
   f000-f007 : ide0
   f008-f00f : ide1

/proc/iomem:

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cd000-000cd7ff : Extension ROM
000cd800-000cdfff : Extension ROM
000ce000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
   00100000-00303dcc : Kernel code
   00303dcd-003a92c3 : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1ff7ffff : System RAM
1ff80000-1fffffff : reserved
d0000000-d00fffff : PCI Bus #01
   d0000000-d000ffff : ATI Technologies Inc Radeon QL
d0100000-d01fffff : PCI Bus #02
   d0100000-d0103fff : Texas Instruments TSB12LV23 IEEE-1394 Controller
   d0104000-d0104fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
   d0105000-d0105fff : Adaptec AHA-2930CU
     d0105000-d0105fff : aic7xxx
   d0106000-d01067ff : Texas Instruments TSB12LV23 IEEE-1394 Controller
     d0106000-d01067ff : ohci1394
   d0106800-d010687f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
d0400000-d0400fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller
d8000000-dfffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller
e0000000-efffffff : PCI Bus #01
   e0000000-efffffff : ATI Technologies Inc Radeon QL
     e0000000-e7ffffff : vesafb
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

lspci -vvv:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at d0400000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1010 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: d0000000-d00fffff
	Prefetchable memory behind bridge: e0000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=234
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon QL 
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 8500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at d0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB 
(rev 07) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at d0104000 (32-bit, non-prefetchable) [size=4K]

02:04.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
	Subsystem: Adaptec: Unknown device 3869
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 3000 [disabled] [size=256]
	Region 1: Memory at d0105000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 SCSI storage controller: Artop Electronic Corp ATP865 (rev 02)
	Subsystem: Artop Electronic Corp ATP865
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 254 (2750ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 34c0 [size=8]
	Region 1: I/O ports at 34b4 [size=4]
	Region 2: I/O ports at 34b8 [size=8]
	Region 3: I/O ports at 34b0 [size=4]
	Region 4: I/O ports at 34a0 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394 
Controller (prog-if 10 [OHCI])
	Subsystem: Unknown device 167e:0750
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0106000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 3480 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 34c8 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
	Subsystem: Tyan Computer: Unknown device 2466
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 3400 [size=128]
	Region 1: Memory at d0106800 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

/proc/scsi/scsi:

Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: HP       Model: CD-Writer 6020   Rev: 1.07
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: UMAX     Model: Astra 1200S      Rev: V2.9
   Type:   Scanner                          ANSI SCSI revision: 02

/proc/devices:

Character devices:
   1 mem
   2 pty/m%d
   3 pty/s%d
   4 tts/%d
   5 cua/%d
   6 lp
   7 vcs
  10 misc
  13 input
  14 sound
  21 sg
  29 fb
  81 video_capture
  89 i2c
  99 ppdev
116 alsa
128 ptm
136 pts/%d
162 raw
171 ieee1394
180 usb
226 drm

Block devices:
   1 ramdisk
   2 fd
   3 ide0
   7 loop
  11 sr
  22 ide1
  33 ide2
  43 nbd

/proc/bus/usb is empty.

--------------010507050308060001060702
Content-Type: application/octet-stream;
 name="kernel-2.4.20-pre2-ac6.conf.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="kernel-2.4.20-pre2-ac6.conf.bz2"

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
/xdyRThQkMNUlJM=
--------------010507050308060001060702--

