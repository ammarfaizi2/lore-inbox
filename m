Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUF2GJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUF2GJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUF2GJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:09:25 -0400
Received: from av.isp.contactel.cz ([212.65.193.173]:6789 "EHLO
	av3.isp.contactel.cz") by vger.kernel.org with ESMTP
	id S265489AbUF2GJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:09:06 -0400
Date: Tue, 29 Jun 2004 08:09:00 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Silicon Image 3512 & seagate ST3120026AS in 2.4.27-rc2
Message-ID: <20040629060900.GA20895@kangaroo.instrat.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Operating-System: athlon i686 Linux-2.4.20-28.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Jeff,

  I have sil3512 controller and 2x Seagate ST3120026AS (yes, with mod15
problem...) discs. When i try some writes to disc sata_sil driver hangs.
Nothing ooops or something like this only following messages:
ata1: DMA timeout, stat 0x4
ata2: DMA timeout, stat 0x4
  I tried add this discs to sil_blacklist with SIL_QUIRK_MOD15WRITE,
tried your try4 patch and nothing helps.
  Any ideas?

  Best Regards,
Dave


Linux version 2.4.27-rc2 (dave@tiger) (gcc version 3.3.4 (Debian)) #1 Po čen 28 15:51:50 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f5300
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=/kernels/satabare.i/bzImage initrd=rescue.img load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=83000 ro root=/dev/ram SLACK_KERNEL=satabare.i 
Initializing CPU#0
Detected 1797.297 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 868552k/917504k available (1950k kernel code, 48564k reserved, 614k data, 144k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2200+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
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
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1797.3075 MHz.
..... host bus clock speed is 266.2676 MHz.
cpu: 0, clocks: 2662676, slice: 1331338
CPU0<T0:2662672,T1:1331328,D:6,S:1331338,C:2662676>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfaf70, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
PCI->APIC IRQ transform: (B2,I0,P0) -> 19
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 83000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: 00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-cdrom driver.
hda: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2744.800 MB/sec
   32regs    :  1846.800 MB/sec
   pIII_sse  :  5102.400 MB/sec
   pII_mmx   :  4213.200 MB/sec
   p5_mmx    :  5405.600 MB/sec
raid5: using function: pIII_sse (5102.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.8(17/11/2003)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 35644k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[df005000-df0057ff]  Max Packet=[2048]
r8169 Gigabit Ethernet driver 1.2 loaded
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf8875000, 00:0d:61:71:11:4b, IRQ 10
eth0: Auto-negotiation Enabled.
eth0: 100Mbps Full-duplex operation.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.2 to 64
ehci_hcd 00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 00:02.2: irq 11, pci mem f888e000
usb.c: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 00:02.2
ehci_hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 6 ports detected
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xf8896000, IRQ 5
usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
usb.c: new USB bus registered, assigned bus number 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d61000061eac5]
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xf8898000, IRQ 10
usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 16:10:39 Jun 28 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1: No raid array found
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xF88A4080 ctl 0xF88A408A bmdma 0xF88A4000 irq 11
ata2: SATA max UDMA/100 cmd 0xF88A40C0 ctl 0xF88A40CA bmdma 0xF88A4008 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/100
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
scsi2 : sata_sil
  Vendor: ATA       Model: ST3120026AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120026AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
Partition check:
 sda: sda1 sda2 < sda5 > sda3 sda4
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
 sdb: sdb1 sdb2 < sdb5 > sdb3 sdb4
SGI XFS with no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sd(8,1)
Starting XFS recovery on filesystem: sd(8,1) (dev: sd(8,1))
Ending XFS recovery on filesystem: sd(8,1) (dev: sd(8,1))
XFS mounting filesystem sd(8,17)
Starting XFS recovery on filesystem: sd(8,17) (dev: sd(8,17))
Ending XFS recovery on filesystem: sd(8,17) (dev: sd(8,17))
XFS mounting filesystem sd(8,5)
Starting XFS recovery on filesystem: sd(8,5) (dev: sd(8,5))
Ending XFS recovery on filesystem: sd(8,5) (dev: sd(8,5))
XFS mounting filesystem sd(8,21)
Starting XFS recovery on filesystem: sd(8,21) (dev: sd(8,21))
Ending XFS recovery on filesystem: sd(8,21) (dev: sd(8,21))
XFS mounting filesystem sd(8,4)
Starting XFS recovery on filesystem: sd(8,4) (dev: sd(8,4))
Ending XFS recovery on filesystem: sd(8,4) (dev: sd(8,4))
XFS mounting filesystem sd(8,20)
Ending clean XFS mount for filesystem: sd(8,20)
ata1: DMA timeout, stat 0x4
ata2: DMA timeout, stat 0x4
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
