Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbVJ0WjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbVJ0WjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbVJ0WjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:39:22 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:41712 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751613AbVJ0WjV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:39:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4PiHOx+EnPNksxZnaRkzK8rry/woFQZhfFqFa1qrnKYG0VurMSrHia20SRPAhtTAkBGrsUBPQ4tw5OB//PB0l9fuAYVjvPlo9DEeFwqDIpjCk/VX1wCpVA3XJrVUjLMz9rn1O7yOJiwZfZxMn4MINTvAaEZg165vWXRPXwfta8=
Message-ID: <d4b6d3ea0510271539t782582ddpb13d1a9e13a84f9c@mail.gmail.com>
Date: Thu, 27 Oct 2005 15:39:20 -0700
From: Michael Madore <michael.madore@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: PCI-DMA: high address but no IOMMU
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73slum38rw.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
	 <p73slum38rw.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Oct 2005 00:16:51 +0200, Andi Kleen <ak@suse.de> wro> >
> > Checking aperture...
> > CPU 0: aperture @ 8000000 size 32 MB
> > Aperture from northbridge cpu 0 too small (32 MB)
> > No AGP bridge found
> > Your BIOS doesn't leave a aperture memory hole
> > Please enable the IOMMU option in the BIOS setup
> > This costs you 64 MB of RAM
> > Mapping aperture over 65536 KB of RAM @ 8000000
> >
> > ...
> >
> > PCI-DMA: Disabling AGP.
> > PCI-DMA: aperture base @ 8000000 size 65536 KB
> > PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
>
> Can you post the full boot log?
>

Hi Andy,

Here is the full boot log from 2.6.14-rc5.

Mike

Bootdata ok (command line is ro root=LABEL=/ console=ttyS0,115200 console=tty0)
Linux version 2.6.14-rc5 (root@asl75.aslab.com) (gcc version 4.0.1
20050727 (Red Hat 4.0.1-5)) #1 SMP Tue Oct 25 11:20:20 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfff0000 (usable)
 BIOS-e820: 00000000cfff0000 - 00000000cfff3000 (ACPI NVS)
 BIOS-e820: 00000000cfff3000 - 00000000d0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
Node 1 MemBase 0000000100000000 Limit 00000001ffffffff
Using node hash shift of 22
Bootmem setup node 0 0000000000000000-00000000ffffffff
Bootmem setup node 1 0000000100000000-00000001ffffffff
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
Checking aperture...
CPU 0: aperture @ be8c000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 2 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2211.346 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 7402804k/8388608k available (2484k kernel code, 198920k
reserved, 1319k data, 236k init)
Calibrating delay using timer specific routine.. 4427.38 BogoMIPS (lpj=8854777)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4422.99 BogoMIPS (lpj=8845992)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 248 stepping 08
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -126 cycles, maxerr 1130 cycles)
Brought up 2 CPUs
softlockup thread 1 started up.
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
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
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: More than 4GB of RAM and no IOMMU
PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: a000-afff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:0c.0
  IO window: 9000-9fff
  MEM window: fdd00000-fddfffff
  PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:0d.0
  IO window: 8000-8fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fda00000-fdafffff
PCI: Bridge: 0000:00:0e.0
  IO window: 7000-7fff
  MEM window: fa000000-fcffffff
  PREFETCH window: d0000000-dfffffff
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1130326229.628:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
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
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 236k freed
SCSI subsystem initialized
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level,
low) -> IRQ 209
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 209
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 209
ata1: no device found (phy stat 00000000)
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level,
low) -> IRQ 217
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 217
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 217
input: PS/2 Generic Mouse on isa0060/serio1
ata3: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
ata3(0): applying bridge limits
nv_sata: Primary device added
ata3: dev 0 configured for UDMA/100
scsi2 : sata_nv
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: no device found (phy stat 00000000)
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD360GD-00EL  Rev: 32.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
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
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Kernel panic - not syncing: PCI-DMA: high address but no IOMMU.
