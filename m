Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbTISOYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 10:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbTISOYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 10:24:18 -0400
Received: from irc.dobrich.net ([217.79.68.9]:25995 "EHLO shtajga.dobrich.net")
	by vger.kernel.org with ESMTP id S261571AbTISOYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 10:24:03 -0400
Date: Fri, 19 Sep 2003 17:23:32 +0300 (EEST)
From: DD <n000n3@shtajga.dobrich.net>
To: linux-kernel@vger.kernel.org
Subject: frequent oops with BUG at skbuff.c
Message-ID: <Pine.LNX.4.10.10309191659010.16981-100000@shtajga.dobrich.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First i`m not susbcribed to mailing list so i want to receive mails at:
n000n3@dobrich.net


1.Frequent oops with BUG at skbuff.c
2.I receive a frequent oops about 2 at week with the message :Kernel BUG
at skbuff.c :92! they are not invoked from running of some software.They
are not at the same time i mean not exactly after 2 days.It have
most worked without problems about 8 days.
3.Kernel BUG at skbuff.c:92!
4.Kernel version : 2.4.22
fx:~# cat /proc/version
Linux version 2.4.22 (root@fx) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Mon Sep 15 13:23:13 EEST 2003

5.Output at oops:

kernel BUG at skbuff.c :92!
invalid operand : 0000
CPU : 0
EIP  : 0010 : [<c01c54b>]   Not tainted
EFLAGS : 00010282
eax: 0000002d  ebx: d0924f55  ecx: c0280000  edx: 00000000
esi: 000000a4  edi: c131c960  ebp: 000005ea  esp: c0281ee4
ds: 0018
es: 0018
procss swapper (pid :0 , stacktrace =e0281000)
Stack: c0250c00  d0924f55  000005ea  000005ea  c0250bf0  caa79080  d0924f5d
cda79080  000005ea  d0924f55  cf746400  c131c800  c131c960
00004050  c131c964  00000000  00000001  0000003f  c131c960  d09249e2
c131c800  cf746400  04000001  0000000b
Call Trace : [<d0924f55>] [<d0924f5d>] [<d0924f55>] [<d09249e2>]
[<c0107f0d>] [<c010808e>] [<c0105220>] [<c2105220>] [<c010a298>]
[<c0105220>] [<c0105220>] [<c2105243>] [<c01052a9>] [<c0105000>]
[<c0105027>]
Code : 0f 0b 5c 00 20 0c 25 c0 83 c4 14 5b c3 53 8b 54 24 08 8b 4c 


7.Debian woody 3.0 with iptables 
7.1ver_linux
Linux fx 2.4.22 #1 Mon Sep 15 13:23:13 EEST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         8139too crc32 eepro100 mii
7.2 cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2390.314
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02 
 
7.3 modules information
8139too                15584   2
crc32                   2832   0 [8139too]
eepro100               18732   1
mii                     2384   0 [8139too eepro100]
7.4 Loaded driver an hardware information 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (#2)
  d400-d4ff : 8139too
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d800-d8ff : 8139too
dc00-dc3f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  dc00-dc3f : eepro100
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
  ff00-ff07 : ide0
  ff08-ff0f : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca800-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-0022bca4 : Kernel code
  0022bca5-0027f6ff : Kernel data
d9600000-dd7fffff : PCI Bus #01
  da000000-dbffffff : nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model
64 Pro]
dd900000-dfafffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model
64 Pro]
dfe00000-dfefffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
dfffae00-dfffaeff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
(#2)
  dfffae00-dfffaeff : 8139too
dfffaf00-dfffafff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dfffaf00-dfffafff : 8139too
dfffb000-dfffbfff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  dfffb000-dfffbfff : eepro100
dfffc000-dfffcfff : Silicon Integrated Systems [SiS] USB 1.0 Controller
dfffd000-dfffdfff : Silicon Integrated Systems [SiS] USB 1.0 Controller
(#2)
dfffe000-dfffefff : Silicon Integrated Systems [SiS] USB 1.0 Controller
(#3)
dffff000-dfffffff : Silicon Integrated Systems [SiS] USB 2.0 Controller
e0000000-e3ffffff : Silicon Integrated Systems [SiS] SiS645DX Host &
Memory & AGP Controller
ffee0000-fff0fffe : reserved
fffc0000-ffffffff : reserved

7.5 PCI information
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0646
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dd900000-dfafffff
        Prefetchable memory behind bridge: d9600000-dd7fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE
Controller (A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at ff00 [size=16]

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfffc000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 12
        Region 0: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device
7002 (prog-if 20)
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at dc00 [size=64]
        Region 2: Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at dfd00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
        Subsystem: Allied Telesyn International: Unknown device 2503
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at dfffaf00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at dfffae00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at dffd0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)
(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at da000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at dfaf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

7.6 SCSI information 
no scsi devices attached to the system
 
10x in advance

