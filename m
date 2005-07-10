Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVGJNgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVGJNgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 09:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVGJNgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 09:36:24 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:9446 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261940AbVGJNgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 09:36:23 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.12 - USB Mouse not detected
Date: Sun, 10 Jul 2005 09:36:23 -0400
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200507100936.23705.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beginning 2.6.12 my Wireless USB Mouse is not detected in the first attempt - 
Meaning if I boot the machine with the mouse connected, it's not detected 
until I disconnect the mouse and then reconnect it. It works fine after the 
disconnect-reconnect cycle. Looking at the dmesg, it seems that at first time 
it forgets to register the hiddev driver - mysteriously, it remembers the 
second time.

And No - the mother of all solutions to USB problems - usb-handoff doesnt make 
a difference ;)


dmesg output 
==========
Bootdata ok (command line is root=/dev/ram0 init=/linuxrc ramdisk=8192 
real_root=/dev/hda3 vga=0x317 psmouse.proto=imps)
Linux version 2.6.12-gentoo-r4 (root@livecd) (gcc version 3.4.3 20041125 
(Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #1 Fri Jul 8 13:33:55 EDT 
2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff70000 (usable)
 BIOS-e820: 000000002ff70000 - 000000002ff7f000 (ACPI data)
 BIOS-e820: 000000002ff7f000 - 000000002ff80000 (ACPI NVS)
 BIOS-e820: 000000002ff80000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f7240
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 
0x000000002ff7a87e
ACPI: FADT (v001 NVIDIA CK8      0x06040000 PTL_ 0x000f4240) @ 
0x000000002ff7ee13
ACPI: MADT (v001 NVIDIA NV_APIC_ 0x06040000  LTP 0x00000000) @ 
0x000000002ff7ee87
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 
0x000000002ff7eee1
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 
0x000000002ff7ef09
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
No mptable found.
On node 0 totalpages: 196464
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192368 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 30000000:cff80000)
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/ram0 init=/linuxrc ramdisk=8192 
real_root=/dev/hda3 vga=0x317 psmouse.proto=imps
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 797.949 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 766120k/785856k available (3293k kernel code, 19032k reserved, 1407k 
data, 204k init)
Calibrating delay loop... 1576.96 BogoMIPS (lpj=788480)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC timer interrupts.
Detected 12.467 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 33)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 18 19) *0
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 18 19) *0
ACPI: PCI Interrupt Link [LNK3] (IRQs 17) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 18 19) *0
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
Simple Boot Flag at 0x37 set to 0x1
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
inotify device minor=63
Squashfs 2.1 (released 2004/12/10) (C) 2002-2004 Phillip Lougher
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
JFS: nTxBlock = 5987, nTxLock = 47902
SGI XFS with ACLs, large block/inode numbers, no debug enabled
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
vesafb: framebuffer at 0xf0000000, mapped to 0xffffc20000500000, using 3072k, 
total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (29 C)
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LMCI] -> GSI 22 (level, low) -> 
IRQ 22
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
Losing some ticks... checking if CPU frequency changed.
    ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio4
hda: FUJITSU MHT2060AT PL, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
usbmon: debugs is not available
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  2440.000 MB/sec
raid5: using function: generic_sse (2440.000 MB/sec)
raid6: int64x1    664 MB/s
raid6: int64x2    945 MB/s
raid6: int64x4    996 MB/s
raid6: int64x8    687 MB/s
raid6: sse2x1     628 MB/s
raid6: sse2x2     960 MB/s
raid6: sse2x4    1179 MB/s
raid6: using algorithm sse2x4 (1179 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 
10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80542120(lo)
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0x0, vid 0x12
ACPI wakeup devices: 
USB0 USB1 USB2 PS2K PS2M MAC0 
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 21 (level, low) -> 
IRQ 21
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 21, io mem 0xe0004000
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:00:02.0 (0004 -> 0006)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 20 (level, low) -> 
IRQ 20
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 20, io mem 0xe0000000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
PCI: Enabling device 0000:00:02.1 (0004 -> 0006)
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 22 (level, low) -> 
IRQ 22
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 22, io mem 0xe0001000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK1] -> GSI 19 (level, low) -> 
IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[e0108000-e01087ff]  
Max Packet=[2048]
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
libata version 1.11 loaded.
usb 3-1: new low speed USB device using ohci_hcd and address 2
ReiserFS: hda3: warning: sh-2021: reiserfs_fill_super: can not find reiserfs 
on hda3
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[553f0200553f0200]
eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
eth1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 18
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNK2] -> GSI 18 (level, low) -> 
IRQ 18
eth1: RealTek RTL8139 at 0xffffc20000890800, 00:0f:b0:70:49:28, IRQ 18
eth1:  Identified 8139 chip type 'RTL-8101'
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNK5] -> GSI 16 (level, low) -> 
IRQ 16
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 
11:43:48 PST 2004
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 21 (level, low) -> 
IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
eth1: link up, 10Mbps, half-duplex, lpa 0x0000
intel8x0_measure_ac97_clock: measured 49438 usecs
intel8x0: clocking to 47461
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
eth1: no IPv6 routers present
usb 3-1: USB disconnect, address 2
ohci_hcd 0000:00:02.1: wakeup
usb 3-1: new low speed USB device using ohci_hcd and address 3
usbcore: registered new driver hiddev
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 1.0A] 
on usb-0000:00:02.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
