Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423019AbWBAXTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423019AbWBAXTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbWBAXTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:19:15 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:53195 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1423019AbWBAXTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:19:14 -0500
Date: Thu, 2 Feb 2006 02:19:11 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Message-ID: <20060201231911.GA5463@tentacle.sectorb.msk.ru>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <43E13F57.40808@gmail.com>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.15.1-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 08:08:07AM +0900, Tejun Heo wrote:
> Vladimir B. Savkin wrote:
> >Hello!
> >
> >My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
> >but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
> >gaves error messages some minutes after boot.
> >
> >The messages are as following:
> >  ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
> >where XX gets different values from time to time, 0x25 mostly.
> >I/O to this controller halts after that.
> >
> >Attached are boot dmesg log and lspci output.
> >
> 
> How reproducible is the problem?  With how much certainty can you say 
> the problem is introduced by newer kernels?  e.g. If the problem occurs 
> most of the time with 2.5.15.1 but it stops happending after switching 
> back to 2.6.13.3, you can be pretty sure.

Highly reproducible: months vs. minutes of uptime.

> 
> Can you also please post dmesg of 2.6.13.3?
> 

Surely.

Bootdata ok (command line is root=/dev/sda3 ro idle=poll )
Linux version 2.6.13.3 (vsavkin@forum) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Sun Oct 9 13:58:21 MSD 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d7fb0000 (usable)
 BIOS-e820: 00000000d7fb0000 - 00000000d7fc0000 (ACPI data)
 BIOS-e820: 00000000d7fc0000 - 00000000d7ff0000 (ACPI NVS)
 BIOS-e820: 00000000d7ff0000 - 00000000d8000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000124000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa7c0
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000530 MSFT 0x00000097) @ 0x00000000d7fb0100
ACPI: FADT (v003 A M I  OEMFACP  0x06000530 MSFT 0x00000097) @ 0x00000000d7fb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000530 MSFT 0x00000097) @ 0x00000000d7fb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000530 MSFT 0x00000097) @ 0x00000000d7fc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 1032015
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 1028016 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Looks like a VIA chipset. Disabling IOMMU. Overwrite with "iommu=allowed"
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d8000000 (gap: d8000000:27780000)
Built 1 zonelists
Kernel command line: root=/dev/sda3 ro idle=poll 
using polling idle threads.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2002.662 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x571d000 - 0x771d000
Memory: 4017220k/4784128k available (2282k kernel code, 110424k reserved, 1211k data, 532k init)
Calibrating delay using timer specific routine.. 4012.02 BogoMIPS (lpj=2006010)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
 tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...................................................................................................................................................
Table [DSDT](id F004) - 547 Objects with 51 Devices 147 Methods 25 Regions
ACPI Namespace successfully loaded at root ffffffff804c7f80
evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4004.52 BogoMIPS (lpj=2002260)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 568 cycles)
Brought up 2 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:............................................................................................................................
Initialized 24/25 Regions 44/44 Fields 41/41 Buffers 15/16 Packages (556 nodes)
Executing all Device _STA and_INI methods:.......................................................
55 Devices found containing: 55 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xdc000000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fbe00000-fbffffff
  PREFETCH window: e0000000-faffffff
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
PCI: Setting latency timer of device 0000:00:01.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1138810671.412:1): initialized
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 169
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 9
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: IC35L080AVVA07-0, ATA DISK drive
isa bounce pool size: 16 pages
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4
libata version 1.12 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 9
sata_via(0000:00:0f.0): routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 169
ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 169
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e8 86:3c02 87:4023 88:203f
ata2: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_via
  Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: PC Speaker
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 532k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
Adding 7912004k swap on /dev/sda2.  Priority:2 extents:1
Adding 3906496k swap on /dev/hdc3.  Priority:4 extents:1
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 177
eth0: RealTek RTL8139 at 0xffffc20000012000, 00:c0:26:a1:92:f5, IRQ 177
eth0:  Identified 8139 chip type 'RTL-8139C'
ReiserFS: sda9: found reiserfs format "3.6" with standard journal
ReiserFS: sda9: using ordered data mode
ReiserFS: sda9: journal params: device sda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda9: checking transaction log (sda9)
ReiserFS: sda9: replayed 1 transactions in 0 seconds
ReiserFS: sda9: Using r5 hash to sort names
ReiserFS: hdc4: found reiserfs format "3.6" with standard journal
ReiserFS: hdc4: using ordered data mode
ReiserFS: hdc4: journal params: device hdc4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc4: checking transaction log (hdc4)
ReiserFS: hdc4: replayed 1 transactions in 0 seconds
ReiserFS: hdc4: Using r5 hash to sort names
ReiserFS: sda11: found reiserfs format "3.6" with standard journal
ReiserFS: sda11: using ordered data mode
ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda11: checking transaction log (sda11)
ReiserFS: sda11: replayed 2 transactions in 0 seconds
ReiserFS: sda11: Using r5 hash to sort names
ReiserFS: sda8: found reiserfs format "3.6" with standard journal
ReiserFS: sda8: using ordered data mode
ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda8: checking transaction log (sda8)
ReiserFS: sda8: replayed 1 transactions in 0 seconds
ReiserFS: sda8: Using r5 hash to sort names
ReiserFS: hdc1: found reiserfs format "3.6" with standard journal
ReiserFS: hdc1: using ordered data mode
ReiserFS: hdc1: journal params: device hdc1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc1: checking transaction log (hdc1)
ReiserFS: hdc1: replayed 1 transactions in 0 seconds
ReiserFS: hdc1: Using r5 hash to sort names
ReiserFS: sda10: found reiserfs format "3.6" with standard journal
ReiserFS: sda10: using ordered data mode
ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda10: checking transaction log (sda10)
ReiserFS: sda10: replayed 9 transactions in 0 seconds
ReiserFS: sda10: Using r5 hash to sort names
ReiserFS: sda10: Removing [2 8 0x0 SD]..done
ReiserFS: sda10: Removing [2 7 0x0 SD]..done
ReiserFS: sda10: Removing [2 6 0x0 SD]..done
ReiserFS: sda10: There were 3 uncompleted unlinks/truncates. Completed
ReiserFS: sda5: found reiserfs format "3.6" with standard journal
ReiserFS: sda5: using ordered data mode
ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda5: checking transaction log (sda5)
ReiserFS: sda5: replayed 1 transactions in 0 seconds
ReiserFS: sda5: Using r5 hash to sort names
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: replayed 24 transactions in 0 seconds
ReiserFS: sda6: Using r5 hash to sort names
ReiserFS: hdc2: found reiserfs format "3.6" with standard journal
ReiserFS: hdc2: using ordered data mode
ReiserFS: hdc2: journal params: device hdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc2: checking transaction log (hdc2)
ReiserFS: hdc2: replayed 4 transactions in 0 seconds
ReiserFS: hdc2: Using r5 hash to sort names
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
vlan0169: add 01:00:5e:00:00:01 mcast address to master interface
vlan0170: add 01:00:5e:00:00:01 mcast address to master interface
NET: Registered protocol family 10
vlan0169: add 33:33:00:00:00:01 mcast address to master interface
vlan0169: add 33:33:ff:a1:92:f5 mcast address to master interface
vlan0170: add 33:33:00:00:00:01 mcast address to master interface
vlan0170: add 33:33:ff:a1:92:f5 mcast address to master interface
IPv6 over IPv4 tunneling driver

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

