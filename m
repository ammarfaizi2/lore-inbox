Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292724AbSBQEFN>; Sat, 16 Feb 2002 23:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292729AbSBQEFE>; Sat, 16 Feb 2002 23:05:04 -0500
Received: from uswgco34.uswest.com ([199.168.32.123]:5349 "EHLO
	uswgco34.uswest.com") by vger.kernel.org with ESMTP
	id <S292724AbSBQEEu>; Sat, 16 Feb 2002 23:04:50 -0500
Message-Id: <200202170404.g1H44Hs18057@routed.markley.edu>
From: CoolMan <coolman@tuxboxproject.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: tdfx, signo=11
Date: Sat, 16 Feb 2002 23:15:12 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C5TN64OGRRGHPQMNYVPH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--------------Boundary-00=_C5TN64OGRRGHPQMNYVPH
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

I would like to say first, if I am sending this to the wrong address, please forgive me. I know nothing about reporting bugs, and my involvement with OpenSource is fairly fresh.

Following the instructions in REPORTING-BUGS...

[1.] tdfx? causes random signo=11 and hangs console
[2.] I am developing an application for X11 using SDL (http://www.libsdl.org/) and OpenGL (http://www.opengl.org). I will (sometimes) experiance a full console crash while my program de-inits. (I have never run my code more then 50 times before it crashes.) I have preformed a backtrace on the dead process, and have determined that tdfx is causing a signal 11. NOTE: I am currently running kernel 2.4.17, but it does not matter if I am running this kernel, or the one that came with my distro, RedHat 7.2.
[3.] tdfx, voodoo,  kernel, freeze, crash
[4.] [root@elbmin linux]# cat /proc/version
Linux version 2.4.17 (root@elbmin.markley.edu) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #2 SMP Wed Feb 13 01:17:27 EST 2002
[5.] oops? no, no oops.
[6.] There is a small TGZ file attached, it includes both the source to the failure and two seperate full backtraces.
[7.]
  [7.1.] [root@elbmin linux]# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux elbmin.markley.edu 2.4.17 #2 SMP Wed Feb 13 01:17:27 EST 2002 i586 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded
  [7.2.] [root@elbmin linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 522.812
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 1042.02
  [7.3.] NO MODULES LOADED
  [7.4.] [root@elbmin linux]# cat /proc/ioports
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
02f8-02ff : serial(auto)
0330-0331 : cmpci Midi
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  ac00-ac7f : Silicon Integrated Systems [SiS] 6306 3D-AGP
d000-d0ff : LSI Logic / Symbios Logic (formerly NCR) 53c825
  d000-d07f : ncr53c8xx
d800-d8ff : C-Media Electronics Inc CM8738
  d800-d8ff : cmpci
da00-da3f : C-Media Electronics Inc CM8738
dc00-dc7f : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  dc00-dc7f : tulip
de00-deff : 3Dfx Interactive, Inc. Voodoo 3
ffa0-ffaf : Silicon Integrated Systems [SiS] 5513 [IDE]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
[root@elbmin linux]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000cc000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-0028afab : Kernel code
  0028afac-002fe3df : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
deb00000-dfbfffff : PCI Bus #01
  df000000-df7fffff : Silicon Integrated Systems [SiS] 6306 3D-AGP
e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
e3d00000-e3dfffff : PCI Bus #01
  e3df0000-e3dfffff : Silicon Integrated Systems [SiS] 6306 3D-AGP
e8000000-ebffffff : Silicon Integrated Systems [SiS] 530 Host
edfee000-edfeefff : Silicon Integrated Systems [SiS] 7001
  edfee000-edfeefff : usb-ohci
edfefe00-edfefeff : LSI Logic / Symbios Logic (formerly NCR) 53c825
edfeff80-edfeffff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  edfeff80-edfeffff : tulip
ee000000-efffffff : 3Dfx Interactive, Inc. Voodoo 3
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffc0000-ffffffff : reserved
  [7.5.] [root@elbmin linux]# /sbin/lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 11) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at edfee000 (32-bit, non-prefetchable) [size=4K]

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e3d00000-e3dfffff
        Prefetchable memory behind bridge: deb00000-dfbfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:09.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at de00 [size=256]
        Expansion ROM at edff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c825 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at edfefe00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at edf40000 [disabled] [size=256K]

00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CM8738
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at da00 [size=64]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable+ DSel=0 DScale=0 PME+

00:0d.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 10)
        Subsystem: Unknown device 0291:8212
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=128]
        Region 1: Memory at edfeff80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at edf80000 [disabled] [size=256K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev a3) (prog-if 00 [VGA])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at df000000 (32-bit, prefetchable) [disabled] [size=8M]
        Region 1: Memory at e3df0000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Region 2: I/O ports at ac00 [disabled] [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 1.0
                Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

  [7.6.] [root@elbmin linux]# cat /proc/scsi/scsi
Attached devices: none

  [7.7.] Please! No more cutting and pasting! This by itself is way more than enough to get me shunned from the linux community forever and ever! (Especially if I am sending this to the wrong address.)

[8.] Sadly, SDL is catching signals. It won't let me force a core dump. So all stack analysis is done by having gdb attach itself to the dead process id.

Having originally thought (before the backtrace) that this was an SDL bug, I allready had the SDL masters scrutinize my code. I had some minor problems with my init code, but that's fixed now. My init code and my de-init code is flawless.

The backtraces are to be found at bug.tgz/logs/backtrace###.txt

Obviously, this only happens when you are using a Voodoo card, if it's the voodoo driver that's the culprit.

It seems to happen more frequently on my slower machine, and even more frequently if processer intensive things are happening. (Methinks it is timing related...)

CoolMan




--------------Boundary-00=_C5TN64OGRRGHPQMNYVPH
Content-Type: application/x-gzip;
  name="bug.tgz"
Content-Transfer-Encoding: base64
Content-Description: An evil bug.
Content-Disposition: attachment; filename="bug.tgz"

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
fTn9B/EDP4wAUAAA

--------------Boundary-00=_C5TN64OGRRGHPQMNYVPH--
