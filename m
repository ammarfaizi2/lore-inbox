Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSAKThI>; Fri, 11 Jan 2002 14:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290071AbSAKTg7>; Fri, 11 Jan 2002 14:36:59 -0500
Received: from 62-37-128-57.dialup.uni2.es ([62.37.128.57]:44928 "EHLO
	raul.dif.um.es") by vger.kernel.org with ESMTP id <S290070AbSAKTgv>;
	Fri, 11 Jan 2002 14:36:51 -0500
Subject: compaq presario 706 EA via 686a sound card
From: Raul Sanchez Sanchez <raul@dif.um.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1010777501.791.2.camel@raul>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Jan 2002 20:31:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I'm having problems with my sound card in my computer.It's a compaq
presario laptop 706EA with an onboard via 686a sound card.

I have tried with last kernel patches from Garzik with the kernel 2.4.17
and last alsa drivers ( 0.5.12a ).

I can hear the sound only with the higest volume in the mixer and my ear
put in the speaker. It's so much :(

Perhaps the problem isn't the soundcard because the computer have a
hardware sound volume controler, but i'm not sure. does anybody know
where is the problem and how can i solve it?



Thank you very much. 


my /proc/pci is this:



*****************************************************************************
*****************************************************************************
*****************************************************************************

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 128).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xec000000 [0xefffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 66).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0x1840 [0x184f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 26).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0x1800 [0x181f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 80).
      IRQ 5.
      I/O at 0x1000 [0x10ff].
      I/O at 0x1854 [0x1857].
      I/O at 0x1850 [0x1853].
  Bus  0, device   9, function  0:
    Communication controller: Conexant HSF 56k HSFi Modem (rev 1).
      IRQ 4.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe800ffff].
      I/O at 0x1858 [0x185f].
  Bus  0, device  10, function  0:
    CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xffbfe000 [0xffbfefff].
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x1400 [0x14ff].
      Non-prefetchable 32 bit memory at 0xe8010000 [0xe80100ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: PCI device 5333:8d02 (S3 Inc.) (rev 1).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xe8100000 [0xe817ffff].
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].


*****************************************************************************
*****************************************************************************
*****************************************************************************





and my dmesg output this:



*****************************************************************************
*****************************************************************************
*****************************************************************************

Linux version 2.4.17 (root@raul) (gcc version 2.95.4 20011006 (Debian
prerelease)) #7 Wed Jan 9 11:32:02 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux-2.4.17 ro root=303
Initializing CPU#0
Detected 996.571 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1985.74 BogoMIPS
Memory: 239204k/245760k available (1373k kernel code, 6100k reserved,
406k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
udf: registering filesystem
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully
loaded
Parsing
Methods:.............................................................................................................
109 Control Methods found and parsed (441 nodes total)
Parsing Methods:
0 Control Methods found and parsed (444 nodes total)
ACPI Namespace successfully loaded at root c030b2a0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode
successful
Executing device _INI methods:.....[ACPI Debug] String:
---------------------------- AC _STA
..evregion-0302 [21] Ev_address_space_dispa: Region handler: AE_ERROR
[System_memory]
Ps_execute: method failed - \_SB_.PCI0._INI (cee34468)
  nsinit-0351 [04] Ns_init_one_device    : \   /_SB_PCI0._INI failed:
AE_ERROR
......................................
45 Devices found: 45 _STA, 1 _INI
Completing Region and Field initialization:............
11/15 Regions, 1/1 Fields initialized (444 nodes total)
ACPI: Subsystem enabled
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
EC: found, GPE 6
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
evregion-0302 [25] Ev_address_space_dispa: Region handler: AE_ERROR
[System_memory]
 dswexec-0392 [16] Ds_exec_end_op        : [Store]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.BAT0._BIF (cee35ec8)
[ACPI Debug] String: ---------------------------- AC _STA
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2432/255/63,
UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139cp 10/100 PCI Ethernet driver v0.0.5 (Oct 19, 2001)
8139cp: pci dev 00:0b.0 (id 10ec:8139 rev 10) is not an 8139C+
compatible chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.22
PCI: Assigned IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf823000, 00:08:02:02:0b:a9,
IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 190M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xec000000
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0b.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0008, PCI irq11
Socket status: 30000006
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding Swap: 265064k swap-space (priority -1)
PCI: Found IRQ 11 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00:0b.0
PCI: Assigned IRQ 4 for device 00:09.0
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x378-0x37f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

*****************************************************************************
*****************************************************************************
*****************************************************************************

thank you very much


-- 
-----------------------------------------------
Raul Sanchez Sanchez             raul@dif.um.es
Centro de Calculo               
Facultad de Informatica    Tlf: +34 968 36 4827 
Universidad de Murcia      Fax: +34 968 36 4151
-----------------------------------------------
