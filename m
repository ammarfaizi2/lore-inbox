Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVLHNyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVLHNyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLHNyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:54:10 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:65514 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1751184AbVLHNyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:54:08 -0500
Subject: Re: [PATCH] x86_64: Display HPET timer option
From: Erwin Rol <mailinglists@erwinrol.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201211848.GE997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
	 <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
	 <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
	 <20051201204339.GC997@wotan.suse.de>
	 <1133471197.3604.3.camel@xpc.home.erwinrol.com>
	 <20051201211848.GE997@wotan.suse.de>
Content-Type: multipart/mixed; boundary="=-F8+s2J2sN4j4PCWHEbR/"
Date: Thu, 08 Dec 2005 14:53:45 +0100
Message-Id: <1134050026.3576.9.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 (2.5.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F8+s2J2sN4j4PCWHEbR/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Andi,

bit late but here is the info (or at least part of), since I don't have
a serial port on the computer I need to write down the panic info and
than mail it, so I only wrote down what i thought was important. If you
need other info from the panic let me know.

The NMI watchdog panic give me the following info (when nmi watchdog is
off it just hangs for ever)

RIP: .... hpet_alloc + 882

Call Trace: late_hpet_init + 171
            genl_init + 111
            init + 541


uname -a
Linux xpc.home.erwinrol.com 2.6.14-1.1743_FC5 #1 SMP Wed Dec 7 13:49:22
EST 2005 x86_64 x86_64 x86_64 GNU/Linux

When there is a hang there is no output in the log files, so the dmesg
is the output of nohpet.

- Erwin


On Thu, 2005-12-01 at 22:18 +0100, Andi Kleen wrote:
> On Thu, Dec 01, 2005 at 10:06:37PM +0100, Erwin Rol wrote:
> > On Thu, 2005-12-01 at 21:43 +0100, Andi Kleen wrote:
> > > On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> > > > On Thu, 1 Dec 2005, Linus Torvalds wrote:
> > > > 
> > > > > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > > > > >
> > > > > > Currently the HPET timer option isn't visible in menuconfig.
> > > > > 
> > > > > Do you want it to?
> > > > > 
> > > > > Why would you ever compile it out?
> > > > 
> > > > For timer testing purposes i sometimes would like not to use the HPET. 
> > > > Would a runtime switch be preferred?
> > > 
> > > nohpet already exists.
> > > 
> > 
> > And luckily it does cause without "nohpet" i can't boot my shuttle
> > ST20G5, the NMI watchdog kills it because ti hangs when initializing the
> > hpet. If the nmi watchdog is off it just hangs for ever. 
> 
> Can you give details on the machine? lspci, dmidecode, acpidmp output,
> boot log from the hang case?
> 
> Then perhaps it can be blacklisted or the failure otherwise avoided.
> 
> [Looks like I finally need to add DMI decode support to x86-64 too :-/]
> 
> -Andi
> 
> 

--=-F8+s2J2sN4j4PCWHEbR/
Content-Disposition: attachment; filename=dmesg_output.txt
Content-Type: text/plain; name=dmesg_output.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

Bootdata ok (command line is ro root=LABEL=/ nohpet  hda=ide-cdrom)
Linux version 2.6.14-1.1743_FC5 (bhcompile@hs20-bc1-1.build.redhat.com) (gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)) #1 SMP Wed Dec 7 13:49:22 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007fef3000 (ACPI NVS)
 BIOS-e820: 000000007fef3000 - 000000007ff00000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 XPC                                   ) @ 0x00000000000f7e50
ACPI: RSDT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef3040
ACPI: FADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fef74c0
ACPI: HPET (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000098) @ 0x000000007fef75c0
ACPI: MCFG (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef7640
ACPI: MADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef7400
ACPI: DSDT (v001 XPC     ST20V10 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000007fef0000
Using 31 for the hash shift.
Using node hash shift of 31
Bootmem setup node 0 0000000000000000-000000007fef0000
On node 0 totalpages: 513318
  DMA zone: 2537 pages, LIFO batch:0
  DMA32 zone: 510781 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0x10b9a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ff00000:60100000)
Checking aperture...
CPU 0: aperture @ 50000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
SMP: Allowing 2 CPUs, 1 hotplug CPUs
Built 1 zonelists
Kernel command line: ro root=LABEL=/ nohpet  hda=ide-cdrom
ide_setup: hda=ide-cdrom
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1808.748 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2048968k/2096064k available (2493k kernel code, 46704k reserved, 1671k data, 232k init)
Calibrating delay using timer specific routine.. 3623.84 BogoMIPS (lpj=7247689)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.560 MHz APIC timer.
Brought up 1 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
    ACPI-0339: *** Error: Looking up [\_SB_.PCI0.LNKC] in namespace, AE_NOT_FOUND
search_node ffff81007fe80b88 start_node ffff81007fe80b88 return_node 0000000000000000
    ACPI-0339: *** Error: Looking up [\_SB_.PCI0.LNKB] in namespace, AE_NOT_FOUND
search_node ffff81007fe8a4a8 start_node ffff81007fe8a4a8 return_node 0000000000000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 4000-403f claimed by ali7101 ACPI
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2PB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK7] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNK9] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: dfa00000-dfafffff
  PREFETCH window: dc000000-ddffffff
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: dfe00000-dfefffff
  PREFETCH window: dfd00000-dfdfffff
PCI: Bridge: 0000:00:19.0
  IO window: c000-cfff
  MEM window: dfc00000-dfcfffff
  PREFETCH window: dfb00000-dfbfffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:19.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1134052065.508:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key DF64C97637BAD272
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[5a34:1002] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie01]
PCI: Setting latency timer of device 0000:00:06.0 to 64
pcie_portdrv_probe->Dev[5a38:1002] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie01]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (45 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:1f.0
GSI 16 sharing vector 0xC1 and IRQ 16
ACPI: PCI Interrupt 0000:00:1f.0[A] -> GSI 19 (level, low) -> IRQ 193
ALI15X3: chipset revision 199
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8880-0x8887, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8888-0x888f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PIONEER DVD-RW DVR-109, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x6
ACPI wakeup devices: 
P2PB PES1 PES2 USB0 USB1 USB2 USB3 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 232k freed
Write protecting the kernel read-only data: 875k
SCSI subsystem initialized
libata version 1.20 loaded.
sata_uli 0000:00:1f.1: version 0.5
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 193
ata1: SATA max UDMA/133 cmd 0xFD00 ctl 0xFC02 bmdma 0xF900 irq 193
ata2: SATA max UDMA/133 cmd 0xFB00 ctl 0xFA02 bmdma 0xF908 irq 193
ata3: SATA max UDMA/133 cmd 0xFD08 ctl 0xFC06 bmdma 0xF910 irq 193
ata4: SATA max UDMA/133 cmd 0xFB08 ctl 0xFA06 bmdma 0xF918 irq 193
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:007f
ata1: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_uli
input: AT Translated Set 2 keyboard as /class/input/input0
ata2: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:007f
ata2: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_uli
ata3: no device found (phy stat 00000000)
scsi2 : sata_uli
ata4: no device found (phy stat 00000000)
scsi3 : sata_uli
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: Attached scsi disk sdb
md: raid0 personality registered as nr 2
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb4 ...
md:  adding sdb4 ...
md:  adding sda4 ...
md: created md0
md: bind<sda4>
md: bind<sdb4>
md: running: <sdb4><sda4>
md0: setting max_sectors to 512, segment boundary to 131071
raid0: looking at sdb4
raid0:   comparing sdb4(47439872) with sdb4(47439872)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda4
raid0:   comparing sda4(47439872) with sdb4(47439872)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 94879744 blocks.
raid0 : conf->hash_spacing is 94879744 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: md0: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 8814648
EXT3-fs: md0: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 986 types, 99 bools
security:  55 classes, 14026 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev md0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
GSI 17 sharing vector 0xC9 and IRQ 17
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 18 (level, low) -> IRQ 201
ohci_hcd 0000:00:1c.0: OHCI Host Controller
ohci_hcd 0000:00:1c.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:1c.0: irq 201, io mem 0xdffff000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 18 (level, low) -> IRQ 201
ohci_hcd 0000:00:1c.1: OHCI Host Controller
ohci_hcd 0000:00:1c.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:1c.1: irq 201, io mem 0xdfffe000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 201
ohci_hcd 0000:00:1c.2: OHCI Host Controller
ohci_hcd 0000:00:1c.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:1c.2: irq 201, io mem 0xdfffd000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 1-2: new low speed USB device using ohci_hcd and address 2
GSI 18 sharing vector 0xD1 and IRQ 18
ACPI: PCI Interrupt 0000:00:1d.0[C] -> GSI 21 (level, low) -> IRQ 209
GSI 19 sharing vector 0xD9 and IRQ 19
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 217
ehci_hcd 0000:00:1c.3: EHCI Host Controller
ehci_hcd 0000:00:1c.3: debug port 1
ehci_hcd 0000:00:1c.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1c.3: irq 217, io mem 0xdfffc000
ehci_hcd 0000:00:1c.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 8 ports detected
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
Linux video capture interface: v1.00
hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...
usb 1-2: device not accepting address 2, error -110
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
ieee1394: Initialized config rom entry `ip1394'
tg3.c:v3.43 (Oct 24, 2005)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 18 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:30:1b:b8:99:73
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
GSI 20 sharing vector 0xE1 and IRQ 20
ACPI: PCI Interrupt 0000:03:15.0[A] -> GSI 17 (level, low) -> IRQ 225
PCI: Via IRQ fixup for 0000:03:15.0, from 7 to 1
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[225]  MMIO=[dfcff000-dfcff7ff]  Max Packet=[2048]
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:03:16.0[A] -> GSI 18 (level, low) -> IRQ 201
bttv0: Bt878 (rev 2) at 0000:03:16.0, irq: 201, latency: 32, mmio: 0xdfbff000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom 0-0050: Hauppauge model 61314, rev A1MC, serial# 3011724
tveeprom 0-0050: tuner model is Philips FI1216 MK2 (idx 8, type 5)
tveeprom 0-0050: TV standards PAL(B/G) (eeprom 0x04)
tveeprom 0-0050: audio processor is MSP3415 (idx 6)
tveeprom 0-0050: has no radio
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp3400 0-0040: chip=MSP3410D-B4 +nicam +simple mode=simple
msp3400 0-0040: msp3410 daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .<4>bt878: Unknown symbol bttv_read_gpio
bt878: Unknown symbol bttv_write_gpio
bt878: Unknown symbol bttv_gpio_enable
. ok
ACPI: PCI Interrupt 0000:03:16.1[A] -> GSI 18 (level, low) -> IRQ 201
usb 1-2: new low speed USB device using ohci_hcd and address 4
input: Logitech USB Receiver as /class/input/input1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1c.0-2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00301bb8000099d7]
usb 2-3: new full speed USB device using ohci_hcd and address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0317
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
floppy0: no floppy controllers found
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 2096472k swap on /dev/sda3.  Priority:0 extents:1 across:2096472k
Adding 2096472k swap on /dev/sdb3.  Priority:0 extents:1 across:2096472k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6
it87: Found IT8712F chip at 0x290, revision 6
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface

--=-F8+s2J2sN4j4PCWHEbR/
Content-Disposition: attachment; filename=dmidecode.txt
Content-Type: text/plain; name=dmidecode.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.7
SMBIOS 2.3 present.
47 structures occupying 1272 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 20 bytes.
BIOS Information
	Vendor: Phoenix Technologies, LTD
	Version: 6.00 PG
	Release Date: 09/09/2005
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes.
System Information
	Manufacturer: Shuttle Inc
	Product Name: ST20V10
	Version:  
	Serial Number:  
	UUID: Not Present
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: Shuttle Inc
	Product Name: RS480-M1573
	Version:  
	Serial Number:  

Handle 0x0003, DMI type 3, 17 bytes.
Chassis Information
	Manufacturer:  
	Type: Desktop
	Lock: Not Present
	Version:  
	Serial Number:  
	Asset Tag:  
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
	Socket Designation: Socket 939
	Type: Central Processor
	Family: Athlon 64
	Manufacturer: AMD
	ID: F0 0F 02 00 FF FB 8B 07
	Signature: Extended Family 0, Extended Model 2, Stepping 0
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
	Version: AMD Athlon(tm) 64 Processor 3000+
	Voltage: 1.4 V
	External Clock: 201 MHz
	Max Speed: 500 MHz
	Current Speed: 1810 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000C
	L3 Cache Handle: Not Provided
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x0005, DMI type 5, 24 bytes.
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 32 MB
	Maximum Total Memory Size: 128 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		Standard
		EDO
	Memory Module Voltage: 5.0 V
	Associated Memory Slots: 4
		0x0006
		0x0007
		0x0008
		0x0009
	Enabled Error Correcting Capabilities: None

Handle 0x0006, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A0
	Bank Connections: 0 1
	Current Speed: 5 ns
	Type: Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A1
	Bank Connections: 2 3
	Current Speed: 5 ns
	Type: Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A2
	Bank Connections: None
	Current Speed: 5 ns
	Type: Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A3
	Bank Connections: None
	Current Speed: 5 ns
	Type: Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: SECONDARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0011, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator:  
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0012, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0013, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0014, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB0
	External Connector Type: Other
	Port Type: USB

Handle 0x0015, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Other
	Port Type: USB

Handle 0x0016, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Other
	Port Type: USB

Handle 0x0017, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Other
	Port Type: USB

Handle 0x0018, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB4
	External Connector Type: Other
	Port Type: USB

Handle 0x0019, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB5
	External Connector Type: Other
	Port Type: USB

Handle 0x001A, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB6
	External Connector Type: Other
	Port Type: USB

Handle 0x001B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB7
	External Connector Type: Other
	Port Type: USB

Handle 0x001C, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001D, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001E, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001F, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0020, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0021, DMI type 9, 13 bytes.
System Slot Information
	Designation: AGP
	Type: 32-bit AGP
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided

Handle 0x0022, DMI type 13, 22 bytes.
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x0023, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0024, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x0025, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A1
	Bank Locator: Bank2/3
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x0026, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A2
	Bank Locator: Bank4/5
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x0027, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A3
	Bank Locator: Bank6/7
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x0028, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0023
	Partition Width: 0

Handle 0x0029, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0024
	Memory Array Mapped Address Handle: 0x0028
	Partition Row Position: 1

Handle 0x002A, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0025
	Memory Array Mapped Address Handle: 0x0028
	Partition Row Position: 1

Handle 0x002B, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0026
	Memory Array Mapped Address Handle: 0x0028
	Partition Row Position: 1

Handle 0x002C, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0027
	Memory Array Mapped Address Handle: 0x0028
	Partition Row Position: 1

Handle 0x002D, DMI type 32, 11 bytes.
System Boot Information
	Status: No errors detected

Handle 0x002E, DMI type 127, 4 bytes.
End Of Table


--=-F8+s2J2sN4j4PCWHEbR/
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 2: I/O ports at ff00 [disabled] [size=32]

00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dfa00000-dfafffff
	Prefetchable memory behind bridge: dc000000-ddffffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Root Port (Slot-) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40b1
	Capabilities: [b0] #0d [0000]
	Capabilities: [b8] HyperTransport: MSI Mapping
	Capabilities: [100] Advanced Error Reporting

00:06.0 PCI bridge: ATI Technologies Inc: Unknown device 5a38 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: dfd00000-dfdfffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Root Port (Slot-) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40b9
	Capabilities: [b0] #0d [0000]
	Capabilities: [b8] HyperTransport: MSI Mapping
	Capabilities: [100] Advanced Error Reporting

00:19.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: dfc00000-dfcfffff
	Prefetchable memory behind bridge: dfb00000-dfbfffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1c.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]

00:1c.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size 08
	Interrupt: pin B routed to IRQ 201
	Region 0: Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]

00:1c.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size 08
	Interrupt: pin C routed to IRQ 201
	Region 0: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]

00:1c.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), Cache Line Size 10
	Interrupt: pin D routed to IRQ 217
	Region 0: Memory at dfffc000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1d.0 Class 0403: ALi Corporation High Definition Audio/AC'97 Host Controller
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device c790
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 20000ns max)
	Interrupt: pin C routed to IRQ 209
	Region 0: Memory at dfff4000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 ISA bridge: ALi Corporation PCI to LPC Controller (rev 31)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 6000ns max)

00:1e.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if fa)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 193
	Region 4: I/O ports at 8880 [size=16]

00:1f.1 RAID bus controller: ALi Corporation ULi 5287 SATA (rev 02)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128, Cache Line Size 80
	Interrupt: pin A routed to IRQ 193
	Region 0: I/O ports at fd00 [size=16]
	Region 1: I/O ports at fc00 [size=8]
	Region 2: I/O ports at fb00 [size=16]
	Region 3: I/O ports at fa00 [size=8]
	Region 4: I/O ports at f900 [size=32]
	Region 5: Memory at dfffb000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 0102
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
	Region 1: I/O ports at ee00 [size=256]
	Region 2: Memory at dfaf0000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at dfa00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <128ns, L1 <2us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Advanced Error Reporting

01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
	Subsystem: ASUSTeK Computer Inc.: Unknown device 0103
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at dfae0000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <128ns, L1 <2us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 01)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f391
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at dfef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 688d16000d00c110  Data: 1006
	Capabilities: [d0] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <2us, L1 <64us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel

03:15.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at dfcff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at cf00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:16.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at dfbff000 (32-bit, prefetchable) [size=4K]

03:16.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at dfbfe000 (32-bit, prefetchable) [size=4K]


--=-F8+s2J2sN4j4PCWHEbR/--

