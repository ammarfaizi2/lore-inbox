Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUBIRQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUBIRQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:16:47 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:22264 "HELO
	smtp.vnoc.murphx.net") by vger.kernel.org with SMTP id S265270AbUBIRQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:16:35 -0500
Message-ID: <4027C18E.1070104@gadsdon.giointernet.co.uk>
Date: Mon, 09 Feb 2004 17:21:18 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040206
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1 - more 'badness'...
References: <fa.gdu05gh.1t3sqj9@ifi.uio.no>
In-Reply-To: <fa.gdu05gh.1t3sqj9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.6.3-rc1-mm1 I get:
.......
Badness in kobject_get at lib/kobject.c:431
.......
etc:
  as follows:

Linux version 2.6.3-rc1-mm1 (root@xxxxxxxxxxxxx) (gcc version 3.3.2 
20031022 (Red Hat Linux 3.3.2-1)) #1 SMP Mon Feb 9 16:29:52 GMT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
found SMP MP-table at 000fb560
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65536
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 61440 pages, LIFO batch:15
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI disabled because your bios is from 99 and too old
You can enable it with acpi=force
Intel MultiProcessor Specification v1.1
     Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440GX        APIC at: 0xFEE00000
Processor #0 6:6 APIC version 17
Processor #1 6:6 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
current: c03bdba0
current->thread_info: c048e000
Initializing CPU#0
Kernel command line: ro root=/dev/hda2
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 401.037 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 254640k/262144k available (2361k kernel code, 6744k reserved, 
1270k data, 176k init, 0k highmem)
Calibrating delay loop... 790.52 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.15 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 798.72 BogoMIPS
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1589.24 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22, 
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 001 01  0    0    0   0   0    1    1    51
  06 001 01  0    0    0   0   0    1    1    59
  07 001 01  0    0    0   0   0    1    1    61
  08 001 01  0    0    0   0   0    1    1    69
  09 000 00  1    0    0   0   0    0    0    00
  0a 000 00  1    0    0   0   0    0    0    00
  0b 000 00  1    0    0   0   0    0    0    00
  0c 001 01  0    0    0   0   0    1    1    71
  0d 001 01  0    0    0   0   0    1    1    79
  0e 001 01  0    0    0   0   0    1    1    81
  0f 001 01  0    0    0   0   0    1    1    89
  10 001 01  1    1    0   1   0    1    1    91
  11 000 00  1    0    0   0   0    0    0    00
  12 001 01  1    1    0   1   0    1    1    99
  13 001 01  1    1    0   1   0    1    1    A1
  14 000 00  1    0    0   0   0    0    0    00
  15 000 00  1    0    0   0   0    0    0    00
  16 000 00  1    0    0   0   0    0    0    00
  17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 400.0867 MHz.
..... host bus clock speed is 66.0811 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 1 CPUs
zapping low mappings.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I18,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P0) -> 19
PCI->APIC IRQ transform: (B0,I20,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Starting balanced_irq
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.6 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 Gold'
isapnp: 1 Plug & Play card detected total
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL SE6.4A, ATA DISK drive
hdb: WDC AC28400R, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/80KiB Cache, CHS=13328/15/63, UDMA(33)
  hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
  hdb: hdb1 hdb2
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 18
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
piix4-smbus 0000:00:07.3: Found 0000:00:07.3 device
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 19, io base 0000ef80
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 514040k swap on /dev/hdb1.  Priority:-1 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox G400/G450 (AGP)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[18] 
MMIO=[febfe800-febfefff]  Max Packet=[2048]
raw1394: /dev/raw1394 device initialized
blk: queue c1322c00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c1322800, I/O limit 4095Mb (mask 0xffffffff)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[090050c50000046f]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
  [<c0239cd6>] kobject_get+0x36/0x40
  [<c027cff3>] get_device+0x13/0x20
  [<c027dc19>] bus_for_each_dev+0x59/0xc0
  [<d0939355>] nodemgr_node_probe+0x55/0x120 [ieee1394]
  [<d0939200>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<d0939748>] nodemgr_host_thread+0x168/0x190 [ieee1394]
  [<d09395e0>] nodemgr_host_thread+0x0/0x190 [ieee1394]
  [<c010ac15>] kernel_thread_helper+0x5/0x10

Unable to handle kernel paging request at virtual address 53565755
  printing eip:
53565755
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP:    0060:[<53565755>]    Not tainted VLI
EFLAGS: 00010206
EIP is at 0x53565755
eax: 53565755   ebx: d09680c8   ecx: cfa45f9c   edx: 00000000
esi: d0938ca0   edi: 00000000   ebp: d0937a80   esp: cfa45f40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 1114, threadinfo=cfa44000 task=cf4f2d00)
Stack: c0239d63 d09680c8 d09680a4 d09680ac d0968000 cf4aec44 c027dc2f 
d09680c8
        d09680a4 cfa45f9c d09680a4 d096804c 00000000 cf4aec3c cfa45f9c 
cf109498
        cfa45f9c d0939355 d0968000 cf4aec3c cfa45f9c d0939200 cefa8000 
cf109498
Call Trace:
  [<c0239d63>] kobject_cleanup+0x83/0x90
  [<c027dc2f>] bus_for_each_dev+0x6f/0xc0
  [<d0939355>] nodemgr_node_probe+0x55/0x120 [ieee1394]
  [<d0939200>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<d0939748>] nodemgr_host_thread+0x168/0x190 [ieee1394]
  [<d09395e0>] nodemgr_host_thread+0x0/0x190 [ieee1394]
  [<c010ac15>] kernel_thread_helper+0x5/0x10

Code:  Bad EIP value.
  ip_tables: (C) 2000-2002 Netfilter core team
e100: Intel(R) PRO/100 Network Driver, 3.0.13_dev
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xfd5ff000, irq 19, MAC addr 08:00:09:DC:E1:1A
ip_tables: (C) 2000-2002 Netfilter core team
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
pnp: Device 00:01.00 activated.
pnp: Device 00:01.02 activated.


Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
> 
> 
> - NFSD update
> 
> - MD update
> 
> - Added Randy's include/linux/syscalls.h work, to address a pet peeve.
> 
> - Various fixes
> 
> - Added early printk for ia32.  It simply does #include "x86_64's version".
> 
> - I'll probably drop the CPU hotplug patches next time.  They've been
>   tested and they now appear to be obsolete.
> 
> - Unless suddenly persuaded otherwise I shall also drop the enhanced ia32
>   CPU-type selection patches (retaining pentium-M support).  Sorry Adrian,
>   but they do not seem to have sufficient value, given the general
>   intrusiveness and patch footprint.
> 
