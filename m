Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263357AbUKBBBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbUKBBBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291534AbUKBAOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:14:08 -0500
Received: from alpha6.its.monash.edu.au ([130.194.1.25]:5639 "EHLO
	ALPHA6.ITS.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id S384619AbUKBAKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:10:14 -0500
Date: Tue, 02 Nov 2004 11:07:21 +1100
From: Damien Moore <damien.moore@its.monash.edu.au>
Subject: SATA drive freezing in 2.6.8.1
To: linux-kernel@vger.kernel.org
Message-id: <4186CFB9.1030201@its.monash.edu.au>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041012
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(I'm not subscribed, because this is a work address.
Please cc - much thanks)

I'm having some difficulties with a Seagate sata drive (ST3200822AS)
when running a 2.6.8.1 kernel. After a seemingly random amount of
time it fails with:

ata1: command 0x25 timeout, stat 0x50 host_stat 0x21
attempt to access beyond end of device
sda1: rw=0, want=28160918024, limit=390716802
attempt to access beyond end of device
sda1: rw=0, want=29781576712, limit=390716802
attempt to access beyond end of device
sda1: rw=0, want=29964810632, limit=390716802
attempt to access beyond end of device
sda1: rw=0, want=25778715784, limit=390716802
ATA: abnormal status 0x80 on port 0xEFE7
ATA: abnormal status 0x80 on port 0xEFE7
ATA: abnormal status 0x80 on port 0xEFE7

It took a while to pin down that it was actually the drive, because
the only partition on it was NFS mounted to an older machine for a
while.I'm concerned that there may be a hardware fault, because
the first time it happened I restored everything and tried to give it
some heavy work and everything was fine - but 3 weeks later it died
with the same error twice in a row.

I'm going to try and go to 2.6.10, but if anyone has any help,
it would be very appreciated - the machine seems to only fail when
I'm trying to use it remotely, so its fairly frustrating.

thanks in advance,
Damien

dmesg at bootup:

I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=302
Initializing CPU#0
CPU 0 irqstacks, hard=c0483000 soft=c0482000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2998.841 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513964k/523456k available (2255k kernel code, 8724k reserved, 
1170k data
, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5931.00 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2998.0069 MHz.
..... host bus clock speed is 199.0871 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1099353325.581:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: VIA VT86C100A Rhine at 0xd880, 00:50:ba:05:e6:37, IRQ 10.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct15 30, ATA DISK drive
hdb: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58680720 sectors (30044 MB) w/418KiB Cache, CHS=58215/16/63, UDMA(66)
  hda: hda1 hda2 hda3 hda4
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=65535/16/63, UDMA(100)
  hdb: hdb1
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 5
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 5
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
  sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
uhci_hcd 0000:00:1d.0: port 2 portsc 0093
hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
es1371: version v0.32 time 22:07:56 Oct 11 2004
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 5 (level, low) -> IRQ 5
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xdf00 irq 5 joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4089 buckets, 32712 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/proje
cts/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 140k freed


