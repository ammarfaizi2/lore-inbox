Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWI2Xz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWI2Xz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWI2Xz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:55:27 -0400
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:10197 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932295AbWI2XzY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:55:24 -0400
X-IronPort-AV: i="4.09,238,1157342400"; 
   d="scan'208"; a="887631087:sNHT39322256"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <17693.45672.606566.72524@smtp.charter.net>
Date: Fri, 29 Sep 2006 19:55:20 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: 2.6.18-mm2 - oops with HPT302 with libata PATA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this oops on bootup of a 2.6.18-mm2 kernel on an SMP Xeon box
using the new libata PATA driver hpt37x.c.  Let me know if you
want/need more details.

Thanks,
John

--------------------------boot up messages, edited -------------------

Linux version 2.6.18-mm2 (john@jfsnew) (gcc version 4.1.2 20060920
(prerelease) 
(Debian 4.1.1-14)) #5 SMP Thu Sep 28 22:56:26 EDT 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end:
00000000000a
0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end:
000000000010
0000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fefe000 end:
000000002fff
e000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002fffe000 size: 0000000000002000 end:
000000003000
0000 type: 2
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end:
00000000fec1
0000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end:
00000000fee1
0000 type: 2
copy_e820_map() start: 00000000ffe00000 size: 0000000000200000 end:
000000010000
0000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000fe710
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   196606
early_node_map[1] active PFN ranges
    0:        0 ->   196606
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x4])
ACPI: NMI not connected to LINT 1!
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
Detected 547.217 MHz processor.
Built 1 zonelists.  Total pages: 195071
Kernel command line: root=/dev/sda2 ro console=tty0
console=ttyS0,9600n8 earlyp
rintk=serial
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
disabling early console
Linux version 2.6.18-mm2 (john@jfsnew) (gcc version 4.1.2 20060920
(prerelease) 
(Debian 4.1.1-14)) #5 SMP Thu Sep 28 22:56:26 EDT 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end:
00000000000a
0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end:
000000000010
0000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fefe000 end:
000000002fff
e000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002fffe000 size: 0000000000002000 end:
000000003000
0000 type: 2
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end:
00000000fec1
0000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end:
00000000fee1
0000 type: 2
copy_e820_map() start: 00000000ffe00000 size: 0000000000200000 end:
000000010000
0000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000fe710
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   196606
early_node_map[1] active PFN ranges
    0:        0 ->   196606
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x4])
ACPI: NMI not connected to LINT 1!
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
Detected 547.217 MHz processor.
Built 1 zonelists.  Total pages: 195071
Kernel command line: root=/dev/sda2 ro console=tty0
console=ttyS0,9600n8 earlyp
rintk=serial
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773868k/786424k available (2980k kernel code, 12032k reserved,
1468k dat
a, 236k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xf0800000 - 0xfffb5000   ( 247 MB)
    lowmem  : 0xc0000000 - 0xefffe000   ( 767 MB)
      .init : 0xc0560000 - 0xc059b000   ( 236 kB)
      .data : 0xc03e935e - 0xc05583cc   (1468 kB)
      .text : 0xc0100000 - 0xc03e935e   (2980 kB)
Checking if this processor honours the WP bit even in supervisor
mode... Ok.
Calibrating delay using timer specific routine.. 1094.97 BogoMIPS
(lpj=547486)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1094.22 BogoMIPS
(lpj=547111)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2189.19 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=3610
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfca1e, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 0800-083f claimed by PIIX4 ACPI
PCI quirk: region 0850-085f claimed by PIIX4 SMB
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver us report
pnp: 00:0c: ioport range 0x800-0x85f could not be :-fbffffff
  PREFETCH window: f6000000-f6ffffff
PCI: Bridge:   PREFETCH window: f1000000-f1ffffff
NET: Registered protocol family 2
.
.
.
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT302: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 18
ata1: PATA max UDMA/133 cmd 0xECF8 ctl 0xECF2 bmdma 0xE800 irq 18
ata2: PATA max UDMA/133 cmd 0xECE0 ctl 0xECDA bmdma 0xE808 irq 18
scsi2 : pata_hpt37x
ata1.00: ATA-5, max UDMA/100, 234441648 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
Find mode for 12 reports C829C62
Find mode for DMA 69 reports 1C6DDC62
ata1.00: configured for UDMA/100
scsi3 : pata_hpt37x
ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48 
ata2.00: ata2: dev 0 multi count 16
Find mode for 12 reports C829C62
Find mode for DMA 69 reports 1C6DDC62
ata2.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1200JB-00C 17.0 PQ: 0
ANSI: 5
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg3 type 0
scsi 3:0:0:0: Direct-Access     ATA      WDC WD1200JB-00E 15.0 PQ: 0
ANSI: 5
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg4 type 0
.
.
.
md: running: <sdd1><sdc1>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 15/15 pages, set 0 bits,
status: 0
created bitmap (224 pages) for device md0
irq 18: nobody cared (try booting with the "irqpoll" option)
 [<c013eae4>] __report_bad_irq+0x24/0x90
 [<c013ed68>] note_interrupt+0x218/0x250
 [<c013dff3>] handle_IRQ_event+0x33/0x70
 [<c013f6ea>] handle_fasteoi_irq+0xca/0xe0
 [<c0105897>] do_IRQ+0x47/0x90
 [<c0560250>] unknown_bootoption+0x0/0x270
 [<c01039a2>] common_interrupt+0x1a/0x20
 [<c0101c10>] default_idle+0x0/0x60
 [<c0560250>] unknown_bootoption+0x0/0x270
 [<c0101c41>] default_idle+0x31/0x60
 [<c0101cdc>] cpu_idle+0x6c/0x90
 [<c05607b9>] start_kernel+0x2f9/0x400
 [<c0560250>] unknown_bootoption+0x0/0x270
 =======================
handlers:
[<c02edb20>] (ahc_linux_isr+0x0/0x50)
[<c02edb20>] (ahc_linux_isr+0x0/0x50)
[<c0303730>] (ata_interrupt+0x0/0x190)
Disabling IRQ #18
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
SysRq : Emergency Sync
Emergency Sync complete
SysRq : Resetting
