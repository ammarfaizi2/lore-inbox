Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271816AbTGRKJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271823AbTGRKJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:09:16 -0400
Received: from [213.26.12.10] ([213.26.12.10]:23190 "HELO mail.robox.it")
	by vger.kernel.org with SMTP id S271816AbTGRKHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:07:37 -0400
Message-ID: <3F17CA63.2050203@robox.it>
Date: Fri, 18 Jul 2003 12:22:27 +0200
From: Marco Lazzarotto <m.lazzarotto@robox.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030502 Debian/1.2.1-9woody3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ext3 / USB Mass Storage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Kernel bug erasing a file in an ext3 fs on a usb pen

[2.]
  0) Disk partitioned with one primary partition, taking all space.
disk size is 64Mb
[cfdisk 2.11n
Copyright (C) 1994-2000 Kevin E. Martin & aeb]
  1) I created a filesystem : mkfs.ext3 /dev/sda1
[mke2fs 1.27 (8-Mar-2002)]
  2) I copied a 27 MB long file twice on the pen (two versions of the 
same file, with the same name), and got a series of "ext3_new_block: 
Allocating block in system zone" errors (see log)
  3) I tried to delete the same file, and got a "Kernel bug" message 
(see log)

[3.] Keywords: ext3, usb mass storage, TwinMOS Mobile disk

[4.] Kernel version (from /proc/version):
	Linux version 2.4.20 (root@marco) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #2 Wed May 14 15:12:07 CEST 2003

[5.] Output of Oops.. message:
	none

[7.] Environment
	Debian stable (woody)

[7.1.] Software
	Gnu C                  2.95.4
	Gnu make               3.79.1
	util-linux             2.11n
	mount                  2.11n
	modutils               2.4.15
	e2fsprogs              1.27
	fsck.jfs: not found
	reiserfsck: not found
	pcmcia-cs              3.1.33
	PPP                    2.4.1
	isdnctrl: not found
	Linux C Library        2.2.5
	Dynamic linker (ldd)   2.2.5
	Procps                 2.0.7
	Net-tools              1.60
	Console-tools          0.2.3
	Sh-utils               2.0.11
	Modules Loaded         vmnet vmmon [vmware stuff]


[7.2.] Processor information (from /proc/cpuinfo):
	processor       : 0
	vendor_id       : GenuineIntel
	cpu family      : 6
	model           : 11
	model name      : Intel(R) Pentium(R) III CPU 1133MHz
	stepping        : 1
	cpu MHz         : 1135.943
	cache size      : 256 KB
	fdiv_bug        : no
	hlt_bug         : no
	f00f_bug        : no
	coma_bug        : no
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 2
	wp              : yes
	flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
	bogomips        : 2267.54

[7.3.] Module information (from /proc/modules):
	vmnet                  21152   1
	vmmon                  19636   0 (unused)

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
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07
a400-a41f : Intel Corp. 82801BA/BAM USB (Hub #1)
   a400-a41f : usb-uhci
a800-a80f : Intel Corp. 82801BA IDE U100
   a800-a807 : ide0
   a808-a80f : ide1
b000-b0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   b000-b0ff : 8139too
b400-b4ff : ESS Technology ESS Modem
b800-b8ff : ESS Technology ES1988 Allegro-1
   b800-b8ff : maestro3
d000-dfff : PCI Bus #01
   d800-d8ff : ATI Technologies Inc Radeon Mobility M6 LY

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
   00100000-002b26c6 : Kernel code
   002b26c7-00357a23 : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
10000000-10000fff : Ricoh Co Ltd RL5c476 II
10001000-10001fff : Ricoh Co Ltd RL5c476 II (#2)
10400000-107fffff : PCI CardBus #03
10800000-10bfffff : PCI CardBus #03
10c00000-10ffffff : PCI CardBus #07
11000000-113fffff : PCI CardBus #07
ee800000-ee8000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   ee800000-ee8000ff : 8139too
ef000000-efefffff : PCI Bus #01
   ef000000-ef00ffff : ATI Technologies Inc Radeon Mobility M6 LY
     ef000000-ef00ffff : radeonfb
eff00000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : ATI Technologies Inc Radeon Mobility M6 LY
     f0000000-f7ffffff : radeonfb
f8000000-fbffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub
fffc0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [88] #09 [e104]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp.: Unknown device 1131 (rev 04) (prog-if 
00 [Normal decode])        Control: I/O+ Mem+ BusMaster+ SpecCycle- 
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: ef000000-efefffff
         Prefetchable memory behind bridge: eff00000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 
05) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000b000-0000bfff
         Memory behind bridge: ee800000-eeffffff
         Prefetchable memory behind bridge: eff00000-efefffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge 
(ICH2) (rev 05)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 
(rev 05) (prog-if 80 [Master])
         Subsystem: Asustek Computer, Inc.: Unknown device 1567
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 4: I/O ports at a800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB 
(Hub A) (rev 05) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 1567
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 9
         Region 4: I/O ports at a400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M6 LY (prog-if 00
[VGA])
         Subsystem: Asustek Computer, Inc.: Unknown device 1491
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Region 1: I/O ports at d800 [size=256]
         Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at effe0000 [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
                 Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable- 
DSel=0 DScale=0 PME-

02:01.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 
(rev 12)
         Subsystem: Asustek Computer, Inc.: Unknown device 1049
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 6000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at b800 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)                Status: D0 PME-Enable- 
DSel=0 DScale=0 PME-

02:01.1 Communication controller: ESS Technology ESS Modem (rev 12)
         Subsystem: Asustek Computer, Inc.: Unknown device 1049
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at b400 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
         Subsystem: Asustek Computer, Inc.: Unknown device 1045
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at b000 [size=256]
         Region 1: Memory at ee800000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
         Subsystem: Asustek Computer, Inc.: Unknown device 1564
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
         Memory window 0: 10400000-107ff000 (prefetchable)
         Memory window 1: 10800000-10bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001

02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
         Subsystem: Asustek Computer, Inc.: Unknown device 1564
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168
         Interrupt: pin B routed to IRQ 10
         Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
         Memory window 0: 10c00000-10fff000 (prefetchable)
         Memory window 1: 11000000-113ff000
         I/O window 0: 00004800-000048ff
         I/O window 1: 00004c00-00004cff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: TwinMOS  Model: MOBILE Disk      Rev: 1.11
   Type:   Direct-Access                    ANSI SCSI revision: 02


[X.] Other notes, patches, fixes, workarounds:
	I didn't find the MAINTAINERS file ...

