Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTLaPsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbTLaPsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:48:36 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:41208 "HELO
	smtp.vnoc.murphx.net") by vger.kernel.org with SMTP id S265170AbTLaPsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:48:25 -0500
Message-ID: <3FF2EFF3.6010001@gadsdon.giointernet.co.uk>
Date: Wed, 31 Dec 2003 15:49:07 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031215
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc1-mm1 - ieee1394 broken again?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg boot output (tombstone at end):

Linux version 2.6.1-rc1-mm1 (root@xxx.xxx.com) (gcc version 3.3.2 
20031022 (Red Hat Linux 3.3.2-1)) #1 SMP Wed Dec 31 15:07:03 GMT 2003
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
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda2
current: c03dbba0
current->thread_info: c04a2000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 400.921 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 254568k/262144k available (2484k kernel code, 6820k reserved, 
1229k data, 184k init, 0k highmem)
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
per-CPU timeslice cutoff: 366.06 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 800.76 BogoMIPS
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1591.29 BogoMIPS).
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
..... CPU clock speed is 400.0833 MHz.
..... host bus clock speed is 66.0805 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
zapping low mappings.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031203
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
NTFS driver 2.1.5 [Flags: R/O].
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
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
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
I2O: Event thread created as pid 20
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
piix4-smbus 0000:00:07.3: Found 0000:00:07.3 device
registering 0-004c
registering 0-004d
registering 0-002d
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
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
[drm] Initialized mga 3.1.0 20021029 on minor 0
request_module: failed /sbin/modprobe -- char-major-162-0. error = 256
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[18] 
MMIO=[febfe800-febfefff]  Max Packet=[2048]
raw1394: /dev/raw1394 device initialized
blk: queue c1343200, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c1333e00, I/O limit 4095Mb (mask 0xffffffff)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[090050c50000046f]
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c028301e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP:    0060:[<c028301e>]    Not tainted VLI
EFLAGS: 00010282
EIP is at vt_ioctl+0x1e/0x1ec0
eax: 00000000   ebx: 00005401   ecx: bffffbec   edx: bffffbec
esi: c0283000   edi: cfb5b000   ebp: cf53b2c0   esp: cfb31eb0
ds: 007b   es: 007b   ss: 0068
Process rc (pid: 1467, threadinfo=cfb30000 task=cfb426c0)
Stack: cfb31f70 cffe6220 00000000 00000000 cf06ece0 cfd0c600 00000001 
cfb30000
        cf0354f0 cf036cc0 4f106e70 c01520df cf036cc0 cf9e44a0 4f106e70 
00000000
        cf0a7418 cf0354f0 00008802 cf036cc0 cf036ce0 cf9e44a0 cfb426c0 
c011beac
Call Trace:
  [<c01520df>] handle_mm_fault+0x10f/0x1c0
  [<c011beac>] do_page_fault+0x33c/0x530
  [<c0160564>] dentry_open+0x1e4/0x230
  [<c0283000>] vt_ioctl+0x0/0x1ec0
  [<c027d9a0>] tty_ioctl+0x480/0x590
  [<c01756a7>] sys_ioctl+0x117/0x2c0
  [<c036c59e>] sysenter_past_esp+0x43/0x65

Code: 8d e8 ff e9 6f ff ff ff 90 90 90 90 90 55 57 56 53 81 ec a8 00 00 
00 8b bc 24 bc 00 00 00 8b 9c 24 c4 00 00 00 8b 87 78 09 00 00 <8b> 30 
89 34 24 8b 04 b5 a0 e8 4e c0 89 44 24 48 e8 7d 6d 00 00

-- 
..................................
Robert Gadsdon
..................................
