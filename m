Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVHJP2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVHJP2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVHJP2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:28:35 -0400
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:29376 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965160AbVHJP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:28:34 -0400
X-IronPort-AV: i="3.96,96,1122868800"; 
   d="scan'208"; a="1416213516:sNHT18965500"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17146.7454.818003.464185@smtp.charter.net>
Date: Wed, 10 Aug 2005 11:28:30 -0400
From: "John Stoffel" <john@stoffel.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: John Stoffel <john@stoffel.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <1123635010.5170.75.camel@mulgrave>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	<200508081954.52638.jesper.juhl@gmail.com>
	<17145.1417.329260.524528@smtp.charter.net>
	<1123617516.5170.42.camel@mulgrave>
	<17145.3629.933024.963438@smtp.charter.net>
	<1123635010.5170.75.camel@mulgrave>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

As a test, I dropped back to 2.6.12.1 and the drive hung again last
night while trying to do backups, so I suspect that I might have
controller or tape drive problems of some sort.  I'll also try to go
back to 2.6.12-rc6 as well and see how that works out.

My next step is to try and get the tape drive to be read/written with
just plain dd or tar and to see if that helps or not.

It could also be my backup software (bacula) is doing something
strange to the drive when it writes data, but I doubt it.

Is there any more info I can provide here for you?  dmesg output?
Here's the latest output from dmesg with the lockup of the drive,
which takes a power cycle to clear now.

Linux version 2.6.12.1 (john@jfsnew) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #63 SMP Sat Jul 16 00:15:30 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 196606
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192510 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdee0
ACPI: RSDT (v001 DELL    WS 610  0x00000002 ASL  0x00000061) @ 0x000fdef4
ACPI: FADT (v001 DELL    WS 610  0x00000002 ASL  0x00000061) @ 0x000fdf20
ACPI: MADT (v001 DELL    WS 610  0x00000002 ASL  0x00000061) @ 0x000fdf94
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
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
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro console=tty0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 547.379 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774076k/786424k available (2740k kernel code, 11784k reserved, 1234k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1081.34 BogoMIPS (lpj=540672)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay loop... 1089.53 BogoMIPS (lpj=544768)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2170.88 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 03
  groups: 01 02
CPU1 attaching sched-domain:
 domain 0: span 03
  groups: 02 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfca1e, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Cyclades driver 2.3.2.20 2004/02/25 18:14:16
        built Jul 15 2005 23:59:30
Cyclom-Y/ISA #1: 0xc00de000-0xc00dffff, IRQ11, 8 channels starting from port 0.
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440GX Chipset.
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G400 AGP
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:06' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:07' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd480. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: SAMSUNG CDRW/DVD SM-352B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
HPT302: IDE controller at PCI slot 0000:00:0d.0
PCI: Enabling device 0000:00:0d.0 (0105 -> 0107)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
HPT302: chipset revision 1
HPT37X: using 33MHz PCI clock
HPT302: 100% native mode on irq 16
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
hde: WDC WD1200JB-00CRA1, ATA DISK drive
ide2 at 0xdcd8-0xdcdf,0xdcd2 on irq 16
Probing IDE interface ide3...
hdg: WDC WD1200JB-00EVA0, ATA DISK drive
ide3 at 0xdcc0-0xdcc7,0xdcba on irq 16
Probing IDE interface ide1...
Probing IDE interface ide4...
Probing IDE interface ide5...
hde: max request size: 128KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes not supported
 hde: hde1
hdg: max request size: 1024KiB
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1
hda: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: COMPAQ    Model: HC01841729        Rev: 3208
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
 target0:0:0: Domain Validation skipping write tests
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
 target0:0:0: Ending Domain Validation
  Vendor: COMPAQ    Model: BD018222CA        Rev: B016
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:1): 6.600MB/s transfers (16bit)
 target0:0:1: Domain Validation skipping write tests
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
 target0:0:1: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

st: Version 20050312, fixed bufsize 32768, s/g segs 256
SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:03:08.2[C] -> GSI 16 (level, low) -> IRQ 16
ehci_hcd 0000:03:08.2: NEC Corporation USB 2.0
ehci_hcd 0000:03:08.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:03:08.2: irq 16, io mem 0xfaffdc00
ehci_hcd 0000:03:08.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1112.000 MB/sec
raid5: using function: pIII_sse (1112.000 MB/sec)
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
input: AT Translated Set 2 keyboard on isa0060/serio0
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 228k freed
kjournald starting.  Commit interval 5 seconds
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Adding 996020k swap on /dev/sda3.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
md: md0 stopped.
md: bind<hdg1>
md: bind<hde1>
raid1: raid set md0 active with 2 out of 2 mirrors
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
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
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:07.2: Intel Corporation 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.2: irq 19, io base 0x0000dce0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: not running at top speed; connect to a high speed hub
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 1 alt 0 proto 2 vid 0x04B8 pid 0x0803
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:03:08.0: NEC Corporation USB
ohci_hcd 0000:03:08.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:03:08.0: irq 18, io mem 0xfafff000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:03:08.1[B] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:08.1: NEC Corporation USB (#2)
ohci_hcd 0000:03:08.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:03:08.1: irq 19, io mem 0xfaffe000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
  Vendor: EPSON     Model: Stylus Storage    Rev: 1<6>ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
.0<6>ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
0
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdc at scsi2, channel 0, id 0, lun 0
usb-storage: device scan complete
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[faffd000-faffd7ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[005042b500016243]
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
  Vendor: SUN       Model: DLT7000           Rev: 1E48
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target1:0:6: Beginning Domain Validation
WIDTH IS 1
(scsi1:A:6): 6.600MB/s transfers (16bit)
 target1:0:6: Domain Validation skipping write tests
(scsi1:A:6): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
 target1:0:6: Ending Domain Validation
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Attached scsi generic sg3 at scsi1, channel 0, id 6, lun 0,  type 1
st0: Block limits 2 - 16777214 bytes.
st0: MTSETDRVBUFFER only allowed for root.
scsi1:0:6:0: Attempting to queue an ABORT message
CDB: 0x11 0x1 0x7f 0xff 0xff 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State in Command phase, at SEQADDR 0x156
Card was paused
ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x84]:(BSYI|CDI) ERROR[0x0] SCSIBUSL[0xc0] 
LASTPHASE[0x80]:(CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x88]:(WIDEXFER) 
SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0x0] SSTAT0[0x7]:(DMADONE|SPIORDY|SDONE) 
SSTAT1[0x2]:(PHASECHG) SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x4]:(DIRECTION) 
DFSTATUS[0x6d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP|DFCACHETH) 
STACK: 0x37 0x0 0x150 0x191
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
SCB_TAG[0x2] 
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Pending list: 
  2 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
Kernel Free SCB list: 1 0 
Untagged Q(6): 2 

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi1:0:6:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi1:0:6:0: Attempting to queue a TARGET RESET message
CDB: 0x11 0x1 0x7f 0xff 0xff 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 6 lun 0
st0: Error 10000 (sugg. bt 0x0, driver bt 0x0, host bt 0x1).
scsi1 (6:0): rejecting I/O to offline device
