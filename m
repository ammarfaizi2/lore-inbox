Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVCEXem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVCEXem (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVCEXbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:31:00 -0500
Received: from tmm.dk ([62.79.97.28]:57558 "EHLO homer.tmm.dk")
	by vger.kernel.org with ESMTP id S261325AbVCEXG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:06:56 -0500
Date: Sat, 5 Mar 2005 23:59:08 +0100
From: Theis =?iso-8859-1?Q?M=2E_M=F8nsted?= <tmm@tmm.dk>
To: linux-kernel@vger.kernel.org
Subject: Scheduling while atomic on Powerbook G4
Message-ID: <20050305225908.GA12112@tmm.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

-- 
Med venlig hilsen / Best regards
Theis M. Mønsted

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bugreport

[1.] One line summary of the problem:
scheduling while atomic: swapper/0x00000002/0


[2.] Full description of the problem/report:
Early during boot the following call trace is printed : 
Call trace:
 [c02ca4f0] schedule+0x658/0x6d4
 [c0004640] syscall_exit_work+0x108/0x10c
 [c03c3864] proc_root_init+0x14c/0x158
 [ff847168] 0xff847168
 [c03ae5d4] start_kernel+0x140/0x16c
 [00003a30] 0x3a30

There seems to be no ill effects on the system.
The system is a PowerBook G4

[3.] Keywords (i.e., modules, networking, kernel):
scheduling, atomic PowerBook, ppc


[4.] Kernel version (from /proc/version):
$ cat /proc/version
Linux version 2.6.11.1 (tmm@mac) (gcc version 3.4.1 20040803 (Gentoo Linux 3.4.1-r3, ssp-3.4-2, pie-8.7.6.5)) #4 Sat Mar 5 21:00:07 UTC 2005


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
n/a


[6.] A small shell script or example program which triggers the
     problem (if possible)
n/a

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mac 2.6.11.1 #4 Sat Mar 5 21:00:07 UTC 2005 ppc 7447/7457, altivec supported PowerBook5,2 GNU/Linux

Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   030
Modules Loaded         i2c_dev snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_powermac snd_pcm snd_timer snd soundcore snd_page_alloc


[7.2.] Processor information (from /proc/cpuinfo):
$ cat /proc/cpuinfo
processor       : 0
cpu             : 7447/7457, altivec supported
clock           : 765MHz
revision        : 1.1 (pvr 8002 0101)
bogomips        : 508.92
machine         : PowerBook5,2
motherboard     : PowerBook5,2 MacRISC3 Power Macintosh
detected as     : 287 (PowerBook G4 15")
pmac flags      : 0000001b
L2 cache        : 512K unified
memory          : 512MB
pmac-generation : NewWorld


[7.3.] Module information (from /proc/modules):
$ cat /proc/modules
i2c_dev 10048 0 - Live 0xe20c7000
snd_pcm_oss 60352 0 - Live 0xe2246000
snd_mixer_oss 19584 1 snd_pcm_oss, Live 0xe20ce000
snd_seq_oss 39540 0 - Live 0xe2229000
snd_seq_midi_event 7456 1 snd_seq_oss, Live 0xe20c4000
snd_seq 63480 4 snd_seq_oss,snd_seq_midi_event, Live 0xe2218000
snd_seq_device 8396 2 snd_seq_oss,snd_seq, Live 0xe20c0000
snd_powermac 43140 0 - Live 0xe220c000
snd_pcm 99332 2 snd_pcm_oss,snd_powermac, Live 0xe20dc000
snd_timer 25252 2 snd_seq,snd_pcm, Live 0xe20a8000
snd 56948 8 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_powermac,snd_pcm,snd_timer, Live 0xe20b1000
soundcore 8900 1 snd, Live 0xe209b000
snd_page_alloc 8356 1 snd_pcm, Live 0xe2097000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
$ cat /proc/ioports
00000000-007fffff : /pci@f2000000
00802000-01001fff : /pci@f0000000
  00802400-008024ff : 0000:00:10.0
    00802400-008024ff : radeonfb
ff7fe000-ffffdfff : /pci@f4000000

$ cat /proc/iomem
80000000-afffffff : /pci@f2000000
  80000000-8007ffff : 0001:10:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
        80008000-800080ff : i2s-a- Tx DMA
      80008100-800081ff : 0.00010000:i2s
        80008100-800081ff : i2s-a- Rx DMA
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008800-800088ff : 0.00020000:ata-3
        80008800-800088ff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
        80010000-80010fff : i2s-a
      80013000-80013000 : 0.00013000:ch-b
      80013010-80013010 : 0.00013000:ch-b
      80013020-80013020 : 0.00013020:ch-a
      80013030-80013030 : 0.00013020:ch-a
      80013040-80013040 : 0.00013000:ch-b
      80013050-80013050 : 0.00013020:ch-a
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
        80016000-80017fff : via-pmu
      80018000-80018fff : 0.00018000:i2c
      80020000-80020fff : 0.00020000:ata-3
        80020000-80020fff : ide-pmac (ports)
      80040000-8007ffff : interrupt-controller
        80040000-8007ffff : 0.00040000:interrup
  a0000000-a00000ff : 0001:10:1b.2
    a0000000-a00000ff : ehci_hcd
  a0001000-a0001fff : 0001:10:1b.1
    a0001000-a0001fff : ohci_hcd
  a0002000-a0002fff : 0001:10:1b.0
    a0002000-a0002fff : ohci_hcd
  a0003000-a0003fff : 0001:10:1a.0
    a0003000-a0003fff : ohci_hcd
  a0004000-a0004fff : 0001:10:13.0
  a0006000-a0007fff : 0001:10:12.0
b0000000-bfffffff : /pci@f0000000
  b0000000-b000ffff : 0000:00:10.0
    b0000000-b000ffff : radeonfb
  b8000000-bfffffff : 0000:00:10.0
    b8000000-bfffffff : radeonfb
f1000000-f1ffffff : /pci@f0000000
  f1000000-f101ffff : 0000:00:10.0
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:24:0e.0
  f5004000-f5007fff : 0002:24:0d.0
    f5004000-f5007fff : Kauai ATA
  f5200000-f53fffff : 0002:24:0f.0
    f5200000-f53fffff : sungem
f8000000-f8ffffff : uni-n


[7.5.] PCI information ('lspci -vvv' as root)
# lspci -vvv
0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, cache line size 08
        Capabilities: [80] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:00:10.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at b8000000 (32-bit, prefetchable) [size=f1000000]
        Region 1: I/O ports at 802400 [size=256]
        Region 2: Memory at b0000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [58] AGP version 2.0
                Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, cache line size 08

0001:10:12.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 02)
        Subsystem: Apple Computer Inc.: Unknown device 004e
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Interrupt: pin A routed to IRQ 52
        Region 0: Memory at a0006000 (32-bit, non-prefetchable) [disabled]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+

0001:10:13.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, cache line size 08
        Interrupt: pin A routed to IRQ 53
        Region 0: Memory at a0004000 (32-bit, non-prefetchable)
        Bus: primary=10, secondary=11, subordinate=14, sec-latency=176
        Memory window 0: 90000000-9ffff000
        Memory window 1: 00000000-00000000
        I/O window 0: 00000000-00007fff
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

0001:10:17.0 Class ff00: Apple Computer Inc. KeyLargo/Intrepid Mac I/O
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, cache line size 08
        Region 0: Memory at 80000000 (32-bit, non-prefetchable)

0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB (prog-if 10 [OHCI])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0

0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB (prog-if 10 [OHCI])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0

0001:10:1a.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB (prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at a0003000 (32-bit, non-prefetchable)

0001:10:1b.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 63
        Region 0: Memory at a0002000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:10:1b.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 63
        Region 0: Memory at a0001000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:10:1b.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
        Subsystem: NEC Corporation USB 2.0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (4000ns min, 8500ns max), cache line size 08
        Interrupt: pin C routed to IRQ 63
        Region 0: Memory at a0000000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0002:24:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, cache line size 08

0002:24:0d.0 Class ff00: Apple Computer Inc. UniNorth/Intrepid ATA/100
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32, cache line size 08
        Interrupt: pin ? routed to IRQ 39
        Region 0: Memory at f5004000 (32-bit, non-prefetchable)

0002:24:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2 FireWire (rev 81) (prog-if 10 [OHCI])
        Subsystem: Apple Computer Inc.: Unknown device 5811
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 40
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [disabled]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0002:24:0f.0 Ethernet controller: Apple Computer Inc. UniNorth 2 GMAC (Sun GEM) (rev 80)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 16 (16000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=f5100000]
        Expansion ROM at 00100000 [disabled]


[7.6.] SCSI information (from /proc/scsi/scsi)
n/a


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
# cat /proc/swaps
Filename                                Type            Size    Used    Priority
/dev/hda10                              partition       1048568 0       -1

# cat /proc/interrupts
           CPU0
  1:         48   OpenPIC   Edge      PMac Output
  2:         57   OpenPIC   Edge      PMac Input
 24:         12   OpenPIC   Level     ide1
 25:      56948   OpenPIC   Level     VIA-PMU
 26:        137   OpenPIC   Level     keywest i2c
 29:         22   OpenPIC   Level     ohci_hcd
 39:       6450   OpenPIC   Level     ide0
 41:         53   OpenPIC   Level     eth0
 42:      16870   OpenPIC   Level     keywest i2c
 47:       1351   OpenPIC   Level     GPIO1 ADB
 61:          0   OpenPIC   Edge      Tumbler Headphone Detection
 63:       6220   OpenPIC   Level     ehci_hcd, ohci_hcd, ohci_hcd
BAD:      13384

# cat /proc/misc
  1 psaux
134 apm_bios
175 agpgart
144 nvram
135 rtc
154 pmu

complete dmesg output after boot: 
Total memory = 512MB; using 1024kB for hash table (at c0500000)
Linux version 2.6.11.1 (tmm@mac) (gcc version 3.4.1 20040803 (Gentoo Linux 3.4.1-r3, ssp-3.4-2, pie-8.7.6.5)) #4 Sat Mar 5 21:00:07 UTC 2005
Found UniNorth memory controller & host bridge, revision: 210
Mapped at 0xfdeb5000
Found a Intrepid mac-io controller, rev: 0, mapped at 0xfde35000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerBook G4 15"
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->1
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=702, gen1=703
nvram: Active bank is: 1
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
On node 0 totalpages: 131072
  DMA zone: 131072 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/hda11 ro
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc5e4000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
time_init: decrementer frequency = 18.432000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513664k available (2876k kernel code, 1236k data, 152k init, 0k highmem)
AGP special page: 0xdffff000
Calibrating delay loop... 508.92 BogoMIPS (lpj=254464)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
scheduling while atomic: swapper/0x00000002/0
Call trace:
 [c02ca4f0] schedule+0x658/0x6d4
 [c0004640] syscall_exit_work+0x108/0x10c
 [c03c3864] proc_root_init+0x14c/0x158
 [ff847168] 0xff847168
 [c03ae5d4] start_kernel+0x140/0x16c
 [00003a30] 0x3a30
NET: Registered protocol family 16
PCI: Probing PCI hardware
Can't get bus-range for /pci@f2000000/cardbus@13, assuming it starts at 0
PCI: Cannot allocate resource region 0 of device 0001:10:18.0
PCI: Cannot allocate resource region 0 of device 0001:10:19.0
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
Registering openpic with sysfs...
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Thermal assist unit not available
Registering PowerMac CPU frequency driver
Low: 765 Mhz, High: 1249 Mhz, Boot: 765 Mhz
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
radeonfb (0000:00:10.0): Invalid ROM signature 303 should be0xaa55
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=300.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: Using Firmware dividers 0x0002008e from PPLL 0
Console: switching to colour frame buffer device 160x53
radeonfb: Dynamic Clock Power Management enabled
Registered "mnca" backlight controller, level: 15/15
radeonfb (0000:00:10.0): ATI Radeon NP
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth 2 chipset
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.14.0 20050125 on minor 0: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:95:cd:85:ec
PHY ID: 1410cc1, addr: 0
eth0: Found Marvell 88E1101 PHY
MacIO PCI driver attached to Intrepid chipset
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
adt746x: Thermostat bus: 1, address: 0x2e, limit_adjust: 0, fan_speed: -1
adb: starting probe task...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI: Enabling device 0002:24:0d.0 (0000 -> 0002)
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input: ADB keyboard on adb2:2.c4/input
input: ADB Powerbook buttons on adb7:7.1f/input
ADB mouse at 3, handler set to 4 (trackpad)
input: ADB mouse on adb3:3.01/input
adb: finished probe task...
ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
Probing IDE interface ide0...
hda: Hitachi IC25N080ATMR04-0, ATA DISK drive
hda: Enabling Ultra DMA 5
ide0 at 0xe1022000-0xe1022007,0xe1022160 on irq 39
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
Probing IDE interface ide1...
hdc: MATSHITADVD-R UJ-816, ATAPI CD/DVD-ROM drive
hdc: Enabling MultiWord DMA 2
ide1 at 0xe100e000-0xe100e007,0xe100e160 on irq 24
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device 0001:10:1b.2 (0004 -> 0006)
ehci_hcd 0001:10:1b.2: NEC Corporation USB 2.0
ehci_hcd 0001:10:1b.2: irq 63, pci mem 0xa0000000
ehci_hcd 0001:10:1b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0001:10:1b.2: park 0
ehci_hcd 0001:10:1b.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
PCI: Enabling device 0001:10:1a.0 (0000 -> 0002)
ohci_hcd 0001:10:1a.0: Apple Computer Inc. KeyLargo/Intrepid USB (#3)
ohci_hcd 0001:10:1a.0: irq 29, pci mem 0xa0003000
ohci_hcd 0001:10:1a.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:1b.0 (0000 -> 0002)
ohci_hcd 0001:10:1b.0: NEC Corporation USB
ohci_hcd 0001:10:1b.0: irq 63, pci mem 0xa0002000
ohci_hcd 0001:10:1b.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
PCI: Enabling device 0001:10:1b.1 (0000 -> 0002)
ohci_hcd 0001:10:1b.1: NEC Corporation USB (#2)
ohci_hcd 0001:10:1b.1: irq 63, pci mem 0xa0001000
ohci_hcd 0001:10:1b.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using ohci_hcd and address 2
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
adt746x: ADT7460 initializing
adt746x: Lowering max temperatures from 81, 80, 87 to 70, 50, 70
adt746x: Setting speed to 0 for CPU fan.
adt746x: Setting speed to 0 for GPU fan.
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda11: found reiserfs format "3.6" with standard journal
usb 4-1: new full speed USB device using ohci_hcd and address 2
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 3 ports detected
usb 4-1.1: new low speed USB device using ohci_hcd and address 3
input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:10:1b.1-1.1
usb 4-1.2: new low speed USB device using ohci_hcd and address 4
input: USB HID v1.10 Mouse [062a:0001] on usb-0001:10:1b.1-1.2
ReiserFS: hda11: using ordered data mode
ReiserFS: hda11: journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commitage 30, max trans age 30
ReiserFS: hda11: checking transaction log (hda11)
ReiserFS: hda11: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 152k init 4k chrp 8k prep
Adding 1048568k swap on /dev/hda10.  Priority:-1 extents:1
ReiserFS: hda12: found reiserfs format "3.6" with standard journal
ReiserFS: hda12: using ordered data mode
ReiserFS: hda12: journal params: device hda12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commitage 30, max trans age 30
ReiserFS: hda12: checking transaction log (hda12)
ReiserFS: hda12: Using r5 hash to sort names
PHY ID: 1410cc1, addr: 0
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
i2c /dev entries driver


[X.] Other notes, patches, fixes, workarounds:

The message seems harmless, everything seems to be working just fine, but I thought I'd repport it just in case there's some actual issue that needs to be fixed.   Can test patches if needed.



--ZPt4rx8FFjLCG7dd--
