Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWCMUcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWCMUcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWCMUcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:32:53 -0500
Received: from main.gmane.org ([80.91.229.2]:7352 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932450AbWCMUcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:32:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Mon, 13 Mar 2006 21:28:35 +0100
Message-ID: <pan.2006.03.13.20.28.29.796048@free.fr>
References: <1142262431.25773.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Le Mon, 13 Mar 2006 15:07:10 +0000, Alan Cox a écrit :

> Available from 
> 
> http://zeniv.linux.org.uk/~alan/IDE/
> 
> 	VIA ATAPI now works for me

It still doesn't work for me [1].
May be it has something to do with the lost interrupt I described in my
previous mail.

I will try ata_piix in order to see if all PATA device are seen.

Matthieu


[1]
Linux version 2.6.16-rc6 (root@mat-pc) (gcc version 4.1.0 20060219 (prerelease) (Debian 4.1-0exp9)) #11 PREEMPT Mon Mar 13 21:13:11 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb940
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa8e0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/sdc3 ro ide=reverse init=/bin/sh
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1533.562 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1036440k/1048512k available (1559k kernel code, 11480k reserved, 532k data, 136k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3071.81 BogoMIPS (lpj=6143635)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by vt8235 PM
PCI quirk: region 0400-040f claimed by vt8235 SMB
PCI: Ignoring BAR0-3 of IDE controller 0000:00:11.1
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ddd00000-dfdfffff
  PREFETCH window: cda00000-ddbfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
libata version 1.20 loaded.
pata_sil680 0000:00:07.0: version 0.2.1
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 16
ata1: PATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD800 irq 16
ata2: PATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD808 irq 16
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:007f
ata1: dev 0 ATA-7, max UDMA/133, 156368016 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : pata_sil680
ATA: abnormal status 0x7F on port 0xE007
ata2: disabling port
scsi1 : pata_sil680
  Vendor: ATA       Model: SAMSUNG SP0802N   Rev: TK10
  Type:   Direct-Access                      ANSI SCSI revision: 05
pata_via 0000:00:11.1: version 0.1.6
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover = 10
FIT t.act8b = 10, t.rec8b = 8, t.active = 9, t.recover = 9
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:203f
ata3: dev 0 ATA-7, max UDMA/100, 156368016 sectors: LBA48
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover = 10
FIT t.act8b = 10, t.rec8b = 8, t.active = 9, t.recover = 9
ata3: dev 1 cfg 49:2f00 82:74eb 83:5bea 84:4000 85:7469 86:1a02 87:4003 88:203f
ata3: dev 1 ATA-5, max UDMA/100, 80418240 sectors: LBA
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 3, t.recover = 1
FIT t.act8b = 10, t.rec8b = 8, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 3, t.recover = 1
FIT t.act8b = 10, t.rec8b = 8, t.active = 2, t.recover = 0
ata3: dev 0 configured for UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
ata3: dev 1 configured for UDMA/33
scsi2 : pata_via
  Vendor: ATA       Model: SAMSUNG SP0802N   Rev: TK10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: IC35L040AVVA07-0  Rev: VA2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover = 10
FIT t.act8b = 10, t.rec8b = 8, t.active = 9, t.recover = 9
ata4: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata4: dev 0 ATAPI, max UDMA/33
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover = 10
FIT t.act8b = 10, t.rec8b = 8, t.active = 9, t.recover = 9
ata4: dev 1 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
ata4: dev 1 ATAPI, max UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 3, t.recover = 1
FIT t.act8b = 10, t.rec8b = 8, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 11, t.rec8b = 9, t.active = 3, t.recover = 1
FIT t.act8b = 10, t.rec8b = 8, t.active = 2, t.recover = 0
ata4: dev 0 configured for UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
ata4: qc timeout (cmd 0xef)
ata4: failed to set xfermode, disabled
ata4: dev 1 configured for UDMA/33
scsi3 : pata_via
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 156368016 512-byte hdwr sectors (80060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156368016 512-byte hdwr sectors (80060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 >
sd 2:0:0:0: Attached scsi disk sdb
SCSI device sdc: 80418240 512-byte hdwr sectors (41174 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 80418240 512-byte hdwr sectors (41174 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 >
sd 2:0:1:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:1:0: Attached scsi generic sg2 type 0

