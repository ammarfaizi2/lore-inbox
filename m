Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUITIx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUITIx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 04:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUITIx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 04:53:56 -0400
Received: from pannekoek.uva.nl ([146.50.97.205]:14021 "EHLO PANNEKOEK.uva.nl")
	by vger.kernel.org with ESMTP id S266143AbUITIxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 04:53:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problem with sata_sil driver
Date: Mon, 20 Sep 2004 10:53:40 +0200
Message-ID: <D6BC5FEAAD77B042A0538B278CDDD26A020D9F7A@pannekoek.uva.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with sata_sil driver
Thread-Index: AcSdYDXn514cdfzLQjWi/qyGuYqvCwBjPolw
From: "Hoogervorst, J.W." <J.W.Hoogervorst@uva.nl>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using the sata_sil driver, my system locks up. This is regardless
of
acpi and apic settings (tried all combinations of these two - without
any
luck). All works ok when I use the siimage driver. See below for the
log.
After the final message, the system most times completely locks up. This
is
with an sil3112A chip on a PCI card. Any hints on what else to try when
I
want to use the libsata driver instead of siimage?

(and you can ignore the messages about fd0 - there isn't any, but I
wanted
to make sure there was nothing funny with the IRQ assignment - the sata
card got IRQ6 without it)

Thanks.
Jeroen Hoogervorst

----------8<---------8<---------8<---------8<---------8<---------8<-----
----
Linux version 2.6.8.1-jwh2 (root@hogthrob) (gcc version 3.3.2 (Mandrake
Linux 10.0 3.3.2-6mdk)) #10 SMP Fri Sep 17 20:17:25 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffeb000 (usable)
 BIOS-e820: 000000000ffeb000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65515
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61419 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @
0x000f7b40
ACPI: RSDT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @
0x0ffeb000
ACPI: FADT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @
0x0ffeb100
ACPI: BOOT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @
0x0ffeb040
ACPI: DSDT (v001   ASUS TUSL2-C  0x00001000 MSFT 0x0100000b) @
0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: root=/dev/sda5 devfs=mount video=vesafb:off
video=rivafb:off video=radeonfb:off
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 801.957 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254940k/262060k available (2170k kernel code, 6400k reserved,
1191k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 1589.24 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Celeron (Coppermine) stepping 0a
per-CPU timeslice cutoff: 366.07 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 801.0688 MHz.
..... host bus clock speed is 100.0211 MHz.
Brought up 1 CPUs
CPU0:  online
 domain 0: span 1
  groups: 1
  domain 1: span 1
   groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0e30, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-0165: *** Error: No object was returned from
[\_SB_.PCI0.PX40.UAR2._STA] (Node c12fbb20), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbfd0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc000, dseg 0xf0000
pnp: 00:12: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
pnp: 00:12: ioport range 0xec00-0xec3f has been reserved
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:0c.1[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:0d.2[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 5 (level, low) -> IRQ 5
agpgart: Detected an Intel i815 Chipset, but could not find the
secondary device.
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1095505492.084:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA DVD-ROM SD-M1302, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LS-120 F200 08 UHD Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
Loading Adaptec I2O RAID: Version 2.4 Build 5go
Detecting Adaptec I2O RAID controllers...
ACPI: PCI interrupt 0000:02:0c.1[A] -> GSI 9 (level, low) -> IRQ 9
Adaptec I2O RAID controller 0 at d0821000 size=100000 irq=9
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001    
TID 519  Vendor: ADAPTEC      Device: RAID-1       Rev: 370F        
scsi0 : Vendor: Adaptec  Model: 2100S            FW:370F
  Vendor: ADAPTEC   Model: RAID-1            Rev: 370F
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 35842048 512-byte hdwr sectors (18351 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 > p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
PM: Reading pmdisk image.
PM: Resume from disk failed.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0,
recovered transactions 4511 to 4573
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 1608 and
revoked 0/1 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 208k freed
SysRq : Changing Loglevel
Loglevel set to 9
EXT3 FS on sda5, internal journal
Adding 473876k swap on /dev/sda6.  Priority:-1 extents:1
NET: Registered protocol family 17
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip0:  MII transceiver #1 config 3100 status 782d advertising 05e1.
tulip0:  Advertising 01e1 on PHY 1, previously advertising 05e1.
eth0: Digital DS21140 Tulip rev 34 at 0xd0961000, 00:20:18:xx:xx:xx, IRQ
9.
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 9 (level, low) -> IRQ 9
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb800. Vers LK1.1.19
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
inserting floppy driver for 2.6.8.1-jwh2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:0d.2[B] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]
MMIO=[e8800000-e88007ff]  Max Packet=[2048]
ACPI: Processor [CPU0] (supports C1)
ACPI: Power Button (FF) [PWRF]
ide-floppy driver 0.99.newide
hdc: No disk in drive
hdc: 123264kB, 963/8/32 CHS, 533 kBps, 512 sector size, 720 rpm
eth0: Setting full-duplex based on MII#1 link partner capability of
45e1.
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
lp: driver loaded but no devices found
SysRq : Changing Loglevel
Loglevel set to 9
end_request: I/O error, dev fd0, sector 0
libata version 1.02 loaded.
sata_sil version 0.54
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 5 (level, low) -> IRQ 5
ata1: SATA max UDMA/100 cmd 0xD09E5080 ctl 0xD09E508A bmdma 0xD09E5000
irq 5
ata2: SATA max UDMA/100 cmd 0xD09E50C0 ctl 0xD09E50CA bmdma 0xD09E5008
irq 5
ata1: no device found (phy stat 00000000)
scsi1 : sata_sil
irq 5: nobody cared!
 [<c0106b0a>] __report_bad_irq+0x2a/0x90
 [<c0106c25>] note_interrupt+0x95/0xc0
 [<c0106f70>] do_IRQ+0x150/0x1a0
 [<c0104f28>] common_interrupt+0x18/0x20
 [<c0106a90>] handle_IRQ_event+0x30/0x80
 [<c0106ed5>] do_IRQ+0xb5/0x1a0
 [<c0104f28>] common_interrupt+0x18/0x20
 [<c012286b>] __do_softirq+0x4b/0xd0
 [<c012291d>] do_softirq+0x2d/0x30
 [<c0106f7a>] do_IRQ+0x15a/0x1a0
 [<c0104f28>] common_interrupt+0x18/0x20
 [<c01e007b>] dummy_inode_setxattr+0x3b/0x60
 [<c01116c8>] delay_pmtmr+0x18/0x20
 [<c01e7e92>] __delay+0x12/0x20
 [<d0a1c483>] ata_busy_sleep+0x23/0x140 [libata]
 [<d0a1bc86>] ata_dev_identify+0x106/0x610 [libata]
 [<c01e7e92>] __delay+0x12/0x20
 [<d0a1c956>] ata_bus_reset+0x136/0x240 [libata]
 [<d0a1c3a8>] sata_phy_reset+0x138/0x140 [libata]
 [<d0a1c1c9>] ata_bus_probe+0x39/0xd0 [libata]
 [<d0a1e8c3>] ata_device_add+0x1c3/0x260 [libata]
 [<d09f4551>] sil_init_one+0x2a1/0x350 [sata_sil]
 [<c01ec732>] pci_device_probe_static+0x52/0x70
 [<c01ec78c>] __pci_device_probe+0x3c/0x50
 [<c01ec7cc>] pci_device_probe+0x2c/0x60
 [<c023874f>] bus_match+0x3f/0x80
 [<c02388b2>] driver_attach+0x52/0xa0
 [<c0238e22>] bus_add_driver+0x92/0xd0
 [<c01eca8e>] pci_register_driver+0x6e/0xa0
 [<d09b900f>] sil_init+0xf/0x1b [sata_sil]
 [<c0138aca>] sys_init_module+0x12a/0x280
 [<c01045bb>] syscall_call+0x7/0xb
handlers:
[<d0a1e090>] (ata_interrupt+0x0/0x210 [libata])
Disabling IRQ #5
ohci1394: fw-host0: Waking dma ctx=0 ... processing is probably too slow
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi2 : sata_sil
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host2/bus0/target0/lun0:<3>ata2: command 0x25 timeout, stat
0x50 host_stat 0x64



