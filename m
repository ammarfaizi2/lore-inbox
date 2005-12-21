Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVLUMCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVLUMCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 07:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVLUMCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 07:02:23 -0500
Received: from 8.ctyme.com ([69.50.231.8]:42370 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932379AbVLUMCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 07:02:22 -0500
Message-ID: <43A9444C.8000009@perkel.com>
Date: Wed, 21 Dec 2005 04:02:20 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA SCSI device numbering - I'm confuzed! - Help!
References: <43A901C8.4090706@perkel.com> <20051221093418.1e15e5f2@werewolf.auna.net>
In-Reply-To: <20051221093418.1e15e5f2@werewolf.auna.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



J.A. Magallon wrote:

>On Tue, 20 Dec 2005 23:18:32 -0800, Marc Perkel <marc@perkel.com> wrote:
>
>  
>
>>OK - this really has me stumped. I have a asus A8N-SLI premium 
>>motherboard. It has 4 SATA ports on it. The ports are numbered 1 to 4. 
>>So somehow I asumed that port 1 would be /dev/sda ... port 4 would be 
>>/dev/sdd - but when I boot up the order is very different and doesn't 
>>make a lot of sense. How can a person predict what drives will get what 
>>device names. Sure would be handy to be able to know that.
>>
>>    
>>
>
>Plz, post this info:
>
>lspci
>dmesg
>
>to see what is in you mobo and how does kernel detect it.
>That four sata ports can be several (2?) separate PCI devices and it all depends
>on the order the kernel detects them.
>  
>

ok - here it is. Thanks for looking at this.

Bootdata ok (command line is ro root=LABEL=/ pci=nommconf vga=1)
Linux version 2.6.14-1.1653_FC4smp (bhcompile@dolly.build.redhat.com) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 SMP Tue Dec 13 21:55:55 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9900
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9a40
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: Node 0 PXM 0 0-9ffff
SRAT: Node 0 PXM 0 0-bfffffff
SRAT: Node 0 PXM 0 0-13fffffff
Using 21 for the hash shift. Max adder is 13fffffff 
Bootmem setup node 0 0000000000000000-000000013fffffff
On node 0 totalpages: 1048462
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 1044463 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
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
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Checking aperture...
CPU 0: aperture @ f24000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 1 zonelists
Kernel command line: ro root=LABEL=/ pci=nommconf vga=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2211.342 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 4038164k/5242880k available (2335k kernel code, 155688k reserved, 1390k data, 236k init)
Calibrating delay using timer specific routine.. 4427.29 BogoMIPS (lpj=8854586)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4422.98 BogoMIPS (lpj=8845975)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -82 cycles, maxerr 595 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050916
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:05:07.0
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: 9000-afff
  MEM window: d0000000-d1ffffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1135131556.756:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 84712D1D7DBF3EE6
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
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
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
Freeing unused kernel memory: 236k freed
Write protecting the kernel read-only data: 824k
SCSI subsystem initialized
libata version 1.12 loaded.
sata_nv version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 217
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 217
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sda1 sda2 sda3
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 225
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 225
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata3: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata4: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: dev 0 configured for UDMA/133
scsi3 : sata_nv
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
 sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdb1 sdb2 sdb3 sdb4
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdc: drive cache: write back
 sdc:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdc1 sdc2 sdc3 sdc4
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
sata_sil version 0.9
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 233
ata5: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A bmdma 0xFFFFC20000006000 irq 233
ata6: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA bmdma 0xFFFFC20000006008 irq 233
ata7: SATA max UDMA/100 cmd 0xFFFFC20000006280 ctl 0xFFFFC2000000628A bmdma 0xFFFFC20000006200 irq 233
ata8: SATA max UDMA/100 cmd 0xFFFFC200000062C0 ctl 0xFFFFC200000062CA bmdma 0xFFFFC20000006208 irq 233
ata5: SATA link down (SStatus 0)
scsi4 : sata_sil
ata6: SATA link down (SStatus 0)
scsi5 : sata_sil
ata7: SATA link down (SStatus 0)
scsi6 : sata_sil
ata8: SATA link down (SStatus 0)
scsi7 : sata_sil
floppy0: no floppy controllers found
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 50
eth0: RealTek RTL8139 at 0xffffc2000001e000, 00:50:fc:54:8d:c5, IRQ 50
eth0:  Identified 8139 chip type 'RTL-8139C'
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 21 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 58, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 66, io mem 0xd2002000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 2-3: new low speed USB device using ohci_hcd and address 2
input: USB HID v1.10 Keyboard [USB Keyboard + Mouse] on usb-0000:00:02.0-3
input: USB HID v1.10 Mouse [USB Keyboard + Mouse] on usb-0000:00:02.0-3
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdc3 ...
md:  adding sdc3 ...
md:  adding sdb3 ...
md: created md0
md: bind<sdb3>
md: bind<sdc3>
md: running: <sdc3><sdb3>
md: raid1 personality registered as nr 3
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
EXT3 FS on sdb4, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 11984480k swap on /dev/sda2.  Priority:-1 extents:1 across:11984480k
Adding 2008116k swap on /dev/sdb2.  Priority:-2 extents:1 across:2008116k
Adding 2008116k swap on /dev/sdc2.  Priority:-3 extents:1 across:2008116k


