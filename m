Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTJVG27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 02:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJVG27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 02:28:59 -0400
Received: from sea2-f19.sea2.hotmail.com ([207.68.165.19]:26384 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263445AbTJVG2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 02:28:49 -0400
X-Originating-IP: [213.201.141.5]
X-Originating-Email: [t_spoor@hotmail.com]
From: "Toshio Spoor" <t_spoor@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Compaq Evo N1020v lockups.
Date: Wed, 22 Oct 2003 06:28:47 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F19eS8IANIlk1W0000da00@hotmail.com>
X-OriginalArrivalTime: 22 Oct 2003 06:28:48.0038 (UTC) FILETIME=[C035DC60:01C39865]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a (very vague) bug report: (sorry for that)

[1.] One line summary of the problem:

Compaq Evo N1020v lockups. (notebook)

[2.] Full description of the problem/report:

Since 2.4.23-pre3 I experience lockups the same goes for (estimate) 
2.6.0-test3 => (Looks some code has merged in test3 too from 2.4.23-pre3). 
Unfortunately I can't pin point the  problem because this lame Compaq laptop 
doesn't have a serial port. For now I am using 2.4.22 that kernel seems 
stable. Also I have tried to disable ACPI that didn't work either. So I 
suspect the cause of the problem is somewhere in the changes of 2.4.23-pre3. 
(By the way, it still crashes with higher pre versions e.g. pre7)

[3.] Keywords (i.e., modules, networking, kernel):

kernel, modules

[4.] Kernel version (from /proc/version):

Linux version 2.4.23-pre3cust0 (root@void) (gcc version 3.3.2 (Debian)) #1 
Mon Oct 20 14:55:25 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

Getting large files using smbclient is enough to lockup my system. But 
sometimes the machine lockups without reason probably when there is network 
activity.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux void 2.4.23-pre3 #1 Mon Oct 20 14:55:25 CEST 2003 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         parport_pc lp parport ntfs 8139cp mii usbmouse 
keybdev mousedev hid input usb-ohci usbcore

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2388.231
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
bogomips        : 4757.91

[7.3.] Module information (from /proc/modules):

parport_pc             28200   1 (autoclean)
lp                      7072   0 (autoclean)
parport                26728   1 (autoclean) [parport_pc lp]
ntfs                   54496   2 (autoclean)
8139cp                 11496   1
mii                     2480   0 [8139cp]
usbmouse                2296   0 (unused)
keybdev                 2148   0 (unused)
mousedev                4372   1
hid                    21828   0 (unused)
input                   3520   0 [usbmouse keybdev mousedev hid]
usb-ohci               19304   0 (unused)
usbcore                63692   1 [usbmouse hid usb-ohci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8000-803f : ALi Corporation M7101 PMU
8040-805f : ALi Corporation M7101 PMU
8080-808f : ALi Corporation M5229 IDE
  8080-8087 : ide0
  8088-808f : ide1
8090-8097 : Conexant HSF 56k HSFi Modem
8400-84ff : ALi Corporation M5451 PCI AC-Link Controller Audio Device
8800-88ff : PCI CardBus #02
8c00-8cff : PCI CardBus #02
9000-90ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  9000-90ff : 8139cp
a000-afff : PCI Bus #01
  a000-a0ff : ATI Technologies Inc Radeon IGP 340M

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1bf6ffff : System RAM
  00100000-002d53da : Kernel code
  002d53db-00379663 : Kernel data
1bf70000-1bf7efff : ACPI Tables
1bf7f000-1bf7ffff : ACPI Non-volatile Storage
1bf80000-1bffffff : reserved
2bf80000-2bffffff : reserved
e8000000-e800ffff : Conexant HSF 56k HSFi Modem
e8010000-e8013fff : Texas Instruments PCI4410 FireWire Controller
e8014000-e8014fff : ALi Corporation M5451 PCI AC-Link Controller Audio 
Device
e8016000-e8016fff : NEC Corporation USB
  e8016000-e8016fff : usb-ohci
e8017000-e8017fff : NEC Corporation USB (#2)
  e8017000-e8017fff : usb-ohci
e8018000-e80187ff : Texas Instruments PCI4410 FireWire Controller
e8018800-e80188ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e8018800-e80188ff : 8139cp
e8018c00-e8018cff : NEC Corporation USB 2.0
e8300000-e83fffff : PCI Bus #01
  e8300000-e830ffff : ATI Technologies Inc Radeon IGP 340M
e8600000-e8600fff : ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M]
ec000000-efffffff : ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M]
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : ATI Technologies Inc Radeon IGP 340M
    f0000000-f02fffff : vesafb
fbbfd000-ffbfcfff : PCI CardBus #02
ffbfd000-ffbfdfff : PCI CardBus #02
ffbfe000-ffbfefff : Texas Instruments PCI4410 PC card Cardbus Controller
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] 
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at e8600000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e8300000-e83fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Region 1: Memory at e8014000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:0a.0 CardBus bridge: Texas Instruments PCI4410 PC card Cardbus Controller 
(rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: ffbfd000-ffbfd000 (prefetchable)
        Memory window 1: fbbfd000-ffbfc000
        I/O window 0: 00008c00-00008cff
        I/O window 1: 00008800-000088ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 FireWire (IEEE 1394): Texas Instruments PCI4410 FireWire Controller 
(rev 02) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8018000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e8010000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 20)
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 0x20 (128 
bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at e8018800 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 8d89
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
        Region 1: I/O ports at 8090 [size=8]
        Capabilities: <available only to root>

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
        Subsystem: ALi Corporation M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 8080 [size=16]
        Capabilities: <available only to root>

00:11.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: ALi Corporation ALI M7101 Power Management Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:13.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8016000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:13.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at e8017000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:13.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at e8018c00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M 
(prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 0056
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at a000 [size=256]
        Region 2: Memory at e8300000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: none

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

No idea really...

[X.] Other notes, patches, fixes, workarounds:

N/A

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

