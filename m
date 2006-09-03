Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWICMdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWICMdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 08:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWICMdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 08:33:16 -0400
Received: from ku-gbr.de ([81.3.11.18]:36296 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S1750956AbWICMdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 08:33:14 -0400
Date: Sun, 3 Sep 2006 14:33:09 +0200
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: sata_nv and 2.6.17 breaks
Message-ID: <20060903123308.GA6327@sexmachine.doom>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Folks!

I experienced a problem with sata_nv and ext3 on it recently. I tested
it a wwek long and now in production use it broke.

See attached dmesg output. 

Its a gigabyte ga-m51gm-s2g mainboard with sda attached to SATA1 and sdb
attached to SATA3, not utilizing any "raid" function.

Hm... I found some recent entries (from june) regarding this combination
but I did not found useful information helping me out despict of
assumtions. Also the incidendce was reported with a´maxtor discs, I use
two identical

Samsung HD160JJ (SpinPoint P80SD)

These two are brand new so I don't suspect there is really a hardware
error on sdb.

regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.17-2-686 (Debian 2.6.17-8) (waldi@debian.org) (gcc version 4.1.2 20060814 (prerelease) (Debian 4.1.1-11)) #1 SMP Thu Aug 31 12:53:18 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003bff0000 (usable)
 BIOS-e820: 000000003bff0000 - 000000003bff3000 (ACPI NVS)
 BIOS-e820: 000000003bff3000 - 000000003c000000 (ACPI data)
 BIOS-e820: 000000003c000000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f2000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
959MB LOWMEM available.
found SMP MP-table at 000f5240
On node 0 totalpages: 245744
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 241648 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6bf0
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3bff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3bff3040
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x3bff7a40
ACPI: MCFG (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3bff7c40
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3bff79c0
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=vmlinuz ro root=801 selinux=0 rootfsflags=data=journal
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2009.380 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 966896k/982976k available (1482k kernel code, 15608k reserved, 544k data, 196k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4024.53 BogoMIPS (lpj=8049065)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
CPU: After vendor identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4018.60 BogoMIPS (lpj=8037207)
CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
CPU: After vendor identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Total of 2 processors activated (8043.13 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
Brought up 2 CPUs
migration_cost=4000
checking if image is initramfs... it is
Freeing initrd memory: 4512k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
PCI: No mmconfig possible on 0:18
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:05.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
pnp: 00:01: ioport range 0x2000-0x207f has been reserved
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: 8000-8fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: 9000-9fff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: a000-afff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:10.0
  IO window: disabled.
  MEM window: f5000000-f50fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1157226882.032:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[02fc:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: No PS/2 controller found. Probing ports directly.
Failed to disable AUX port, but continuing anyway... Is this a SiS?
If AUX port is really absent please use the 'i8042.noaux' option.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI wakeup devices: 
HUB0 XVRA XVRB XVRC USB0 USB2 AZAD MMAC MMCI UAR1 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 196k freed
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0e.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 209
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[f5004000-f50047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:0e.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 217
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 217
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.54.
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:bc01 87:4023 88:40ff
ata1: dev 0 ATA-7, max UDMA7, 312579695 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: ZM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:0f.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 225
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 225
ata3: SATA link up 3.0 Gbps (SStatus 123)
ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:bc01 87:4023 88:40ff
ata3: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: ZM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 21 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0b.0: irq 233, io mem 0xf5108000
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0016e60000c43f4d]
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 20 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:14.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:14.0
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 23 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 217, io mem 0xf5104000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 2:0:0:0: Attached scsi disk sdb
Probing IDE interface ide1...
hdc: TSSTcorpDVD-ROM SH-D162C, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Probing IDE interface ide0...
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12ac
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
input: PC Speaker as /class/input/input0
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 22 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:10.1 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
Adding 2931852k swap on /dev/sda2.  Priority:-1 extents:1 across:2931852k
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (7679 buckets, 61432 max) - 224 bytes per conntrack
ata3: command 0xca timeout, stat 0xd0 host_stat 0x20
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x43da8
end_request: I/O error, dev sdb, sector 277928
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x43db0
end_request: I/O error, dev sdb, sector 277936
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x43db8
end_request: I/O error, dev sdb, sector 277944
Aborting journal on device dm-0.
EXT3-fs error (device dm-0) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device dm-0) in ext3_dirty_inode: Journal has aborted
ext3_abort called.
EXT3-fs error (device dm-0): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
ata3: command 0xca timeout, stat 0xd0 host_stat 0x20
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x500f5c0
end_request: I/O error, dev sdb, sector 83948992
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x500f5c8
end_request: I/O error, dev sdb, sector 83949000
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x500f5d0
end_request: I/O error, dev sdb, sector 83949008
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x500f5d8
end_request: I/O error, dev sdb, sector 83949016
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x500f5e0
end_request: I/O error, dev sdb, sector 83949024
ata3: command 0xca timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x6a00228
end_request: I/O error, dev sdb, sector 111149608
Buffer I/O error on device dm-3, logical block 3407893
lost page write due to I/O error on dm-3
ata3: command 0xc8 timeout, stat 0xd0 host_stat 0x21
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x1e20188
end_request: I/O error, dev sdb, sector 31588744
Aborting journal on device dm-3.
ext3_abort called.
EXT3-fs error (device dm-3): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only


--OXfL5xGRrasGEqWY--

-- 
VGER BF report: U 0.5
