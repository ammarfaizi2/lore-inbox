Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbTAXGkW>; Fri, 24 Jan 2003 01:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbTAXGkV>; Fri, 24 Jan 2003 01:40:21 -0500
Received: from fmr02.intel.com ([192.55.52.25]:24032 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267571AbTAXGkN>; Fri, 24 Jan 2003 01:40:13 -0500
Subject: [BUG] e100 driver fails to initialize the hardware after kernel
	bootup through kexec
From: Michael Fu <michael.fu@linux.co.intel.com>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1042450072.1744.75.camel@aminoacin.sh.intel.com>
References: <1042450072.1744.75.camel@aminoacin.sh.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043390954.892.10.camel@aminoacin.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 14:49:14 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After kernel was bootup through kexec command, the NIC failed to
initialize. The 2.5.52 kernel was patched with kexec and kexec-hwfix
patch.

the following was is the dmesg output:


Linux version 2.5.52 (root@aminoacin) (gcc version 2.96 20000731 (Red
Hat Linux 7.1 2.96-81)) #1 SMP Fri Jan 24 14:17:58 CST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000000ff87000 (usable)
 BIOS-e820: 000000000ff87000 - 000000000ffa6000 (ACPI data)
 BIOS-e820: 000000000ffa6000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65415
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61319 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 DELL                       ) @ 0x000fd730
ACPI: RSDT (v001 DELL    GX400   00000.00005) @ 0x000fd744
ACPI: FADT (v001 DELL    GX400   00000.00005) @ 0x000fd774
ACPI: SSDT (v001   DELL    st_ex 00000.04096) @ 0xfffe7279
ACPI: BOOT (v001 DELL    GX400   00000.00005) @ 0x000fd7e8
ACPI: DSDT (v001   DELL    dt_ex 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: auto ro root=/dev/hda5
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1993.714 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3932.16 BogoMIPS
Memory: 253164k/261660k available (2804k kernel code, 7792k reserved,
1539k data, 140k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 02
per-CPU timeslice cutoff: 731.31 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=2
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20021212
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:.............................................................................................................
Table [DSDT] - 297 Objects with 29 Devices 109 Methods 19 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c05b2b7c
evxfevnt-0063 [04] Acpi_enable           : System is already in ACPI
mode
   evgpe-0259: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0259: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:.............................
29 Devices found containing: 29 _STA, 3 _INI methods
Completing Region/Field/Buffer/Package
initialization:....................................
Initialized 13/19 Regions 0/0 Fields 10/10 Buffers 13/13 Packages (304
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Linux Plug and Play Support v0.93 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
SCSI subsystem driver Revision: 1.00
device class 'scsi-host': registering
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(08)
parport0: assign_addrs: aa5500ff(08)
parport0: cpp_daisy: aa5500ff(08)
parport0: assign_addrs: aa5500ff(08)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
i810_rng: RNG not detected
Linux agpgart interface v1.0 (c) Dave Jones
agpgart: Detected Intel i850 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 1.0 on Intel i850 @ 0xf8000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Intel(R) PRO/100 Network Driver - version 2.1.24-k2
Copyright (c) 2002 Intel Corporation






PCI: Enabling device 02:09.0 (0000 -> 0003)
PCI: Setting latency timer of device 02:09.0 to 64
e100: selftest timeout
e100: Failed to initialize, instance #0






Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG CD-ROM SC-148C, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for SAMSUNG CD-ROM SC-148C
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/1916KiB Cache, CHS=77545/16/63,
UDMA(100)
 hda: hda1 hda2 < hda5 hda6 >
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
scsi HBA driver <NULL> didn't set max_sectors, please fix the template
scsi HBA driver Qlogic ISP 1280/12160 didn't set max_sectors, please fix
the template
request_module[scsi_hostadapter]: not ready
request_module[scsi_hostadapter]: not ready
request_module[scsi_hostadapter]: not ready
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10
19:48:18 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 41138
ALSA device list:
  #0: Intel 82801BA-ICH2 at 0xd800, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 140k freed
Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?



I doubt this is a bug in E100 actually.
-- 
Michael Fu <michael.fu@linux.intel.com>
Not speaking for Intel, opinions are my own

