Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316099AbSENWdb>; Tue, 14 May 2002 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316100AbSENWda>; Tue, 14 May 2002 18:33:30 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:64516 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S316099AbSENWdY>; Tue, 14 May 2002 18:33:24 -0400
Message-ID: <3CE19014.80305@dcrdev.demon.co.uk>
Date: Tue, 14 May 2002 23:30:44 +0100
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dan@dcrdev.demon.co.uk
Subject: PIV laptop and PCI problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  I have a brand new laptop with a PIIX/ICH3 IDE chipset which 
neither 2.4.19 or 2.5.15 kernels seem to be able to configure/use correctly.

The root cause appears to be a "resource conflict" - I suspect the 
culprit may be hardware or bios but I'm guessing.....

Below are the relevant (I hope) boot messages and the output from lspci 
- any help/thoughts/ideas would be much appreciated.

Thanks,

Dan.

ACPI: RSDP (v000 PTLTD ) @ 0x000f6370
ACPI: RSDT (v001 PTLTD Sheeks 01540.00000) @ 0x1fefabd8
ACPI: FADT (v001 Clevo 845MP 01540.00000) @ 0x1fefef2d
ACPI: BOOT (v001 PTLTD $SBFTBL$ 01540.00000) @ 0x1fefefa1
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=2_5_15 ro root=305 pci=usepirqmask
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1594.856 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3185.04 BogoMIPS
Memory: 516516k/523776k available (1297k kernel code, 6808k reserved, 
324k data, 248k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Thermal monitoring enabled
CPU#0: Thermal monitoring enabled
CPU: After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU: Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd9c0, last bus=2
PCI: Invalid ACPI-PCI IRQ routing table
ACPI: Bus Driver revision 20020404
ACPI: Core Subsystem revision 20020403
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00:00.00)
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC] (gpe 28)
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 5 for device 00:1f.1
PCI: Sharing IRQ 5 with 02:07.0
PCI: Found IRQ 9 for device 02:06.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states, 8 
throttling states)
ACPI: Thermal Zone [THM0] (56 C)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 8250
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
ATA/ATAPI driver v7.0.0
ATA: system bus speed 33MHz
ATA: Intel Corp. 82801CAM IDE U100 (8086:248a) on PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
Intel Corp. 82801CAM IDE U100: Could not enable PCI device.

lspci -vvx -i /usr/src/linux-2.5.15/drivers/pci/pci.ids

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
Latency: 0
Region 0: Memory at e9000000 (32-bit, prefetchable) [size=16M]
Capabilities: [e4] #09 [d104]
Capabilities: [a0] AGP version 2.0
Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW+ Rate=x1
00: 86 80 30 1a 06 01 90 20 04 00 00 06 00 00 00 00
10: 08 00 00 e9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 96
Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
I/O behind bridge: 00003000-00003fff
Memory behind bridge: e8100000-e81fffff
Prefetchable memory behind bridge: f0000000-f7ffffff
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 31 1a 07 01 a0 00 04 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) 
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 0
Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
I/O behind bridge: 00004000-00004fff
Memory behind bridge: e8200000-e82fffff
BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 00 42 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 22
20: 20 e8 20 e8 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
00: 86 80 8c 24 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 
8a [Master SecP PriP])
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 5
Region 0: I/O ports at <unassigned> [size=8]
Region 1: I/O ports at <unassigned> [size=4]
Region 2: I/O ports at <unassigned> [size=8]
Region 3: I/O ports at <unassigned> [size=4]
Region 4: I/O ports at 1860 [size=16]
Region 5: Memory at 20000000 (32-bit, non-prefetchable) [disabled] [size=1K]
00: 86 80 8a 24 05 00 80 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 00 00 20 00 00 00 00 58 15 00 56
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin B routed to IRQ 11
Region 4: I/O ports at 1100 [size=32]
00: 86 80 83 24 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
(rev 02)
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin B routed to IRQ 11
Region 0: I/O ports at 1c00 [size=256]
Region 1: I/O ports at 18c0 [size=64]
00: 86 80 85 24 05 00 80 02 02 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 
[Generic])
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin B routed to IRQ 11
Region 0: I/O ports at 2400 [size=256]
Region 1: I/O ports at 2000 [size=128]
00: 86 80 86 24 05 00 80 02 02 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M6 LW (prog-if 00 [VGA])
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR+ FastB2B+
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 11
Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
Region 1: I/O ports at 3000 [size=256]
Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
Expansion ROM at <unassigned> [disabled] [size=128K]
Capabilities: [58] AGP version 2.0
Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 57 4c 83 03 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 f0 01 30 00 00 00 00 10 e8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 08 00

02:04.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023 
(prog-if 10 [OHCI])
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (500ns min, 1000ns max), cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at e8204000 (32-bit, non-prefetchable) [size=2K]
Region 1: Memory at e8200000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [44] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 23 80 16 01 10 02 00 10 00 0c 08 40 00 00
10: 00 40 20 e8 00 00 20 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 04

02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (8000ns min, 16000ns max)
Interrupt: pin A routed to IRQ 9
Region 0: I/O ports at 4000 [size=256]
Region 1: Memory at e8204800 (32-bit, non-prefetchable) [size=256]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 01 90 02 10 00 00 02 00 40 00 00
10: 01 40 00 00 00 48 20 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 00 56
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 20 40

02:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 01)
Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 5
Region 0: Memory at e8205000 (32-bit, non-prefetchable) [disabled] [size=4K]
Bus: primary=02, secondary=03, subordinate=06, sec-latency=64
I/O window 0: 00000000-00000003 [disabled]
I/O window 1: 00000000-00000003 [disabled]
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
16-bit legacy interface ports at 0001
00: 4c 10 50 ac 00 00 10 02 01 00 07 06 00 40 02 00
10: 00 50 20 e8 a0 00 00 02 02 03 06 40 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 40 03
40: 58 15 00 56 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



