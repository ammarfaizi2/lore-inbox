Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTI3O2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTI3O2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:28:50 -0400
Received: from cluster13.lmt.lv ([212.93.96.74]:51153 "EHLO cluster13.lmt.lv")
	by vger.kernel.org with ESMTP id S261509AbTI3O2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:28:34 -0400
Message-ID: <3F79930E.4090009@lmt.lv>
Date: Tue, 30 Sep 2003 17:28:30 +0300
From: Andrejs Dubovskis <tux.nospam@lmt.lv>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0-test6 and apm
Content-Type: multipart/mixed;
 boundary="------------090800060208060507060908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090800060208060507060908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I have installed last kernel on ThinkPad T40, Redhat 9.0 and found problem with
apm module (the same problem was on 2.6-test5 too).
To minimize other program influence I have loaded system in single mode (no 
daemons and network) and executed following two commands:

# modprobe apm
# modprobe -r apm

When running second comand (module unloading) I got an Oops.

Oops description and other requested information are attached.

Regards,
--
Andrejs
(to reply remove .nospam)

Unable to handle kernel paging request at virtual address d08b643c
   printing eip:
d08b643c
*pde = 0134a067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d08b643c>]    Not tainted
EFLAGS: 00010246
EIP is at 0xd08b643c
eax: 00000000   ebx: fffc5016   ecx: 00000000   edx: 00000000
esi: c0398000   edi: 00000010   ebp: c0399fc4   esp: c0399fb0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0398000 task=c031e080)
Stack: c0398000 00000001 c0398000 c01070c9 c0105000 c0399fd4 c0107161 c0398000
         00099800 c0399ff8 c039a6bd c031e080 00000000 c03b45c8 00000007 c039a43f
         c03b9d80 00000816 0008e000 c010017e
Call Trace:
   [<c01070c9>] default_idle+0x0/0x2c
   [<c0105000>] rest_init+0x0/0x61
   [<c0107161>] cpu_idle+0x31/0x3a
   [<c039a6bd>] start_kernel+0x150/0x15d
   [<c039a43f>] unknown_bootoption+0x0/0xfa

Code:  Bad EIP value.
   <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing



--------------090800060208060507060908
Content-Type: text/plain;
 name="general.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="general.txt"

# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Intel(R) Pentium(R) M processor 1500MHz
stepping	: 5
cpu MHz		: 1495.485
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips	: 2957.31

# ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux adunb.td.lmt.lv 2.6.0-test6 #1 Tue Sep 30 16:05:55 EEST 2003 i686 i686 i386 GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         rtc
Linux version 2.6.0-test6 (andrejs@adunb.td.lmt.lv) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Tue Sep 30 16:05:55 EEST 2003
# cat /proc/modules
rtc 10920 1 - Live 0xd0872000
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1800-181f : 0000:00:1d.0
  1800-181f : uhci-hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci-hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci-hcd
1860-186f : 0000:00:1f.1
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : 0000:00:1f.3
18c0-18ff : 0000:00:1f.5
1c00-1cff : 0000:00:1f.5
2000-207f : 0000:00:1f.6
2400-24ff : 0000:00:1f.6
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
8000-803f : 0000:02:01.0
  8000-803f : e1000
9000-900f : 0000:09:01.0
9010-9013 : 0000:09:01.0
9014-9017 : 0000:09:01.0
9018-901f : 0000:09:01.0
9020-9027 : 0000:09:01.0
# cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d0fff : Extension ROM
000d1000-000d1fff : Extension ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ff4ffff : System RAM
  00100000-002d8bdf : Kernel code
  002d8be0-00396d7f : Kernel data
0ff50000-0ff68fff : ACPI Tables
0ff69000-0ff7afff : ACPI Non-volatile Storage
0ff80000-0fffffff : reserved
10000000-100003ff : 0000:00:1f.1
b0000000-b0000fff : 0000:02:00.0
b1000000-b1000fff : 0000:02:00.1
b2000000-b2000fff : 0000:09:02.0
b3000000-b3000fff : 0000:09:02.1
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4 - Controller
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4 - AC'97
c0100000-c01fffff : PCI Bus #01
  c0100000-c010ffff : 0000:01:00.0
c0200000-c020ffff : 0000:02:01.0
  c0200000-c020ffff : e1000
c0210000-c0210fff : 0000:02:02.0
c0220000-c023ffff : 0000:02:01.0
  c0220000-c023ffff : e1000
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
ff800000-ffffffff : reserved
# lspci -vvv
00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=0f, sec-latency=64
	I/O behind bridge: 00004000-00009fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
	Subsystem: IBM: Unknown device 0537
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0525
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0530
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=12, subordinate=15, sec-latency=176
	Memory window 0: ffff0000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=16, subordinate=19, sec-latency=176
	Memory window 0: ffff0000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
	Subsystem: IBM: Unknown device 0549
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 8000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

02:02.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
	Subsystem: Intel Corp.: Unknown device 2551
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0210000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:03.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=02, secondary=09, subordinate=0f, sec-latency=68
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

09:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: CMD Technology Inc PCI0648
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9020 [size=8]
	Region 1: I/O ports at 9014 [size=4]
	Region 2: I/O ports at 9018 [size=8]
	Region 3: I/O ports at 9010 [size=4]
	Region 4: I/O ports at 9000 [size=16]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

09:02.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: IBM: Unknown device 0148
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=09, secondary=0a, subordinate=0d, sec-latency=176
	Memory window 0: ffff0000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

09:02.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: IBM: Unknown device 0148
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b3000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=09, secondary=0e, subordinate=11, sec-latency=176
	Memory window 0: ffff0000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001



--------------090800060208060507060908--

