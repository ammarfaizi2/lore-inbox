Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSLZVem>; Thu, 26 Dec 2002 16:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLZVel>; Thu, 26 Dec 2002 16:34:41 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:42457 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S264614AbSLZVe1> convert rfc822-to-8bit; Thu, 26 Dec 2002 16:34:27 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre2aa1 - RAID0 issue.
Date: Fri, 27 Dec 2002 08:56:13 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212270856.13419.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
2.4.20-pre2aa1 hangs while trying to bringup software RAID0 volumes, 
2.4.21-pre2 and 2.4.20-aa1 are fine with the same volumes.

[2.] Full description of the problem/report:
Unfortunately it doesn't boot even on single user mode, and I don't have 
access to a non-RAID0 computer at the moment. So I can't provide more 
information I am afraid. I have taken information from 2.4.20aa1 for this bug 
report.

 [3.] Keywords (i.e., modules, networking, kernel):
md, raid0 modules
raidtools-1.00.2-3.3 (RH 8.0 provided RPM that is)

[4.] Kernel version (from /proc/version):
Linux version 2.4.20aa1 (hari@localhost.localdomain) (gcc version 3.2 20020903 
(Red Hat Linux 8.0 3.2-7)) #10 Sat Dec 7 11:49:47 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
I can send a copy of /etc/rc.d/rc.sysinit which tries to activate RAID 
volumes, if needed. It uses /proc/mdstat, /sbin/raidstart, /sbin/raid0run, 
/sbin/raidadd, /sbin/raidrun etc..

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux localhost.localdomain 2.4.20aa1 #10 Sat Dec 7 11:49:47 EST 2002 i686 
athlon i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         sr_mod emu10k1 ac97_codec soundcore radeon agpgart 
af_packet ipt_REJECT iptable_filter ip_tables ide-scsi scsi_mod ide-cd cdrom 
raid0 md rtc unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1200.061
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

[7.3.] Module information (from /proc/modules):
sr_mod                 15928   0 (autoclean)
emu10k1                63648   0 (autoclean)
ac97_codec             13576   0 (autoclean) [emu10k1]
soundcore               6532   4 (autoclean) [emu10k1]
radeon                 87384   3
agpgart                20316   3
af_packet              11464   0 (autoclean)
ipt_REJECT              3736   2 (autoclean)
iptable_filter          2412   1 (autoclean)
ip_tables              14648   2 [ipt_REJECT iptable_filter]
ide-scsi               10512   0
scsi_mod               98964   2 [sr_mod ide-scsi]
ide-cd                 33412   0
cdrom                  33344   0 [sr_mod ide-cd]
raid0                   3912   4 (autoclean)
md                     57376   8 [raid0]
rtc                     8500   0 (autoclean)
unix                   17832 153 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Radeon VE QY
a000-a003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
a400-a40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  a400-a407 : ide0
  a408-a40f : ide1
a800-a81f : VIA Technologies, Inc. USB
ac00-ac1f : VIA Technologies, Inc. USB (#2)
c000-c01f : Creative Labs SB Live! EMU10k1
  c000-c01f : EMU10K1
c400-c407 : Creative Labs SB Live! MIDI/Game Port

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-001e9d83 : Kernel code
  001e9d84-0021c81f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e1ffffff : PCI Bus #01
  e1000000-e100ffff : ATI Technologies Inc Radeon VE QY
e2000000-e2000fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at a000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
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

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at a400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at ac00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
06)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at c400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 
00 [VGA])
        Subsystem: Unknown device 1787:0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
All file systems are EXT3. /usr, /var, /tmp, /home on RAID0.

/etc/raidtab shows (for eg, for /dev/md0 which hosts /usr):
raiddev             /dev/md0
raid-level                  0
nr-raid-disks               2
chunk-size                  64k
persistent-superblock       1
nr-spare-disks              0
    device          /dev/hda3
    raid-disk     0
    device          /dev/hdc1
    raid-disk     1

(remaining entries for /dev/md1, /dev/md2 and /dev/md3 are very similar)

[X.] Other notes, patches, fixes, workarounds:
I can verify if 2.4.21-pre2aa1 is fine on a non-RAID computer later today.

Please cc me if you can. Thanks. Happy New Year everyone!
-- 
Hari
harisri@bigpond.com

