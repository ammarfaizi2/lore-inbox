Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVFPGyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVFPGyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFPGyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:54:39 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:34376 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S261739AbVFPGx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:53:28 -0400
X-ME-UUID: 20050616065322325.4F5E21C0009C@mwinf1108.wanadoo.fr
Subject: 2.6.11: nforce3 250gb lockups
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 16 Jun 2005 08:54:09 +0200
Message-Id: <1118904850.5709.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a brand new computer, with an MSI K8N Neo (nforce3-based) which
lockups quite easily. It seems it happens when I play audio for a while,
or when accessing hd under load. With "nolapic", the boot stops when
accessing hda, with something like "hda interrupt timeout" repeating on
the screen. With "noapic nolapic", it boots normally but doesn't lockup
less. The Ubuntu install CD lockups at boot even with "noapic nolapic".

The kernel is the stock debian/sid 2.6.11-9-amd64-k8, the userspace is
i386 (32bits). lspci and dmesg at the bottom of this mail. The only
advices I found by googling were to try nolapic (which I did without
success) or the binary drivers (which I won't try).
Is there anything I can do, short of trying to return it to my
reseller ?

Thanks,
	Xav

0000:00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
0000:00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
0000:00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
0000:00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2)
0000:00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
0000:00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2)
0000:00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2)
0000:00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
0000:02:09.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)


Bootdata ok (command line is root=/dev/hda5 ro )
Linux version 2.6.11-9-amd64-k8 (root@lobo) (gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Fri May 27 17:14:56 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f71e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff7a00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258032 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:12 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
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
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro  console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2009.807 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1022784k/1048512k available (1745k kernel code, 24984k reserved, 949k data, 140k init)
Calibrating delay loop... 3981.31 BogoMIPS (lpj=1990656)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.561 MHz APIC timer.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
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
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1118903828.179:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4180KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 140k freed
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD400BB-32BSA0, ATA DISK drive
hdb: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST340824A, ATA DISK drive
hdd: DVDRW IDE 16X, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 >
hdc: max request size: 128KiB
hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes not supported
 /dev/ide/host0/bus1/target0/lun0: p1 p2
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048784k swap on /dev/hdc1.  Priority:-1 extents:1
Adding 1043240k swap on /dev/hda6.  Priority:-2 extents:1
EXT3 FS on hda5, internal journal
8139too Fast Ethernet driver 0.9.27
w83627hf 0-0290: Reading VID from GPIO5
Losing some ticks... checking if CPU frequency changed.
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
hdb: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
ts: Compaq touchscreen protocol output
ReiserFS: hdc2: found reiserfs format "3.6" with standard journal
ReiserFS: hdc2: using ordered data mode
ReiserFS: hdc2: journal params: device hdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc2: checking transaction log (hdc2)
ReiserFS: hdc2: Using r5 hash to sort names
EXT2-fs warning (device hda7): ext2_fill_super: mounting ext3 filesystem as ext2
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[de004000-de0047ff]  Max Packet=[2048]
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.31.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 23 (level, high) -> IRQ 23
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01462:0300 bound to 0000:00:05.0
SCSI subsystem initialized
libata version 1.10 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 22
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 22
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[230050c500001713]
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21 (level, high) -> IRQ 21
ehci_hcd 0000:00:02.2: PCI device 10de:00e8 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem 0xdf005000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-2: nForce2 SMBus adapter at 0x4c40
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20 (level, high) -> IRQ 20
ohci_hcd 0000:00:02.0: PCI device 10de:00e7 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 20, pci mem 0xdf003000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 23
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 23 (level, high) -> IRQ 23
ohci_hcd 0000:00:02.1: PCI device 10de:00e7 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 23, pci mem 0xdf004000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49871 usecs
intel8x0: clocking to 46784
ioctl32(alsactl:4914): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd7ac) on /dev/snd/controlC0
ioctl32(amixer:4955): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:4988): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:4991): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:4994): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:4997): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd8ac) on /dev/snd/controlC0
ioctl32(amixer:5000): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5003): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5006): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5009): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5012): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5015): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5018): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5021): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5024): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5027): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd89c) on /dev/snd/controlC0
ioctl32(amixer:5030): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd88c) on /dev/snd/controlC0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
NET: Registered protocol family 17
nfs warning: mount version older than kernel
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 not a capable Intel processor
microcode: No new microcode data for CPU0
IA-32 Microcode Update Driver v1.14 unregistered
ACPI: Power Button (FF) [PWRF]
ioctl32(alsactl:5699): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd83c) on /dev/snd/controlC0
ioctl32(amixer:5703): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5706): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5709): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5712): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5715): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5718): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5721): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5724): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5727): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5730): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd91c) on /dev/snd/controlC0
ioctl32(amixer:5733): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5736): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5739): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd92c) on /dev/snd/controlC0
ioctl32(amixer:5742): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd91c) on /dev/snd/controlC0
ioctl32(amixer:5745): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd91c) on /dev/snd/controlC0
ioctl32(amixer:5748): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd91c) on /dev/snd/controlC0
ioctl32(alsactl:5753): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd83c) on /dev/snd/controlC0
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff8036fd60(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Xorg: vm86 mode not supported on 64 bit kernel
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized r128 2.5.0 20030725 on minor 0: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
ioctl32(Xorg:6085): Unknown cmd fd(7) cmd(c0106407){00} arg(ffffda80) on /dev/dri/card0
ioctl32(Xorg:6085): Unknown cmd fd(7) cmd(c0086401){00} arg(ffffda88) on /dev/dri/card0
ioctl32(Xorg:6085): Unknown cmd fd(7) cmd(c0246400){00} arg(0873d678) on /dev/dri/card0
ioctl32(Xorg:6085): Unknown cmd fd(7) cmd(c0246400){00} arg(0873d678) on /dev/dri/card0
ioctl32(Xorg:6085): Unknown cmd fd(7) cmd(c0106407){00} arg(ffffdae0) on /dev/dri/card0
ioctl32(Xorg:6085): Unknown cmd fd(7) cmd(40086410){00} arg(ffffdaf0) on /dev/dri/card0



