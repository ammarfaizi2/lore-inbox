Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUKGBYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUKGBYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 20:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKGBYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 20:24:46 -0500
Received: from smtp06.web.de ([217.72.192.224]:59552 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S261507AbUKGBYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 20:24:31 -0500
Subject: [BUG] IDE, VIA VT8235, md5sum Input/Output error after CD burn.
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 07 Nov 2004 02:24:27 +0100
Message-Id: <1099790667.814.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I own a Shuttle AK39N Motherboard with a VIA VT8235 IDE onboard
controller and a NEC ND-1300A DVD-Burner connected to it. The hardware
is pretty much new.

Since 2.6.3 (could be the one or other version earlier or later I can't
really remember anymore because I am investigating this for quite some
months now) I realized that it's not possible to md5sum the device
anymore. Before that named version or even on 2.4.x it works like a
charm. When burning a CDRW you can md5sum the ISO and the device (as in
my case /dev/hdc) and you get the values spit out correctly and
matching.

But with more recent Linux versions this is not happening anymore. Even
reading back a burned CDRW to disk causes it to show errors on the last
written sectors and regardless if it's a CD or CDRW (even tried
different media, new ones, old ones etc.) it still does the same. But
burning the same media on 2.4.x or before 2.6.3 it does burn the stuff
correctly. Most of the time the data written on the CD does work and
doesn't cause any issues but the problem is as soon as you start trying
to put these burned CD's into another drive it then gives read/write
errors because the media can't correctly load (read data or even show a
dir listning - I do assume this is because of the bad written last
sectors). Writing that CD with 2.4.x again (or the named earlier 2.6.x)
causes the data to be written correctly and also read correctly on the
other system.

I don't think that I have selected some spectacular values in my .config
file so I don't really know. After some research on the net I saw people
reporting similar issues with 2.6.x. (Someone mentioned readahead
changes in the Kernel). Anyways I seriously doubt this is a
Hardwarefailure because it works with 2.4.x.

I have attached a dmesg output and the .config snipplet. In case someone
has an idea what's going on and howto solve this I would be thankful to
hear about it.

Please CC to me since I am not subscribed on this List.

greetings







Linux version 2.6.10-rc1-bk16 (root@ulixys) (gcc version 3.4.1 20040618
(prerelease)) #3 Sun Nov 7 01:34:22 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5510
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:10 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=DEFAULT ro root=301
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1915.902 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515372k/524224k available (2322k kernel code, 8316k reserved,
522k data, 356k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3768.32 BogoMIPS (lpj=1884160)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 18
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with no debug enabled
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies
Inc RV280 [Radeon 9200 SE]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and
petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC35L060AVV207-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-1300A, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 80418240 sectors (41174 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA
(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 19, pci mem 0xe0104000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct
2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xe000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xe400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xe800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Logitech Wheel Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
UDF-fs: No VRS found
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 356k freed
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe0820000, 00:30:84:28:5b:e1, IRQ 17
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 895C
lp0: using parport0 (polling).
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set


