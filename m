Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTBPCph>; Sat, 15 Feb 2003 21:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTBPCph>; Sat, 15 Feb 2003 21:45:37 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:7927 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265670AbTBPCpa>; Sat, 15 Feb 2003 21:45:30 -0500
Message-ID: <3E4EFD75.3000708@nyc.rr.com>
Date: Sat, 15 Feb 2003 21:54:45 -0500
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5 freezing after uncompressing linux
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

[Linux 2.5] Freezing after Uncompressing Linux

[2.] Full description of the problem/report:

The kernel freezes immediately after "Uncompressing Linux... OK".
No further messages are displayed.  I'm following wli's advice to
add some printk's to check whether the system is even getting to
startup_32(), but perhaps others have seen this problem.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, boot

[4.] Kernel version (from /proc/version):

Linux version 2.5.61 (vir) (gcc version 3.2.3 20030210 (Debian prerelease))

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
      problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 1999.794
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3984.58

[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #04
4c00-4cff : PCI CardBus #04
7000-70ff : PCI device 10ec:8139
   7000-70ff : 8139too
8000-801f : PCI device 8086:2442
   8000-801f : usb-uhci
8060-807f : PCI device 8086:2444
   8060-807f : usb-uhci
a000-afff : PCI Bus #01
   a000-a0ff : PCI device 1002:4c59
b000-b0ff : PCI device 8086:2445
   b000-b0ff : Intel ICH2
b400-b43f : PCI device 8086:2445
   b400-b43f : Intel ICH2
b800-b8ff : PCI device 8086:2446
bc00-bc7f : PCI device 8086:2446
bc90-bc9f : PCI device 8086:244b
   bc90-bc97 : ide0
   bc98-bc9f : ide1
f300-f30f : PCI device 8086:2443

$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffdffff : System RAM
   00100000-002c6069 : Kernel code
   002c606a-0033d39f : Kernel data
0ffe0000-0fff7fff : ACPI Non-volatile Storage
10000000-10000fff : PCI device 104c:ac55
10001000-10001fff : PCI device 104c:ac55
10400000-107fffff : PCI CardBus #03
10800000-10bfffff : PCI CardBus #03
10c00000-10ffffff : PCI CardBus #04
11000000-113fffff : PCI CardBus #04
80100000-801007ff : PCI device 104c:8026
   80100000-801007ff : ohci1394
80100800-801008ff : PCI device 10ec:8139
   80100800-801008ff : 8139too
80104000-80107fff : PCI device 104c:8026
80500000-805fffff : PCI Bus #01
   80500000-8050ffff : PCI device 1002:4c59
     80500000-8050ffff : radeonfb
80600000-900fffff : PCI Bus #01
   88000000-8fffffff : PCI device 1002:4c59
     88000000-8fffffff : radeonfb
e0000000-efffffff : PCI device 8086:1a30
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev
04)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04
) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: 80500000-805fffff
         Prefetchable memory behind bridge: 80600000-900fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) 
(prog-if 00 [N
ormal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
         I/O behind bridge: 00007000-00007fff
         Memory behind bridge: 80100000-801fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 
[Master
])
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 4: I/O ports at bc90 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) 
(prog-if 0
0 [UHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at 8000 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 10
         Region 4: I/O ports at f300 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) 
(prog-if 0
0 [UHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 11
         Region 4: I/O ports at 8060 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 05
)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 10
         Region 0: I/O ports at b000 [size=256]
         Region 1: I/O ports at b400 [size=64]

00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev 05) 
(prog-if
  00 [Generic])
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 10
         Region 0: I/O ports at b800 [size=256]
         Region 1: I/O ports at bc00 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M6 LY (p
rog-if 00 [VGA])
         Subsystem: Acer Incorporated [ALI]: Unknown device 101d
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping+ SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
         Region 1: I/O ports at a000 [size=256]
         Region 2: Memory at 80500000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at 80520000 [disabled] [size=128K]
         Capabilities: <available only to root>

02:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 
IEEE-1394a-2000 Contro
ller (PHY/Link) (prog-if 10 [OHCI])
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 1000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=2K]
         Region 1: Memory at 80104000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: <available only to root>

02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139
C+ (rev 10)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 66 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 7000 [size=256]
         Region 1: Memory at 80100800 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at 80120000 [disabled] [size=64K]
         Capabilities: <available only to root>

02:09.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus 
Controller (re
v 01)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 168, cache line size 20
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
         Memory window 0: 10400000-107ff000 (prefetchable)
         Memory window 1: 10800000-10bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001

02:09.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus 
Controller (re
v 01)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 168, cache line size 20
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
         Memory window 0: 10400000-107ff000 (prefetchable)
         Memory window 1: 10800000-10bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001

02:09.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus 
Controller (re
v 01)
         Subsystem: Acer Incorporated [ALI]: Unknown device 1027
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 168, cache line size 20
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=04, subordinate=04, sec-latency=176
         Memory window 0: 10c00000-10fff000 (prefetchable)
         Memory window 1: 11000000-113ff000
         I/O window 0: 00004800-000048ff
         I/O window 1: 00004c00-00004cff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001


[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


