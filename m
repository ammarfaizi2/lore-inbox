Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTIRHA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbTIRHA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:00:29 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:3272 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262986AbTIRHAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:00:01 -0400
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: wrong default setting for "PS/2 mouse (aka "auxiliary device") support" in .config with menuconfig
From: Benjamin.Eggerstedt@t-online.de
Date: Thu, 18 Sep 2003 08:59:24 +0200 (CEST)
Message-ID: <1063867954.3f695632dc567@webmail.t-online.de>
X-Mailer: T-Online WebMail 3.10
X-Complaints-To: abuse#webmail@t-online.com
X-Seen: false
X-ID: GvrCg0ZTZej6RKN8flxAyQJTOsGGt0XzUooN3XPqB+1v1qqkcpGMwK@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

hope that helps you... ;)
don't be shy, mail back if you have questions ...

first i have tried to mail to Alessandro Rubini
(rubini@ipvvis.unipv.it) (MAINTAINER for MOUSE AND  MISC DEVICES
[GENERAL]) but the mail returns with "unroutable address"... :(

So, there is no other way for me to get in contact with you....

[1.] One line summary of the problem:
wrong default setting for "PS/2 mouse (aka "auxiliary device") support"
in .config with menuconfig

[2.] Full description of the problem/report:
after "make-kpkg --config=menuconfig --revision=worktux2.4.22
kernel_image" the option "PS/2 mouse (aka "auxiliary device") support"
under "Character devices // Mice" is marked as [*]. per default there
is no .config provided. the problem is that "CONFIG_PSMOUSE" is a "yes,
no"-option and per default the menuconfig set to "m", what means
module. The Option cannot be "m", so /dev/psaux won't work after
compile:

$ cat /dev/psaux
no such device

if you reset the option "PS/2 mouse...." the .config will be saved in
the right format (CONFIG_PSMOUSE=y)

[3.] Keywords (i.e., modules, networking, kernel):
character devices, mice, /dev/psaux

[4.] Kernel version (from /proc/version):
worktux:/usr/src/linux-2.4.22# cat /proc/version 
Linux version 2.4.22 (root@worktux) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Wed Sep 17 13:27:41 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
 resolved (see Documentation/oops-tracing.txt)
no oops message

[6.] A small shell script or example program which triggers the problem
(if possible)
$ cat /dev/psaux
-> No such device

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
worktux:/usr/src/linux-2.4.22# sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux worktux 2.4.22 #1 Wed Sep 17 13:27:41 CEST 2003 i686 unknown
 
Gnu C                  2.95.4
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
Modules Loaded         cpuid ncpfs i810_audio ac97_codec soundcore
3c59x

[7.2.] Processor information (from /proc/cpuinfo):
worktux:/usr/src/linux-2.4.22# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 7
cpu MHz         : 1994.165
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3971.48

[7.3.] Module information (from /proc/modules):
worktux:/usr/src/linux-2.4.22# cat /proc/modules 
cpuid                   1152   0 (unused)
ncpfs                  32096   0 (unused)
i810_audio             21344   0 (unused)
ac97_codec             12000   0 [i810_audio]
soundcore               3492   2 [i810_audio]
3c59x                  25128   1

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
worktux:/usr/src/linux-2.4.22# cat /proc/ioports 
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
0cf8-0cff : PCI conf1
1000-101f : Intel Corp. 82801DB USB (Hub #1)
1400-141f : Intel Corp. 82801DB USB (Hub #2)
1800-181f : Intel Corp. 82801DB USB (Hub #3)
1c00-1c1f : Intel Corp. 82801DB/DBM SMBus Controller
2000-203f : Intel Corp. 82801DB AC'97 Audio Controller
  2000-203f : Intel ICH4
2400-24ff : Intel Corp. 82801DB AC'97 Audio Controller
  2400-24ff : Intel ICH4
2800-280f : Intel Corp. 82801DB Ultra ATA Storage Controller
  2800-2807 : ide0
  2808-280f : ide1
3000-303f : Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller
3400-347f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  3400-347f : 02:09.0

worktux:/usr/src/linux-2.4.22# cat /proc/iomem   
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cf000-000cf7ff : Extension ROM
000dc000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-00257fe9 : Kernel code
  00257fea-002bf937 : Kernel data
0fef0000-0fefbfff : ACPI Tables
0fefc000-0fefffff : ACPI Non-volatile Storage
0ff00000-0ff7ffff : System RAM
0ff80000-0fffffff : reserved
10000000-100003ff : Intel Corp. 82801DB Ultra ATA Storage Controller
d0000000-d00003ff : Intel Corp. 82801DB USB2
d0000800-d00008ff : Intel Corp. 82801DB AC'97 Audio Controller
  d0000800-d00008ff : ich_audio MBBAR
d0000c00-d0000dff : Intel Corp. 82801DB AC'97 Audio Controller
  d0000c00-d0000dff : ich_audio MMBAR
d1000000-d1ffffff : PCI Bus #01
  d1000000-d1ffffff : nVidia Corporation NV18 [GeForce4 MX 440SE AGP
8x]
d2000000-d2000fff : Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet
Controller
d2001000-d200107f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e0000000-e3ffffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge
f0000000-f3ffffff : PCI Bus #01
  f0000000-f3ffffff : nVidia Corporation NV18 [GeForce4 MX 440SE AGP
8x]
fec00000-fed003ff : reserved
fee00000-fee00fff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
worktux:/usr/src/linux-2.4.22# lspci -vvv 
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
        Subsystem: Unknown device 1734:1003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [4105]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 01) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d1000000-d1ffffff
        Prefetchable memory behind bridge: f0000000-f3ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1004
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 1000 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1004
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 1400 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1004
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at 1800 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
(prog-if 20)
        Subsystem: Unknown device 1734:1004
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
[size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
81) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=80
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d2000000-d20fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
(prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 1734:1004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 2800 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable)
[size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
        Subsystem: Unknown device 1734:1004
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 1c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5
(rev 01)
        Subsystem: Unknown device 1734:0088
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=64]
        Region 2: Memory at d0000c00 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at d0000800 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0182 (rev a2) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2922
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d1000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:08.0 Ethernet controller: Intel Corp.: Unknown device 1039 (rev 81)
        Subsystem: Unknown device 1734:1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d2000000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast
Etherlink] (rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 3400 [size=128]
        Region 1: Memory at d2001000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
no scsi components

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
i think the above informations are more then enough.... ;)
(for this default setting problem absolutly overkill...)

[8.] Other notes, patches, fixes, workarounds:
workaround 1:
unset and set the "PS/2 mouse (aka "auxiliary device") support" -
Option in "Character devices // Mice"

workaround 2:
change the option "CONFIG_PSMOUSE=m" to "CONFIG_PSMOUSE=y" in
.config...

information:
the kernel that runs during writing the mail was a "fixed" kernel
(CONFIG_PSMOUSE=y), should not be interesting for this problem!

kind regards,

Benjamin Eggerstedt
Hamburg/Germany
