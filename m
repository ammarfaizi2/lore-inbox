Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136545AbRAHCCL>; Sun, 7 Jan 2001 21:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136557AbRAHCCC>; Sun, 7 Jan 2001 21:02:02 -0500
Received: from mail4.mia.bellsouth.net ([205.152.144.16]:19412 "EHLO
	mail4.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S136545AbRAHCBw>; Sun, 7 Jan 2001 21:01:52 -0500
Message-ID: <3A58D962.FAEBBAC7@bellsouth.net>
Date: Sun, 07 Jan 2001 21:02:26 +0000
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
In-Reply-To: <20010107122800.A636@kantaka.co.uk> <93avg9$rlk$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Could anybody with a VIA chip who has the energy please do something for
> me:
>  - enable DEBUG in arch/i386/kernel/pci-i386.h
>  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
>    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
>    numbers for them are 1106:0586 and 1106:0596, I think)
>  - do a cat /proc/pci
> 

Does this help.
dmesg
Linux version 2.4.0 (root@home1) (gcc version pgcc-2.95.2 19991024 (release)) #2 Sun Jan 7 11:22:02 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000f800 @ 0000000007ff0800 (ACPI data)
 BIOS-e820: 0000000000000800 @ 0000000007ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Local APIC is hardware-disabled.
mapped APIC to ffffe000 (01223000)
Kernel command line: BOOT_IMAGE=linux ro root=804 ramdisk_size=8192k mem=131072K apm=on,power-off mpu401=0x300 sb=0x220,5,1,5
adlib=0x300 parport=0x378,7 lp=parport0 penguin=1 pirq=0 nohlt
PIRQ redirection, working around broken MP-BIOS.
... PIRQ0 -> IRQ 0
Initializing CPU#0
Detected 400.916 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 126424k/131072k available (1137k kernel code, 4260k reserved, 432k data, 240k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
25 structures occupying 843 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 06/09/99
System Vendor: System Manufacturer.
Product Name: Product Name.
Version SYS-xxxxxx.
Serial Number Serial Number xxxxxx.
Board Vendor: First International Computer, Inc..
Board Name: PA-2013.
Board Version: PCB 2.X.
Asset Tag: Asset Tag Number xxxxxx.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
hda: ATAPI CDROM, ATAPI CDROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 212X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
8139too Fast Ethernet driver 0.9.13 loaded
IRQ routing conflict in pirq table! Try 'pci=autoirq'
eth0: RealTek RTL8139 Fast Ethernet at 0xc8800000, 00:e0:7d:72:07:43, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139A'
eth0: Setting full-duplex based on MII #32 link partner ability of 41e1.]


lspci --xxvvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
00: 06 11 98 05 06 00 90 02 04 00 00 06 00 10 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e4000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c0 c0 00 00
20: 00 e8 f0 e9 00 e4 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
00: 06 11 86 05 8f 00 00 02 47 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at e400 [size=16]
00: 06 11 71 05 07 00 80 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10) (prog-if 00 [Normal decode])
        !!! Header type 00 doesn't match class code 0604
00: 06 11 40 30 00 00 80 02 10 00 04 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 64 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at eb002000 (32-bit, non-prefetchable) [size=256]
00: ec 10 39 81 07 00 80 02 10 00 00 02 00 40 00 00
10: 01 ec 00 00 00 20 00 eb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 20 40



cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 71).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xe400 [0xe40f].
  Bus  0, device   7, function  3:
    PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device   9, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 4).
      IRQ 15.
      Master Capable.  Latency=144.  Min Gnt=17.Max Lat=64.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xeb001000 [0xeb0010ff].
      Non-prefetchable 32 bit memory at 0xeb000000 [0xeb000fff].
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xeb002000 [0xeb0020ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage 128 PF (rev 0).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xe9000000 [0xe9003fff].
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
