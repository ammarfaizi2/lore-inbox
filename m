Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUELKN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUELKN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 06:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUELKN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 06:13:56 -0400
Received: from host44-125.pool194184.interbusiness.it ([194.184.125.44]:31116
	"HELO mail.sigruppo.it") by vger.kernel.org with SMTP
	id S263173AbUELKNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 06:13:41 -0400
Message-ID: <27239.194.98.240.35.1084356865.squirrel@mail.infoware-srl.com>
Date: Wed, 12 May 2004 12:14:25 +0200 (CEST)
Subject: PROBLEM: compiling NTFS write support
From: andrea.fracasso@infoware-srl.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have found a problem compiling te source of kernel 2.6.6, if I
enable NTFS write support when i run "make" i get this error:

....
  CC      fs/ntfs/inode.o
  CC      fs/ntfs/logfile.o
{standard input}: Assembler messages:
{standard input}:683: Error: suffix or operands invalid for `bsf'
make[2]: *** [fs/ntfs/logfile.o] Error 1
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2

my kernel version is:
Linux version 2.6.5-AS1500 (root@ntb-gozzolox) (gcc version 3.3.2 20031022
(Red Hat Linux 3.3.2-1)) #3 Thu Apr 15 10:13:11 CEST 2004

my cpu is:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 8
cpu MHz         : 1794.931
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext
3dnow
bogomips        : 3538.94
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

my loaded modules are:

ipv6 227488 12 - Live 0xffffffffa00c0000
lp 10832 0 - Live 0xffffffffa00bc000
autofs 14272 0 - Live 0xffffffffa00b7000
tg3 69188 0 - Live 0xffffffffa00a5000
floppy 60664 0 - Live 0xffffffffa0095000
sg 36088 0 - Live 0xffffffffa008b000
scsi_mod 121056 1 sg, Live 0xffffffffa006c000
parport_pc 24384 0 - Live 0xffffffffa0065000
parport 37900 2 lp,parport_pc, Live 0xffffffffa005a000
eth1394 18192 0 - Live 0xffffffffa0054000
ohci1394 31172 0 - Live 0xffffffffa004b000
ieee1394 98904 2 eth1394,ohci1394, Live 0xffffffffa0031000
hid 24064 0 - Live 0xffffffffa002a000
ehci_hcd 24964 0 - Live 0xffffffffa0022000
uhci_hcd 29600 0 - Live 0xffffffffa0019000
usbcore 97264 5 hid,ehci_hcd,uhci_hcd, Live 0xffffffffa0000000

My loaded driver and hardware information:
/proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-100f : 0000:00:11.1
  1000-1007 : ide0
  1008-100f : ide1
1020-103f : 0000:00:10.0
  1020-103f : uhci_hcd
1040-105f : 0000:00:10.1
  1040-105f : uhci_hcd
1060-107f : 0000:00:10.2
  1060-107f : uhci_hcd
1400-14ff : 0000:00:11.5
1800-18ff : 0000:00:11.6
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:00.0

/proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000cf000-000cffff : Adapter ROM
000d0000-000d0fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-002aff37 : Kernel code
  002aff38-003993e1 : Kernel data
1fef0000-1fefafff : ACPI Tables
1fefb000-1fefffff : ACPI Non-volatile Storage
1ff00000-1fffffff : reserved
20000000-20000fff : 0000:00:0b.0
20001000-20001fff : 0000:00:0b.1
d0000000-d000ffff : 0000:00:0a.0
d0010000-d00107ff : 0000:00:0b.2
  d0010000-d00107ff : ohci1394
d0010800-d00108ff : 0000:00:10.3
  d0010800-d00108ff : ehci_hcd
d0020000-d002ffff : 0000:00:0c.0
  d0020000-d002ffff : tg3
d0100000-d01fffff : PCI Bus #01
  d0100000-d010ffff : 0000:01:00.0
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
e0000000-efffffff : 0000:00:00.0
fffe0000-ffffffff : reserved

PCI information:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800
AGP] Host Bridge (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [c0] #08 [0060]
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #08 [8001]

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800
South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg
NIC (rev 01)
        Subsystem: AMBIT Microsystem Corp.: Unknown device 0404
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [disabled]
[size=64K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 00000000-00000000 (prefetchable)
        Memory window 1: 00000000-00000000 (prefetchable)
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled]
[size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 00000000-00000000 [disabled] (prefetchable)
        Memory window 1: 00000000-00000000 [disabled] (prefetchable)
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

00:0b.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 02) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at d0010000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+

00:0c.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M
Gigabit Ethernet (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at d0020000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                Address: fffbebfe7fffbc9c  Data: fdfe

00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 80) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1020 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 80) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1040 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 80) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1060 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
20 [EHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at d0010800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at 1400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97
Modem] (rev 80)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at 1800 [size=256]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0046
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=255 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



