Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVFWBgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVFWBgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVFWBfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:35:10 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:54020 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S261928AbVFWB3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:29:07 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAA79@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'peter@pantasys.com'" <peter@pantasys.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: CK804 APIC and PCI Express to PCI Bridge problems
Date: Wed, 22 Jun 2005 20:24:31 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,
  Sorry for the delay in posting the dmesg. I am sure you are already well
one your way to discovering the problems with this APIC and board thus far.
If it will help , the following is the kernel dmesg:

ootdata ok (command line is root=/dev/hda2)
Linux version 2.6.12-gentoo (root@AjaX.hopto.org) (gcc version 3.4.4 (Gentoo
3.4
.4, ssp-3.4.4-1.0, pie-8.7.8)) #1 SMP Wed Jun 22 18:56:24 Local time zone
must b
e set--see zic
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: Unable to locate RSDP
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Skipping disabled node 1
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
Processor #0 15:5 APIC version 17
Processor #1 15:5 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Setting APIC routing to flat
Processors: 2
Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=/dev/hda2
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1428.288 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1024016k/1048576k available (3309k kernel code, 0k reserved, 1486k
data,
 596k init)
Calibrating delay loop... 2826.24 BogoMIPS (lpj=1413120)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using IO-APIC 2
..MP-BIOS bug: 8254 timer not connected to IO-APIC
works.
Using local APIC timer interrupts.
Detected 12.752 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81003ff13f58
Initializing CPU#1
Calibrating delay loop... 2850.81 BogoMIPS (lpj=1425408)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 08
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
  domain 1: span 03
   groups: 01 02
   domain 2: span 03
    groups: 03
CPU1 attaching sched-domain:
 domain 0: span 02
  groups: 02
  domain 1: span 03
   groups: 02 01
   domain 2: span 03
    groups: 03
CPU 1: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 843 cycles)
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:04:00.0
PCI->APIC IRQ transform: 0000:00:01.1[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 12
PCI->APIC IRQ transform: 0000:00:02.1[B] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 9
PCI->APIC IRQ transform: 0000:00:07.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:08.0[A] -> IRQ 12
PCI->APIC IRQ transform: 0000:01:08.0[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:04:00.0[A] -> IRQ 3
PCI: Cannot allocate resource region 0 of device 0000:02:00.0
PCI: Cannot allocate resource region 3 of device 0000:04:00.0
PCI: Failed to allocate mem resource #3:1000000@fc000000 for 0000:04:00.0
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
inotify device minor=63
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver 2.1.22 [Flags: R/W].
JFS: nTxBlock = 8002, nTxLock = 64023
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Real Time Clock Driver v1.12
w83877f_wdt: WDT driver for W83877F initialised. timeout=30 sec (nowayout=0)
WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
w83627hf WDT: cannot register miscdev on minor=130 (err=-16)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
tg3.c:v3.31 (June 8, 2005)
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit)
10/100/1
000BaseT Ethernet 00:11:d8:d3:06:b5
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth0: dma_rwctrl[76180000]
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xfa00-0xfa07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfa08-0xfa0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1200BB-00CAA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: DVD+RW RW5240, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.11 loaded.
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[fe8ff000-fe8ff7ff]
Max
Packet=[2048]
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
usbmon: debugs is not available
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: nVidia Corporation CK804 USB Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 11, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation CK804 USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 12, io mem 0xfeaff000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v2.2
sl811: driver sl811-hcd, 19 May 2005
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-2: new low speed USB device using ohci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on
usb-0000:00:02.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39
2005 UTC).
PCI: Setting latency timer of device 0000:00:04.0 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
intel8x0_measure_ac97_clock: measured 49624 usecs
intel8x0: clocking to 46858
ALSA device list:
  #0: NVidia CK804 with ALC850 at 0xfeafd000, irq 9
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0,
recover
ed transactions 489124 to 489138
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 185 and revoked
11/16 b
locks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 596k freed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000277d67]
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda2, internal journal
nvidia: module license 'NVIDIA' taints kernel.
PCI: Setting latency timer of device 0000:04:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7664  Wed May 25
22:
14:12 PDT 2005
devfs_mk_dev: could not append to parent for vcc/2
devfs_mk_dev: could not append to parent for vcc/a2
devfs_mk_dev: could not append to parent for vcc/4
devfs_mk_dev: could not append to parent for vcc/a4
devfs_mk_dev: could not append to parent for vcc/5
devfs_mk_dev: could not append to parent for vcc/a5
devfs_mk_dev: could not append to parent for vcc/8
devfs_mk_dev: could not append to parent for vcc/9
devfs_mk_dev: could not append to parent for vcc/a9
devfs_mk_dev: could not append to parent for vcc/10
devfs_mk_dev: could not append to parent for vcc/11
devfs_mk_dev: could not append to parent for vcc/a11
devfs_mk_dev: could not append to parent for vcc/3
devfs_mk_dev: could not append to parent for vcc/a3
devfs_mk_dev: could not append to parent for vcc/6
devfs_mk_dev: could not append to parent for vcc/a6
devfs_mk_dev: could not append to parent for vcc/7
devfs_mk_dev: could not append to parent for vcc/a7
devfs_mk_dev: could not append to parent for vcc/a8
devfs_mk_dev: could not append to parent for vcc/a10
devfs_mk_dev: could not append to parent for vcc/1
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
eth0: no IPv6 routers present

   Of particular interest to me are the "pcie_portdrv_probe->Dev[005d:10de]
has invalid IRQ. Check vendor BIOS", and the fact that if my ACPI is
currently disbaled. If I enable it I get a soft_lockup exception no matter
what ACPI options I compile into the kernel.

Any help you could provide would be gratly appreciated.

CheerS,

-Brian
