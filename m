Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVGGF6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVGGF6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 01:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVGGF6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 01:58:17 -0400
Received: from bay20-f42.bay20.hotmail.com ([64.4.54.131]:51308 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261160AbVGGF6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 01:58:10 -0400
Message-ID: <BAY20-F42FDD187485A266D3988B6C4D80@phx.gbl>
X-Originating-IP: [65.64.155.98]
X-Originating-Email: [jonschindler@hotmail.com]
From: "Jon Schindler" <jonschindler@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops with dual core athlon 64
Date: Thu, 07 Jul 2005 01:58:08 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Jul 2005 05:58:09.0601 (UTC) FILETIME=[DA2EA310:01C582B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dmesg is below.  After I get this Oops, I am unable to use my (PS/2) 
keyboard, and had to ssh to my machine in order to save a copy of dmesg 
before rebooting the machine.  I've seen a couple of other users of dual 
core machings having this problem.  The suggestion so far has been to remove 
the binary nvidia driver and repoducde the bug.  So, I went ahead and 
removed the nvidia driver and used the deprecated nv driver that comes with 
X11 and I still have this issue.  Does anyone have any ideas what might be 
causing this?  Thanks in advance for the help.  I don't know my way around 
the kernel, but I do have experience with C and should be able to apply any 
SMP patches if you want me to test it

Jon

Bootdata ok (command line is ro root=LABEL=/1 rhgb 3)
Linux version 2.6.12.1 (root@localhost) (gcc version 4.0.0 20050519 (Red Hat 
4.0.0-8)) #14 SMP Tue Jul 5 00:33:42 CDT 2005
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 
0x00000000000f8e80
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x00000000bfff7b80
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff7ac0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 00000000bfff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-00000000bfff0000
On node 0 totalpages: 786416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 782320 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: c0000000:3ec00000)
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/1 rhgb 3
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2411.039 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3088372k/3145664k available (2382k kernel code, 0k reserved, 1584k 
data, 228k init)
Calibrating delay loop... 4767.74 BogoMIPS (lpj=2383872)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Using local APIC timer interrupts.
Detected 12.557 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff810004171f58
Initializing CPU#1
Calibrating delay loop... 4816.89 BogoMIPS (lpj=2408448)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff -75 cycles, maxerr 541 cycles)
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
domain 0: span 00000001
  groups: 00000001
  domain 1: span 00000003
   groups: 00000001 00000002
   domain 2: span 00000003
    groups: 00000003
CPU1 attaching sched-domain:
domain 0: span 00000002
  groups: 00000002
  domain 1: span 00000003
   groups: 00000002 00000001
   domain 2: span 00000003
    groups: 00000003
checking if image is initramfs... it is
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
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1120689527.311:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y250P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, 
UDMA(133)
hda: cache flushes supported
hda: hda1 hda2
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0x10 (2400 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xe (2200 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xc (1250 mV)
powernow-k8:    3 : fid 0xa (1800 MHz), vid 0xe (1200 mV)
powernow-k8:    4 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0x10, vid 0xa
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 228k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
SCSI subsystem initialized
libata version 1.11 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 23 (level, high) 
-> IRQ 177
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC800 irq 177
ata2: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC808 irq 177
ata1: no device found (phy stat 00000000)
scsi0 : sata_nv
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata2: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata2: dev 0 configured for UDMA/100
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
sda: sda1 sda2 sda3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) 
-> IRQ 185
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xB000 irq 185
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xB008 irq 185
ata3: dev 0 cfg 49:0e00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata3: no dma/lba
ata3: dev 0 not supported, ignoring
scsi2 : sata_nv
ata4: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 
88:407f
ata4: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: dev 0 configured for UDMA/133
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
sdb: sdb1
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 21 (level, high) 
-> IRQ 193
PCI: Setting latency timer of device 0000:00:05.0 to 64
0000:00:05.0: Invalid Mac address detected: 8d:f0:00:e7:39:00
Please complain to your hardware vendor. Switching to a random MAC.
eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC5] -> GSI 16 (level, low) -> 
IRQ 201
r8169: NAPI enabled
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffc20000006000, 00:11:09:8f:4f:a4, IRQ 201
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 20 (level, high) 
-> IRQ 209
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49677 usecs
intel8x0: clocking to 46755
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC2] -> GSI 17 (level, low) -> 
IRQ 217
bttv0: Bt878 (rev 2) at 0000:02:0a.0, irq: 217, latency: 32, mmio: 
0xfdeff000
bttv0: detected: ATI TV Wonder [card=63], PCI subsystem ID is 1002:0001
bttv0: using: ATI TV-Wonder [card=63,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: using tuner=19
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3430G-A4 +nicam +simple +simpler +radio mode=simpler
msp34xxg: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 2-0060: chip found @ 0xc0 (bt878 #0 [sw])
tuner 2-0060: type set to 19 (Temic PAL* auto (4006 FN5))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:02:0a.1[A] -> Link [APC2] -> GSI 17 (level, low) -> 
IRQ 217
bt878(0): Bt878 (rev 2) at 02:0a.1, irq: 217, latency: 32, memory: 
0xfdefe000
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 23 (level, high) 
-> IRQ 177
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 EHCI USB 2.0 Controller
ehci_hcd 0000:00:02.2: reset hcs_params 0x102488 dbg=1 cc=2 pcc=4 !ppc 
ports=8
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 1 0
ehci_hcd 0000:00:02.2: reset hcc_params a082 caching frame 256/512/1024
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: capability 0001 at a0
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 177, io mem 0xfe02d000
ehci_hcd 0000:00:02.2: reset command 080002 (park)=0 ithresh=8 period=1024 
Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: nVidia Corporation nForce3 EHCI USB 2.0 Controller
usb usb1: Manufacturer: Linux 2.6.12.1 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001803 POWER sig=j  CSC 
CONNECT
hub 1-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) 
-> IRQ 185
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation CK8S USB Controller
ohci_hcd 0000:00:02.0: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 185, io mem 0xfe02f000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: fminterval a7782edf
ohci_hcd 0000:00:02.0: hcca frame #0002
ohci_hcd 0000:00:02.0: roothub.a 01000204 POTPGT=1 NPS NDP=4
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: nVidia Corporation CK8S USB Controller
usb usb2: Manufacturer: Linux 2.6.12.1 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.0: created debug files
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) 
-> IRQ 193
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation CK8S USB Controller (#2)
ohci_hcd 0000:00:02.1: USB HC TakeOver from BIOS/SMM
hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 193, io mem 0xfe02e000
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: fminterval a7782edf
ohci_hcd 0000:00:02.1: hcca frame #0002
ohci_hcd 0000:00:02.1: roothub.a 01000204 POTPGT=1 NPS NDP=4
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: nVidia Corporation CK8S USB Controller (#2)
usb usb3: Manufacturer: Linux 2.6.12.1 ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.1: created debug files
usb 1-4: new high speed USB device using ehci_hcd and address 2
ohci_hcd 0000:00:02.0: suspend root hub
ieee1394: Initialized config rom entry `ip1394'
ohci_hcd 0000:00:02.1: suspend root hub
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> 
IRQ 225
PCI: Via IRQ fixup for 0000:02:0c.0, from 5 to 1
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[225]  MMIO=[fdfff000-fdfff7ff] 
  Max Packet=[2048]
usb 1-4: khubd timed out on ep0in len=0/64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00007aa441]
usb 1-4: khubd timed out on ep0in len=0/64
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.22 [Flags: R/O MODULE].
NTFS volume version 3.1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usb 1-4: khubd timed out on ep0in len=0/64
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80497340(lo)
IPv6 over IPv4 tunneling driver
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: new high speed USB device using ehci_hcd and address 3
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
eth0: no IPv6 routers present
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
hub 1-0:1.0: port_wait_reset: err = -107
hub 2-0:1.0: state 5 ports 4 chg 0000 evt 0000
hub 3-0:1.0: state 5 ports 4 chg 0000 evt 0000
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0010
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0010
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001803 POWER sig=j  CSC 
CONNECT
hub 1-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: new high speed USB device using ehci_hcd and address 4
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: new high speed USB device using ehci_hcd and address 5
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
usb 1-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: device descriptor read/64, error -110
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: new high speed USB device using ehci_hcd and address 6
usb 1-4: khubd timed out on ep0out len=0/0
usb 1-4: khubd timed out on ep0out len=0/0
usb 1-4: device not accepting address 6, error -110
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-4: new high speed USB device using ehci_hcd and address 7
usb 1-4: khubd timed out on ep0out len=0/0
usb 1-4: khubd timed out on ep0out len=0/0
usb 1-4: device not accepting address 7, error -110
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0010
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001002 POWER sig=se0  CSC
hub 1-0:1.0: port 4, status 0100, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x100
SysRq : Changing Loglevel
Loglevel set to 1
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
Losing some ticks... checking if CPU frequency changed.
Unable to handle kernel NULL pointer dereference at 0000000000000024 RIP:
<ffffffff8011d7b1>{query_current_values_with_pending_wait+65}
PGD aefd7067 PUD b863d067 PMD ac389067 PTE 0
Oops: 0002 [1] SMP
CPU 1
Modules linked in: md5 ipv6 parport_pc lp parport autofs4 sunrpc pcmcia 
yenta_socket rsrc_nonstatic pcmcia_core nls_utf8 ntfs dm_mod video button 
battery ac ohci1394 ieee1394 ohci_hcd ehci_hcd bt878 tuner msp3400 bttv 
video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom videodev i2c_nforce2 
i2c_core shpchp snd_intel8x0 snd_ac97_codec snd_seq_dummy snd_seq_oss 
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm 
snd_timer snd soundcore snd_page_alloc r8169 forcedeth floppy ext3 jbd 
sata_nv libata sd_mod scsi_mod
Pid: 7, comm: events/1 Not tainted 2.6.12.1
RIP: 0010:[<ffffffff8011d7b1>] 
<ffffffff8011d7b1>{query_current_values_with_pending_wait+65}
RSP: 0000:ffff8100bfcf1dc8  EFLAGS: 00010206
RAX: 0000000000000010 RBX: 0000000000000000 RCX: 00000000c0010042
RDX: 000000000000000a RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8100bfcf0000 R09: ffff810003a22088
R10: 0000000000000000 R11: 00007fffffde3ce4 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000292 R15: ffffffff80112680
FS:  00002aaaaaade480(0000) GS:ffffffff8054a2c0(0000) knlGS:0000000055f0ff60
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000024 CR3: 00000000b00e6000 CR4: 00000000000006e0
Process events/1 (pid: 7, threadinfo ffff8100bfcf0000, task 
ffff81000417a830)
Stack: 0000000000000000 ffffffff8011dd91 0000000000000001 ffff8100be963a00
       ffff8100be963a30 ffffffff802db1e3 0000000000000000 0000000000000003
       0000000000000001 0000000000000020
Call Trace:<ffffffff8011dd91>{powernowk8_get+129} 
<ffffffff802db1e3>{cpufreq_get+115}
       <ffffffff801126ba>{handle_cpufreq_delayed_get+58} 
<ffffffff8014aabc>{worker_thread+476}
       <ffffffff80133e80>{default_wake_function+0} 
<ffffffff80131e13>{__wake_up_common+67}
       <ffffffff8014a8e0>{worker_thread+0} <ffffffff8014f429>{kthread+217}
       <ffffffff801353f0>{schedule_tail+64} <ffffffff8010f6db>{child_rip+8}
       <ffffffff8011d350>{flat_send_IPI_mask+0} 
<ffffffff8014f350>{kthread+0}
       <ffffffff8010f6d3>{child_rip+0}

Code: 89 47 24 89 57 20 31 c0 48 83 c4 08 c3 66 90 48 83 ec 28 f7
RIP <ffffffff8011d7b1>{query_current_values_with_pending_wait+65} RSP 
<ffff8100bfcf1dc8>
CR2: 0000000000000024
<3>Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1

Call Trace:<ffffffff8013a155>{profile_task_exit+21} 
<ffffffff8013b572>{do_exit+34}
       <ffffffff8025a3a7>{do_unblank_screen+135} 
<ffffffff80123cad>{do_page_fault+1853}
       <ffffffff8034ffc0>{thread_return+0} 
<ffffffff80350012>{thread_return+82}
       <ffffffff80133aae>{activate_task+142} 
<ffffffff80112680>{handle_cpufreq_delayed_get+0}
       <ffffffff8010f525>{error_exit+0} 
<ffffffff80112680>{handle_cpufreq_delayed_get+0}
       <ffffffff8011d7b1>{query_current_values_with_pending_wait+65}
       <ffffffff8011dd91>{powernowk8_get+129} 
<ffffffff802db1e3>{cpufreq_get+115}
       <ffffffff801126ba>{handle_cpufreq_delayed_get+58} 
<ffffffff8014aabc>{worker_thread+476}
       <ffffffff80133e80>{default_wake_function+0} 
<ffffffff80131e13>{__wake_up_common+67}
       <ffffffff8014a8e0>{worker_thread+0} <ffffffff8014f429>{kthread+217}
       <ffffffff801353f0>{schedule_tail+64} <ffffffff8010f6db>{child_rip+8}
       <ffffffff8011d350>{flat_send_IPI_mask+0} 
<ffffffff8014f350>{kthread+0}
       <ffffffff8010f6d3>{child_rip+0}


