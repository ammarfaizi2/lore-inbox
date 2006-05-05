Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWEEQhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWEEQhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEEQhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:37:33 -0400
Received: from ws6-6.us4.outblaze.com ([205.158.62.64]:23455 "HELO
	ws6-6.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751165AbWEEQhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:37:32 -0400
Message-ID: <445B7F4E.8030304@daxsolutions.com>
Date: Fri, 05 May 2006 09:37:34 -0700
From: Paul Risenhoover <prisenhoover@daxsolutions.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GPF on Dell machines
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting the following error repeatedly on a number of machines 
in my server farm.  Unfortunately, when this happens, the machine 
becomes completely inoperable and must be hard booted.  These are 
dual-processor Dell X64 machines . 

Can anybody please help?  How can I make this stop?  Should I be posting 
this to the samba mailing list instead?

May  3 12:35:04 neon kernel: general protection fault: 0000 [1] SMP
May  3 12:35:04 neon kernel: last sysfs file: /class/vc/vcsa4/dev
May  3 12:35:04 neon kernel: CPU 0
May  3 12:35:04 neon kernel: Modules linked in: smbfs ipv6 parport_pc lp 
parport autofs4 i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc pcmcia
yenta_socket rsrc_nonstatic pcmcia_core video button battery ac 
e752x_edac edac_mc e1000 dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod 
ata_piix
 libata sd_mod scsi_mod
May  3 12:35:04 neon kernel: Pid: 21979, comm: smbiod Not tainted 
2.6.16-1.2069_FC4smp #1
May  3 12:35:04 neon kernel: RIP: 0010:[<ffffffff882ea8ff>] 
<ffffffff882ea8ff>{:smbfs:smbiod+520}
May  3 12:35:04 neon kernel: RSP: 0018:ffff810007013ee8  EFLAGS: 00010202
May  3 12:35:04 neon kernel: RAX: ffff203f1200b400 RBX: ffff81007fc8b400 
RCX: ffff810007013ed4
May  3 12:35:04 neon kernel: RDX: 00000000ffffffff RSI: 0000000000000000 
RDI: 0000000000000001
May  3 12:35:04 neon kernel: RBP: 0000000000000000 R08: ffff810007012000 
R09: 00000000000005a8
May  3 12:35:04 neon kernel: R10: 0000000000000002 R11: ffffffff80316311 
R12: 0000000000000007
May  3 12:35:04 neon kernel: R13: ffff203f1200b400 R14: ffff81007da3e4c8 
R15: ffff810007013ee8
May  3 12:35:04 neon kernel: FS:  00002aaaaadfd6e0(0000) 
GS:ffffffff8051e000(0000) knlGS:0000000000000000
May  3 12:35:04 neon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
May  3 12:35:04 neon kernel: CR2: 00002aab32604000 CR3: 0000000008a5f000 
CR4: 00000000000006e0
May  3 12:35:04 neon kernel: Process smbiod (pid: 21979, threadinfo 
ffff810007012000, task ffff81001b4cb7a0)
May  3 12:35:04 neon kernel: Stack: 0000000000000000 ffff81001b4cb7a0 
ffffffff8014a2b0 ffff810007013f00
May  3 12:35:04 neon kernel:        ffff810007013f00 ffff810007013f58 
ffff81001b4cb7a0 ffff81007c14ea00
May  3 12:35:04 neon kernel:        ffff81007c14ea00 ffff8100698a3c58
May  3 12:35:04 neon kernel: Call Trace: 
<ffffffff8014a2b0>{autoremove_wake_function+0}
May  3 12:35:04 neon kernel:        <ffffffff8010bb1a>{child_rip+8} 
<ffffffff882ea6f7>{:smbfs:smbiod+0}
May  3 12:35:04 neon kernel:        <ffffffff8010bb12>{child_rip+0}
May  3 12:35:04 neon kernel:
May  3 12:35:04 neon kernel: Code: 49 8b 45 00 4c 89 eb 49 81 fd e0 2b 
2f 88 74 19 49 89 c5 e9
May  3 12:35:04 neon kernel: RIP <ffffffff882ea8ff>{:smbfs:smbiod+520} 
RSP <ffff810007013ee8>
May  3 12:35:31 neon kernel:  <5>smb_add_request: request 
[ffff810026493680, mid=765] timed out!

--> DMESG BEGINS HERE <--
Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00)
Linux version 2.6.16-1.2069_FC4smp 
(bhcompile@hs20-bc1-6.build.redhat.com) (gcc version 4.0.2 20051125 (Red 
Hat 4.0.2-8)) #1 SMP Tue Mar 28 12:48:20 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
 BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 DELL                                  ) @ 
0x00000000000fd650
ACPI: RSDT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd664
ACPI: FADT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd6b0
ACPI: MADT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd724
ACPI: SPCR (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd7c0
ACPI: HPET (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd810
ACPI: MCFG (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd848
ACPI: DSDT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000e) @ 
0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-000000007ffc0000
Bootmem setup node 0 0000000000000000-000000007ffc0000
On node 0 totalpages: 514768
  DMA zone: 2767 pages, LIFO batch:0
  DMA32 zone: 512001 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[64])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 64-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
Checking aperture...
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3000.147 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2053744k/2096896k available (2397k kernel code, 42768k reserved, 
1210k data, 204k init)
Calibrating delay using timer specific routine.. 6005.70 BogoMIPS 
(lpj=12011403)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
result 12500500
Detected 12.500 MHz APIC timer.
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.44 BogoMIPS 
(lpj=12000895)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 6000.40 BogoMIPS 
(lpj=12000819)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
APIC error on CPU2: 00(40)
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6000.35 BogoMIPS 
(lpj=12000704)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
APIC error on CPU3: 00(40)
Brought up 4 CPUs
testing NMI watchdog ... OK.
migration_cost=3,1714
checking if image is initramfs... it is
Freeing initrd memory: 1875k freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:04:0d.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PICH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-DMA: Disabling IOMMU.
pnp: 00:06: ioport range 0x800-0x87f could not be reserved
pnp: 00:06: ioport range 0x880-0x8bf has been reserved
pnp: 00:06: ioport range 0x8c0-0x8df has been reserved
pnp: 00:06: ioport range 0x8e0-0x8e3 has been reserved
pnp: 00:06: ioport range 0xc00-0xc0f has been reserved
pnp: 00:06: ioport range 0xc10-0xc1f has been reserved
pnp: 00:06: ioport range 0xca0-0xcaf has been reserved
pnp: 00:06: ioport range 0xc20-0xc3f has been reserved
PCI: Bridge: 0000:01:00.0
  IO window: e000-efff
  MEM window: fea00000-febfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe800000-febfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe600000-fe7fffff
  PREFETCH window: f0000000-f7ffffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1146770259.072:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 7C299BBC39CD3974
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Intel E7520/7320/7525 detected.<6>ACPI: PCI Interrupt 0000:00:02.0[A] -> 
GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
pnp: Device 00:05 activated.
00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: TEAC CD-ROM CD-224E-N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X CD-ROM drive, 256kB Cache, UDMA(33)
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
ACPI wakeup devices:
PCI0 PALO  PXH PXHB PXHA PICH
ACPI: (supports S0 S4 S5)
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 426k
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xCCF8 ctl 0xCCF2 bmdma 0xCCC0 irq 17
ata2: SATA max UDMA/133 cmd 0xCCE0 ctl 0xCCDA bmdma 0xCCC8 irq 17
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3c21 87:4663 
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 156250000 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: dm-0: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 10615593
ext3_orphan_cleanup: deleting unreferenced inode 14305643
ext3_orphan_cleanup: deleting unreferenced inode 10835636
ext3_orphan_cleanup: deleting unreferenced inode 10607810
ext3_orphan_cleanup: deleting unreferenced inode 10835634
ext3_orphan_cleanup: deleting unreferenced inode 10610239
ext3_orphan_cleanup: deleting unreferenced inode 10607808
ext3_orphan_cleanup: deleting unreferenced inode 10607746
ext3_orphan_cleanup: deleting unreferenced inode 10607740
ext3_orphan_cleanup: deleting unreferenced inode 10607733
ext3_orphan_cleanup: deleting unreferenced inode 10607659
ext3_orphan_cleanup: deleting unreferenced inode 16891829
ext3_orphan_cleanup: deleting unreferenced inode 16891825
ext3_orphan_cleanup: deleting unreferenced inode 10606624
EXT3-fs: dm-0: 14 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 889 types, 109 bools
security:  55 classes, 244452 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses 
genfs_contexts
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
floppy0: no floppy controllers found
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4-NAPI
Copyright (c) 1999-2005 Intel Corporation.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 32 (level, low) -> IRQ 18
e1000: 0000:02:04.0: e1000_probe: (PCI:66MHz:32-bit) 00:14:22:b1:1a:33
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
hw_random: RNG not detected
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Mar 28 2006
tolm = 80000, remapbase = ffc000, remaplimit = 0
EDAC MC0: Giving out device to "e752x_edac" E7520: PCI 0000:00:00.0
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
ACPI: Video Device [EVGA] (multi-head: no  rom: yes  post: no)
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 
across:2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses 
genfs_contexts
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
i2c /dev entries driver
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
lp: driver loaded but no devices found
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
SELinux: initialized (dev smbfs, type smbfs), uses genfs_contexts
SELinux: initialized (dev smbfs, type smbfs), uses genfs_contexts
eth0: no IPv6 routers present
SELinux: initialized (dev smbfs, type smbfs), uses genfs_contexts

