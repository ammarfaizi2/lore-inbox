Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbTCQTYP>; Mon, 17 Mar 2003 14:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTCQTYO>; Mon, 17 Mar 2003 14:24:14 -0500
Received: from keskus.netlab.hut.fi ([130.233.154.176]:49150 "EHLO
	keskus.tct.hut.fi") by vger.kernel.org with ESMTP
	id <S261924AbTCQTX2>; Mon, 17 Mar 2003 14:23:28 -0500
From: Markus Peuhkuri <puhuri@netlab.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15990.9020.539010.950006@ws26.tct.hut.fi>
Date: Mon, 17 Mar 2003 21:34:20 +0200
To: linux-kernel@vger.kernel.org
CC: linux-smp@vger.kernel.org
Subject: 2.4.20: keyboard not present errow with HIGHMEM64G
X-Mailer: VM 7.08 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Items correspond to template for REPORTING-BUGS)

[1.] 2.4.20 does not find keyboard with HIGHMEM64G set

[2.] Full description of the problem/report:

AT keyboard is not regonized when booting to 2.4.20 kernel with
HIGHMEM64G set.  Also has other problems (network configuration or
network communication fails, which makes other diagnostics difficult).
Also fails to detect PS2 mouse port.

If the very same kernel is compiled with HIGHMEM4G, everything works. 

I can do some testing, but I must give machine to productive use in a
week or two.

[3.] Keywords: HIGHMEM64G, kernel, keyboard

[4.] Kernel version: Linux version 2.4.20 (puhuri@seuraaja) (gcc
version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Mar 17
15:54:21 EET 2003
(compiled from kernel-source-2.4.20_2.4.20-5_all.deb)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux seuraaja 2.4.20 #1 SMP Mon Mar 17 15:54:21 EET 2003 i686 unknown
 
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
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

(Has two physical prosessors).

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.763
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.763
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4797.23

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.763
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4797.23

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.763
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4797.23


[7.3.] Module information (from /proc/modules):
(no modules loaded)
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : Intel Corp. 82801CA IDE U100
  0170-0177 : ide1
01f0-01f7 : Intel Corp. 82801CA IDE U100
  01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : Intel Corp. 82801CA IDE U100
  0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : Intel Corp. 82801CA IDE U100
  03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1100-111f : Intel Corp. 82801CA/CAM SMBus
2000-201f : Intel Corp. 82801CA/CAM USB (Hub #1)
2020-203f : Intel Corp. 82801CA/CAM USB (Hub #2)
2040-205f : Intel Corp. 82801CA/CAM USB (Hub #3)
2060-206f : Intel Corp. 82801CA IDE U100
  2060-2067 : ide0
  2068-206f : ide1
3000-3fff : PCI Bus #01
  3000-3fff : PCI Bus #03
    3000-307f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
      3000-307f : 03:01.0
    3080-30bf : Intel Corp. 82546EB Gigabit Ethernet Controller
    30c0-30ff : Intel Corp. 82546EB Gigabit Ethernet Controller (#2)
4000-5fff : PCI Bus #04
  4000-5fff : PCI Bus #06
    4000-40ff : PCI device 9005:801f (Adaptec)
    4400-44ff : PCI device 9005:801f (Adaptec)
    4800-48ff : PCI device 9005:801f (Adaptec)
    4c00-4cff : PCI device 9005:801f (Adaptec)
    5000-500f : 3ware Inc 3ware 7000-series ATA-RAID
      5000-500f : 3ware Storage Controller
6000-60ff : ATI Technologies Inc Rage XL

$ cat /proc/iomem   
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9000-000c97ff : Extension ROM
000c9800-000ca7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-7feeffff : System RAM
  00100000-002952d2 : Kernel code
  002952d3-003474ff : Kernel data
7fef0000-7fefbfff : ACPI Tables
7fefc000-7fefffff : ACPI Non-volatile Storage
7ff00000-7ff7ffff : System RAM
7ff80000-7fffffff : reserved
fc000000-fc0003ff : Intel Corp. 82801CA IDE U100
fc100000-fc2fffff : PCI Bus #01
  fc100000-fc100fff : Intel Corp. 82870P2 P64H2 I/OxAPIC
  fc101000-fc101fff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)
  fc200000-fc2fffff : PCI Bus #03
    fc200000-fc21ffff : Intel Corp. 82546EB Gigabit Ethernet Controller
    fc220000-fc23ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (#2)
    fc240000-fc24007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
fc300000-fcffffff : PCI Bus #04
  fc300000-fc300fff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#3)
  fc301000-fc301fff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#4)
  fc400000-fcffffff : PCI Bus #06
    fc400000-fc401fff : PCI device 9005:801f (Adaptec)
    fc402000-fc403fff : PCI device 9005:801f (Adaptec)
    fc404000-fc40400f : 3ware Inc 3ware 7000-series ATA-RAID
    fc800000-fcffffff : 3ware Inc 3ware 7000-series ATA-RAID
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe000000-fe000fff : ATI Technologies Inc Rage XL
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp.: Unknown device 2540 (rev 03)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:00.1 Class ff00: Intel Corp.: Unknown device 2541 (rev 03)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp.: Unknown device 2543 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc100000-fc2fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp.: Unknown device 2545 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
	I/O behind bridge: 00004000-00005fff
	Memory behind bridge: fc300000-fcffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 2484 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 2487 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 42) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fd000000-fe0fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 2480 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 248b (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 2060 [size=16]
	Region 5: Memory at fc000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 2483 (rev 02)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

01:1d.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0083]

01:1e.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

01:1f.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=48
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc200000-fc2fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0003]

03:01.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 3000 [size=128]
	Region 1: Memory at fc240000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:02.0 Ethernet controller: Intel Corp.: Unknown device 1010 (rev 01)
	Subsystem: Intel Corp.: Unknown device 1011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3080 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] #07 [0002]
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:02.1 Ethernet controller: Intel Corp.: Unknown device 1010 (rev 01)
	Subsystem: Intel Corp.: Unknown device 1011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin B routed to IRQ 29
	Region 0: Memory at fc220000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 30c0 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] #07 [0002]
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:1c.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc300000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

04:1d.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0003]

04:1e.0 PIC: Intel Corp.: Unknown device 1461 (rev 03) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc301000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

04:1f.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=48
	I/O behind bridge: 00004000-00005fff
	Memory behind bridge: fc400000-fcffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] #07 [0003]

06:01.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
	Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (2250ns min), cache line size 08
	Interrupt: pin A routed to IRQ 72
	Region 0: I/O ports at 5000 [size=16]
	Region 1: Memory at fc404000 (32-bit, non-prefetchable) [size=16]
	Region 2: Memory at fc800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:02.0 SCSI storage controller: Adaptec: Unknown device 801f (rev 03)
	Subsystem: Adaptec: Unknown device 005f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 76
	Region 0: I/O ports at 4400 [size=256]
	Region 1: Memory at fc400000 (64-bit, non-prefetchable) [size=8K]
	Region 3: I/O ports at 4000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] #07 [0042]

06:02.1 SCSI storage controller: Adaptec: Unknown device 801f (rev 03)
	Subsystem: Adaptec: Unknown device 005f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin B routed to IRQ 77
	Region 0: I/O ports at 4c00 [size=256]
	Region 1: Memory at fc402000 (64-bit, non-prefetchable) [size=8K]
	Region 3: I/O ports at 4800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] #07 [0042]

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 6000 [size=256]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Following is diff of /var/log/messages for non-sucessfull (HIGMEM64G,
not-ok) and successfull (HIGHMEM4G, yes-ok) bootup. 

--- /tmp/not-ok	Mon Mar 17 22:27:50 2003
+++ /tmp/yes-ok	Mon Mar 17 22:27:48 2003
@@ -1,289 +1,289 @@
 kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
 kernel: Inspecting /boot/System.map-2.4.20
-kernel: Loaded 18570 symbols from /boot/System.map-2.4.20.
+kernel: Loaded 18568 symbols from /boot/System.map-2.4.20.
 kernel: Symbols match kernel version 2.4.20.
 kernel: No module symbols loaded.
-kernel: Linux version 2.4.20 (puhuri@seuraaja) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Fri Mar 14 15:47:23 EET 2003
+kernel: Linux version 2.4.20 (puhuri@seuraaja) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Mar 17 15:54:21 EET 2003
 kernel: BIOS-provided physical RAM map:
 kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 kernel:  BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 kernel:  BIOS-e820: 000000007fef0000 - 000000007fefc000 (ACPI data)
 kernel:  BIOS-e820: 000000007fefc000 - 000000007ff00000 (ACPI NVS)
 kernel:  BIOS-e820: 000000007ff00000 - 000000007ff80000 (usable)
 kernel:  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 kernel: 1151MB HIGHMEM available.
 kernel: 896MB LOWMEM available.
 kernel: found SMP MP-table at 000f66b0
 kernel: hm, page 000f6000 reserved twice.
 kernel: hm, page 000f7000 reserved twice.
 kernel: hm, page 0009f000 reserved twice.
 kernel: hm, page 000a0000 reserved twice.
 kernel: On node 0 totalpages: 524160
 kernel: zone(0): 4096 pages.
 kernel: zone(1): 225280 pages.
 kernel: zone(2): 294784 pages.
 kernel: ACPI: Searched entire block, no RSDP was found.
 kernel: ACPI: RSDP located at physical address c00f6710
 kernel: RSD PTR  v0 [PTLTD ]
 kernel: __va_range(0x7fef8195, 0x68): idx=8 mapped at ffff6000
 kernel: ACPI table found: RSDT v1 [PTLTD    RSDT   1540.0]
 kernel: __va_range(0x7fefbe60, 0x24): idx=8 mapped at ffff6000
 kernel: __va_range(0x7fefbe60, 0x74): idx=8 mapped at ffff6000
 kernel: ACPI table found: FACP v1 [INTEL  K_CANYON 1540.0]
 kernel: __va_range(0x7fefbed4, 0x24): idx=8 mapped at ffff6000
 kernel: __va_range(0x7fefbed4, 0xb4): idx=8 mapped at ffff6000
 kernel: ACPI table found: APIC v1 [PTLTD  ^I APIC   1540.0]
 kernel: __va_range(0x7fefbed4, 0xb4): idx=8 mapped at ffff6000
 kernel: LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
 kernel: CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
 kernel: 
 kernel: LAPIC (acpi_id[0x0001] id[0x6] enabled[1])
 kernel: CPU 1 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16
 kernel: 
 kernel: LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
 kernel: CPU 2 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16
 kernel: 
 kernel: LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
 kernel: CPU 3 (0x0700) enabledProcessor #7 Pentium 4(tm) XEON(tm) APIC version 16
 kernel: 
 kernel: IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
 kernel: IOAPIC (id[0x3] address[0xfec80000] global_irq_base[0x18])
 kernel: IOAPIC (id[0x4] address[0xfec80400] global_irq_base[0x30])
 kernel: IOAPIC (id[0x5] address[0xfec81000] global_irq_base[0x48])
 kernel: IOAPIC (id[0x8] address[0xfec81400] global_irq_base[0x60])
 kernel: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
 kernel: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
 kernel: LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x1] lint[0x1])
 kernel: LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
 kernel: LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
 kernel: LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
 kernel: 4 CPUs total
 kernel: Local APIC address fee00000
 kernel: __va_range(0x7fefbf88, 0x24): idx=8 mapped at ffff6000
 kernel: __va_range(0x7fefbf88, 0x28): idx=8 mapped at ffff6000
 kernel: ACPI table found: BOOT v1 [PTLTD  $SBFTBL$ 1540.0]
 kernel: __va_range(0x7fefbfb0, 0x24): idx=8 mapped at ffff6000
 kernel: __va_range(0x7fefbfb0, 0x50): idx=8 mapped at ffff6000
 kernel: ACPI table found: SPCR v1 [PTLTD  $UCRTBL$ 1540.0]
 kernel: Enabling the CPU's according to the ACPI table
 kernel: Intel MultiProcessor Specification v1.4
 kernel:     Virtual Wire compatibility mode.
 kernel: OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
 kernel: I/O APIC #2 Version 32 at 0xFEC00000.
 kernel: I/O APIC #3 Version 32 at 0xFEC80000.
 kernel: I/O APIC #4 Version 32 at 0xFEC80400.
 kernel: I/O APIC #5 Version 32 at 0xFEC81000.
 kernel: I/O APIC #8 Version 32 at 0xFEC81400.
 kernel: Processors: 4
 kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=301
 kernel: Initializing CPU#0
-kernel: Detected 2399.759 MHz processor.
+kernel: Detected 2399.763 MHz processor.
 kernel: Console: colour VGA+ 80x25
 kernel: Calibrating delay loop... 4784.12 BogoMIPS
-kernel: Memory: 2068464k/2096640k available (1629k kernel code, 27724k reserved, 712k data, 120k init, 1179072k highmem)
+kernel: Memory: 2068536k/2096640k available (1620k kernel code, 27652k reserved, 712k data, 120k init, 1179072k highmem)
 kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
 kernel: Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
 kernel: Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
 kernel: Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
 kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
 kernel: CPU: L2 cache: 512K
 kernel: CPU: Physical Processor ID: 0
 kernel: Intel machine check architecture supported.
 kernel: Intel machine check reporting enabled on CPU#0.
 kernel: Enabling fast FPU save and restore... done.
 kernel: Enabling unmasked SIMD FPU exception support... done.
 kernel: Checking 'hlt' instruction... OK.
 kernel: POSIX conformance testing by UNIFIX
 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
 kernel: mtrr: detected mtrr type: Intel
 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
 kernel: CPU: L2 cache: 512K
 kernel: CPU: Physical Processor ID: 0
 kernel: Intel machine check reporting enabled on CPU#0.
 kernel: CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 kernel: per-CPU timeslice cutoff: 1462.99 usecs.
 kernel: enabled ExtINT on CPU#0
 kernel: ESR value before enabling vector: 00000000
 kernel: ESR value after enabling vector: 00000000
 kernel: Booting processor 1/1 eip 2000
 kernel: Initializing CPU#1
 kernel: masked ExtINT on CPU#1
 kernel: ESR value before enabling vector: 00000000
 kernel: ESR value after enabling vector: 00000000
 kernel: Calibrating delay loop... 4797.23 BogoMIPS
 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
 kernel: CPU: L2 cache: 512K
 kernel: CPU: Physical Processor ID: 0
 kernel: Intel machine check reporting enabled on CPU#1.
 kernel: CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 kernel: Booting processor 2/6 eip 2000
 kernel: Initializing CPU#2
 kernel: masked ExtINT on CPU#2
 kernel: ESR value before enabling vector: 00000000
 kernel: ESR value after enabling vector: 00000000
 kernel: Calibrating delay loop... 4797.23 BogoMIPS
 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
 kernel: CPU: L2 cache: 512K
 kernel: CPU: Physical Processor ID: 3
 kernel: Intel machine check reporting enabled on CPU#2.
 kernel: CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 kernel: Booting processor 3/7 eip 2000
 kernel: Initializing CPU#3
 kernel: masked ExtINT on CPU#3
 kernel: ESR value before enabling vector: 00000000
 kernel: ESR value after enabling vector: 00000000
 kernel: Calibrating delay loop... 4797.23 BogoMIPS
 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
 kernel: CPU: L2 cache: 512K
 kernel: CPU: Physical Processor ID: 3
 kernel: Intel machine check reporting enabled on CPU#3.
 kernel: CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 kernel: Total of 4 processors activated (19175.83 BogoMIPS).
 kernel: cpu_sibling_map[0] = 1
 kernel: cpu_sibling_map[1] = 0
 kernel: cpu_sibling_map[2] = 3
 kernel: cpu_sibling_map[3] = 2
 kernel: ENABLING IO-APIC IRQs
 kernel: Setting 2 in the phys_id_present_map
 kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
 kernel: Setting 3 in the phys_id_present_map
 kernel: ...changing IO-APIC physical APIC ID to 3 ... ok.
 kernel: Setting 4 in the phys_id_present_map
 kernel: ...changing IO-APIC physical APIC ID to 4 ... ok.
 kernel: Setting 5 in the phys_id_present_map
 kernel: ...changing IO-APIC physical APIC ID to 5 ... ok.
 kernel: Setting 8 in the phys_id_present_map
 kernel: ...changing IO-APIC physical APIC ID to 8 ... ok.
 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
 kernel: testing the IO APIC.......................
 kernel: 
 kernel:  WARNING: unexpected IO-APIC, please mail
 kernel:           to linux-smp@vger.kernel.org
 kernel: 
-last message repeated 3 times
+kernel: 
+last message repeated 2 times
 kernel: .................................... done.
 kernel: Using local APIC timer interrupts.
 kernel: calibrating APIC timer ...
-kernel: ..... CPU clock speed is 2399.6984 MHz.
-kernel: ..... host bus clock speed is 99.9872 MHz.
-kernel: cpu: 0, clocks: 999872, slice: 199974
-kernel: CPU0<T0:999872,T1:799888,D:10,S:199974,C:999872>
-kernel: cpu: 1, clocks: 999872, slice: 199974
-kernel: cpu: 3, clocks: 999872, slice: 199974
-kernel: cpu: 2, clocks: 999872, slice: 199974
-kernel: CPU1<T0:999872,T1:599920,D:4,S:199974,C:999872>
-kernel: CPU3<T0:999872,T1:199968,D:8,S:199974,C:999872>
-kernel: CPU2<T0:999872,T1:399936,D:14,S:199974,C:999872>
+kernel: ..... CPU clock speed is 2399.7491 MHz.
+kernel: ..... host bus clock speed is 99.9894 MHz.
+kernel: cpu: 0, clocks: 999894, slice: 199978
+kernel: CPU0<T0:999888,T1:799904,D:6,S:199978,C:999894>
+kernel: cpu: 1, clocks: 999894, slice: 199978
+kernel: cpu: 3, clocks: 999894, slice: 199978
+kernel: cpu: 2, clocks: 999894, slice: 199978
+kernel: CPU1<T0:999888,T1:599920,D:12,S:199978,C:999894>
+kernel: CPU3<T0:999888,T1:199968,D:8,S:199978,C:999894>
+kernel: CPU2<T0:999888,T1:399952,D:2,S:199978,C:999894>
 kernel: checking TSC synchronization across CPUs: passed.
 kernel: Waiting on wait_init_idle (map = 0xe)
 kernel: All processors have done init_idle
 kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
 kernel: mtrr: probably your BIOS does not setup all CPUs
 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd875, last bus=7
 kernel: PCI: Using configuration type 1
 kernel: PCI: Probing PCI hardware
 kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
 kernel: PCI: Discovered primary peer bus 10 [IRQ]
 kernel: PCI: Discovered primary peer bus 11 [IRQ]
 kernel: PCI: Discovered primary peer bus 12 [IRQ]
 kernel: PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
 kernel: PCI->APIC IRQ transform: (B0,I29,P0) -> 16
 kernel: PCI->APIC IRQ transform: (B0,I29,P1) -> 19
 kernel: PCI->APIC IRQ transform: (B0,I29,P2) -> 18
 kernel: PCI->APIC IRQ transform: (B3,I1,P0) -> 24
 kernel: PCI->APIC IRQ transform: (B3,I2,P0) -> 28
 kernel: PCI->APIC IRQ transform: (B3,I2,P1) -> 29
 kernel: PCI->APIC IRQ transform: (B6,I1,P0) -> 72
 kernel: PCI->APIC IRQ transform: (B6,I2,P0) -> 76
 kernel: PCI->APIC IRQ transform: (B6,I2,P1) -> 77
 kernel: PCI->APIC IRQ transform: (B7,I1,P0) -> 16
 kernel: Linux NET4.0 for Linux 2.4
 kernel: Based upon Swansea University Computer Society NET3.039
 kernel: Initializing RT netlink socket
 kernel: Starting kswapd
 kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
 kernel: Journalled Block Device driver loaded
 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
+kernel: Detected PS/2 Mouse Port.
 kernel: pty: 256 Unix98 ptys configured
 kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 kernel: ICH3: IDE controller on PCI bus 00 dev f9
 kernel: PCI: Enabling device 00:1f.1 (0005 -> 0007)
 kernel: PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably buggy MP table.
 kernel: ICH3: chipset revision 2
 kernel: ICH3: not 100%% native mode: will probe irqs later
 kernel:     ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
 kernel:     ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
-kernel: keyboard: Timeout - AT keyboard not present?(ed)
-kernel: keyboard: Timeout - AT keyboard not present?(f4)
 kernel: hda: WDC WD1200JB-75CRA0, ATA DISK drive
 kernel: hdc: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 kernel: ide1 at 0x170-0x177,0x376 on irq 15
-kernel: blk: queue c03d3be4, I/O limit 4095Mb (mask 0xffffffff)
+kernel: blk: queue c03c25e4, I/O limit 4095Mb (mask 0xffffffff)
 kernel: hda: setmax LBA 234441648, native  234375000
 kernel: hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=14589/255/63, UDMA(100)
 kernel: hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
 kernel: Uniform CD-ROM driver Revision: 3.12
 kernel: Partition check:
 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 kernel: Floppy drive(s): fd0 is 1.44M
 kernel: FDC 0 is a post-1991 82077
 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
 kernel: 03:01.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.16
 kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
 kernel: agpgart: Maximum main memory to use for agp memory: 1919M
 kernel: [drm] Initialized tdfx 1.0.0 20010216 on minor 0
 kernel: [drm] Initialized radeon 1.1.1 20010405 on minor 1
 kernel: SCSI subsystem driver Revision: 1.00
 kernel: 3ware Storage Controller device driver for Linux v1.02.00.031.
 kernel: scsi0 : Found a 3ware Storage Controller at 0x5000, IRQ: 72, P-chip: 1.3
 kernel: scsi0 : 3ware Storage Controller
-kernel: blk: queue f7b5a618, I/O limit 4095Mb (mask 0xffffffff)
+kernel: blk: queue f7bdfc18, I/O limit 4095Mb (mask 0xffffffff)
 kernel:   Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0 
 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
-kernel: blk: queue f7b5a418, I/O limit 4095Mb (mask 0xffffffff)
+kernel: blk: queue f7bdfa18, I/O limit 4095Mb (mask 0xffffffff)
 kernel:   Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0 
 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
-kernel: blk: queue f7b5a018, I/O limit 4095Mb (mask 0xffffffff)
+kernel: blk: queue f7bdf618, I/O limit 4095Mb (mask 0xffffffff)
 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
 kernel: Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
 kernel: SCSI device sda: 468745216 512-byte hdwr sectors (239998 MB)
 kernel:  sda: sda1
 kernel: SCSI device sdb: 468745216 512-byte hdwr sectors (239998 MB)
 kernel:  sdb: sdb1
 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
 kernel: IP: routing cache hash table of 16384 buckets, 128Kbytes
 kernel: TCP: Hash tables configured (established 262144 bind 65536)
 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 kernel: IPv6 v0.8 for NET4.0
 kernel: IPv6 over IPv4 tunneling driver
 kernel: kjournald starting.  Commit interval 5 seconds
 kernel: EXT3-fs: mounted filesystem with ordered data mode.
 kernel: VFS: Mounted root (ext3 filesystem) readonly.
 kernel: Freeing unused kernel memory: 120k freed
 kernel: Adding Swap: 2097136k swap-space (priority -1)
 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
 kernel: kjournald starting.  Commit interval 5 seconds
 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
 kernel: EXT3-fs: mounted filesystem with ordered data mode.
 kernel: kjournald starting.  Commit interval 5 seconds
 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
 kernel: EXT3-fs: mounted filesystem with ordered data mode.
 kernel: kjournald starting.  Commit interval 5 seconds
 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
 kernel: EXT3-fs: mounted filesystem with ordered data mode.
 kernel: kjournald starting.  Commit interval 5 seconds
 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
 kernel: EXT3-fs: mounted filesystem with ordered data mode.

-- 
Markus Peuhkuri        ! internet: Markus.Peuhkuri@hut.fi
HUT/Networking Lab.    ! http://www.iki.fi/puhuri/
P.O.Box 3000, 02015 HUT! tel: +358-9-451 2467 fax: +358-9-451 2474
Finland, EUROPE        ! gsm: +358-40-50 19683
