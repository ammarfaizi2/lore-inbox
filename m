Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWEOCqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWEOCqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 22:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEOCqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 22:46:46 -0400
Received: from mxsf06.cluster1.charter.net ([209.225.28.206]:452 "EHLO
	mxsf06.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751410AbWEOCqp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 22:46:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <17511.60306.178821.982965@smtp.charter.net>
Date: Sun, 14 May 2006 22:46:42 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kevin Radloff <radsaq@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Updated libata PATA patch
In-Reply-To: <17507.62542.780940.914596@smtp.charter.net>
References: <1147196676.3172.133.camel@localhost.localdomain>
	<3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	<1147270145.17886.42.camel@localhost.localdomain>
	<17507.62542.780940.914596@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John> Alan,

John> I just tried to use the IDE2 patches to 2.6.17-rc3 tonight.
John> I've got an old Dell Precision 610, Dual 550Mhz Xeon, 768mb of
John> RAM.  My root disk is SCSI, with hda a Samsung DVD/ROM, CDRW
John> drive.  I've got an HPT302 controller with a pair of 120gb IDE
John> disks.  I've also got an addon PCI USB/Firewire Card, an old
John> Cyclom-Y ISA serial port card, Matrox G450 AGP card, builtin
John> Adaptec SCSI cards, DLT 7000 tape drive.  Probably other stuff
John> as well.

I've got more details now, I managed to setup a serial console on
another machine and captured the bootup process, along with the
various timeouts and such I get on bootup.  I couldn't actually get
the system to come up enough so I could login, and when I was done
rebooting, I had to re-sync my RAID1 array, so I'm a little hesitant
to push it.   Even with backups.

Here's the bootup log, edited to remove some Device Mapper debug messages.
---------------------------------------------------------------------------

Linux version 2.6.17-rc3-IDE2 (john@jfsnew) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #8 SMP PREEMPT Thu May 11 21:51:51 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
early console enabled
767MB LOWMEM available.
found SMP MP-table at 000fe710
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
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro console=tty0 console=ttyS0,9600n8 earlyprintk=serial
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 547.232 MHz processor.
Using pmtmr for high-res timesource
disabling early console
Linux version 2.6.17-rc3-IDE2 (john@jfsnew) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #8 SMP PREEMPT Thu May 11 21:51:51 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
early console enabled
767MB LOWMEM available.
found SMP MP-table at 000fe710
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
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro console=tty0 console=ttyS0,9600n8 earlyprintk=serial
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 547.232 MHz processor.
Using pmtmr for high-res timesource
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773968k/786424k available (2989k kernel code, 11936k reserved, 1340k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1095.57 BogoMIPS (lpj=2191152)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1094.49 BogoMIPS (lpj=2188993)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2190.07 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=4000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfca1e, last bus=3
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:07.1
PCI quirk: region 0800-083f claimed by PIIX4 ACPI
PCI quirk: region 0850-085f claimed by PIIX4 SMB
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0c: ioport range 0x800-0x85f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: f2000000-f5ffffff
PCI: Bridge: 0000:02:06.0
  IO window: disabled.
  MEM window: fa000000-fbffffff
  PREFETCH window: f1000000-f1ffffff
PCI: Bridge: 0000:00:13.0
  IO window: e000-efff
  MEM window: f8000000-fbffffff
  PREFETCH window: f0000000-f1ffffff
* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
* this time source is slow.  Consider trying other time sources (clock=)
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Cyclades driver 2.3.2.20 2004/02/25 18:14:16
        built May 10 2006 09:47:22
Cyclom-Y/ISA #1: 0xc00de000-0xc00dffff, IRQ11, 8 channels starting from port 0.
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440GX Chipset.
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.2.1 20051102 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at f0802000.
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: COMPAQ    Model: HC01841729        Rev: 3208
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
  Vendor: COMPAQ    Model: BD018222CA        Rev: B016
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: SUN       Model: DLT7000           Rev: 245F
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target1:0:5: Beginning Domain Validation
 target1:0:5: wide asynchronous
 target1:0:5: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
 target1:0:5: Domain Validation skipping write tests
 target1:0:5: Ending Domain Validation
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
scsi2 : ata_piix
  Vendor: SAMSUNG   Model: CDRW/DVD SM-352B  Rev: T806
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
ata2: port disabled. ignoring.
scsi3 : ata_piix
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT302: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
ata3: PATA max UDMA/133 cmd 0xDCD8 ctl 0xDCD2 bmdma 0xD800 irq 16
ata4: PATA max UDMA/133 cmd 0xDCC0 ctl 0xDCBA bmdma 0xD808 irq 16
ata3: dev 0 ATA-5, max UDMA/100, 234441648 sectors: LBA
Find mode for 12 reports C829C62
Find mode for DMA 69 reports 1C6DDC62
ata3: dev 0 configured for UDMA/100
scsi4 : hpt37x
ata4: dev 0 ATA-6, max UDMA/100, 234441648 sectors: LBA48
Find mode for 12 reports C829C62
Find mode for DMA 69 reports 1C6DDC62
ata4: dev 0 configured for UDMA/100
scsi5 : hpt37x
  Vendor: ATA       Model: WDC WD1200JB-00C  Rev: 17.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD1200JB-00E  Rev: 15.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 1:0:5:0: Attached scsi tape st0<4>st0: try direct i/o: yes (alignment 512 B)
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
sd 0:0:1:0: Attached scsi disk sdb
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 4:0:0:0: Attached scsi disk sdc
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 5:0:0:0: Attached scsi disk sdd
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
st 1:0:5:0: Attached scsi generic sg2 type 1
 2:0:0:0: Attached scsi generic sg3 type 5
sd 4:0:0:0: Attached scsi generic sg4 type 0
sd 5:0:0:0: Attached scsi generic sg5 type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:03:08.2[C] -> GSI 16 (level, low) -> IRQ 16
ehci_hcd 0000:03:08.2: EHCI Host Controller
ehci_hcd 0000:03:08.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:03:08.2: irq 16, io mem 0xfaffdc00
ehci_hcd 0000:03:08.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
input: AT Translated Set 2 keyboard as /class/input/input0
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1105.000 MB/sec
raid5: using function: pIII_sse (1105.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
EDAC MC: Ver: 2.0.0 May 10 2006
NET: Registered protocol family 2
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda1
md: sda1 has invalid sb, not importing!
md: invalid raid superblock magic on sda2
md: sda2 has invalid sb, not importing!
md: invalid raid superblock magic on sda5
md: sda5 has invalid sb, not importing!
md: invalid raid superblock magic on sda6
md: sda6 has invalid sb, not importing!
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: sdb6 has different UUID to sdd1
md: sdb5 has different UUID to sdd1
md: sdb3 has different UUID to sdd1
md: sdb2 has different UUID to sdd1
md: sdb1 has different UUID to sdd1
md: created md0
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md: sdb1 has different UUID to sdb6
md: created md6
md: bind<sdb6>
md: running: <sdb6>
raid1: raid set md6 active with 1 out of 2 mirrors
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb3 has different UUID to sdb5
md: sdb2 has different UUID to sdb5
md: sdb1 has different UUID to sdb5
md: created md5
md: bind<sdb5>
md: running: <sdb5>
raid1: raid set md5 active with 1 out of 2 mirrors
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md: created md3
md: bind<sdb3>
md: running: <sdb3>
raid1: raid set md3 active with 1 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md: created md2
md: bind<sdb2>
md: running: <sdb2>
raid1: raid set md2 active with 1 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md: created md1
md: bind<sdb1>
md: running: <sdb1>
raid1: raid set md1 active with 1 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240k freed
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.2: irq 19, io base 0x0000dce0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 3
ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:03:08.0: OHCI Host Controller
ohci_hcd 0000:03:08.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:03:08.0: irq 18, io mem 0xfafff000
sr0: scsi3-mmc drive: 1x/52x writer cd/rw xa/form2 cdda tray
usb 2-2: configuration #1 chosen from 1 choice
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
usb 2-2.1: new full speed USB device using uhci_hcd and address 4
usb usb3: configuration #1 chosen from 1 choice
usb 2-2.1: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
Uniform CD-ROM driver Revision: 3.20
usb 2-2.2: new full speed USB device using uhci_hcd and address 5
usb 2-2.2: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[faffd000-faffd7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:03:08.1[B] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:08.1: OHCI Host Controller
ohci_hcd 0000:03:08.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:03:08.1: irq 19, io mem 0xfaffe000
usb 2-2.3: new full speed USB device using uhci_hcd and address 6
usb 2-2.3: configuration #1 chosen from 1 choice
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
usbcore: registered new driver hiddev
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
Bluetooth: HCI USB driver ver 2.9
ieee1394: sbp2: Try serialize_io=0 for better performance
scsi6 : SBP-2 IEEE-1394
input: HID 0a5c:3502 as /class/input/input2
input: USB HID v1.11 Keyboard [HID 0a5c:3502] on usb-0000:00:07.2-2.2
usbcore: registered new driver hci_usb
input: HID 0a5c:3503 as /class/input/input3
input: USB HID v1.11 Mouse [HID 0a5c:3503] on usb-0000:00:07.2-2.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Forcing SBP-2 max speed down to S100
  Vendor: WDC WD12  Model: 00JB-00CRA1       Rev:     
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
SCSI device sde: 234441648 512-byte hdwr sectors (120034 MB)
sde: Write Protect is off
SCSI device sde: drive cache: write back
SCSI device sde: 234441648 512-byte hdwr sectors (120034 MB)
sde: Write Protect is off
SCSI device sde: drive cache: write back
 sde: sde1
sd 6:0:0:0: Attached scsi disk sde
sd 6:0:0:0: Attached scsi generic sg6 type 14
done.
loadkeys: /etc/console/boottime.kmap.gz:407: addkey called with bad index 256
Setting parameters of disc: (none).
Will now activate swap.
swapon on /dev/sAdding 996020k swap on /dev/sda3.  Priority:-1 extents:1 across:996020k
da3
Done activating swap.
Will now check root file system.
fsck 1.39-WIP (09-Apr-2006)
[/sbin/fsck.ext3 (1) -- /] fsck.eEXT3 FS on sda2, xt3 -a -C0 /dev/internal journal
sda2 
/dev/sda2: clean, 23699/500960 files, 108221/1000046 blocks
Done checking root file system. 
A log will be saved in /var/log/fsck/checkroot if that location is writable.
Setting the system clock..
System Clock set. Local time: Mon May 15 02:13:35 UTC 2006.
Cleaning up ifupdown...done.
Calculating module dependencies...done.
Loading modules...
All modules loaded.
Setting the system clock again..
System Clock set. Local time: Mon May 15 02:13:36 UTC 2006.
Creating device-mapper devices....
Loading device-mapper support.
Starting raid devices: mdadm: No arrays found in config file
done.
Setting up LVM Volume Groups...
Will now check all file systems.
fsck 1.39-WIP (09-Apr-2006)
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /var] fsck.ext3 -a -C0 /dev/sda5 
/dev/sda5: clean, 17796/500960 files, 487143/1000038 blocks (check in 3 mounts)
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a -C0 /dev/sda1 
/dev/sda1: clean, 159/62248 files, 81745/248976 blocks
[/sbin/fsck.ext3 (1) -- /usr] fsck.ext3 -a -C0 /dev/sda6 
/dev/sda6: clean, 307681/1001920 files, 1518808/2000084 blocks
[/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a -C0 /dev/data_vg/home_lv 
/dev/data_vg/home_lv: clean, 592642/6684672 files, 12501822/13369344 blocks
irq 16: nobody cared (try booting with the "irqpoll" option)
 <c013d034> __report_bad_irq+0x24/0x90   <c013d13f> note_interrupt+0x9f/0x260
 <c031ab78> usb_hcd_irq+0x28/0x60   <c013c933> handle_IRQ_event+0x33/0x70
 <c013ca64> __do_IRQ+0xf4/0x100   <c0105909> do_IRQ+0x19/0x30
 <c0103962> common_interrupt+0x1a/0x20   <c0101b80> default_idle+0x0/0x60
 <c0101bac> default_idle+0x2c/0x60   <c0101c48> cpu_idle+0x68/0x90
 <c0542729> start_kernel+0x289/0x400   <c0542230> unknown_bootoption+0x0/0x270
handlers:
[<c0302d20>] (ata_interrupt+0x0/0x150)
[<c031ab50>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #16
ata4: command 0xca timeout, stat 0xff host_stat 0x4
ata4: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=0xff { Busy }
sd 5:0:0:0: SCSI error: return code = 0x8000002
sdd: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0xfffffff
end_request: I/O error, dev sdd, sector 234436415
ata4: command 0xea timeout, stat 0xff host_stat 0x0
ata4: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=0xff { Busy }
raid1: Disk failure on sdd1, disabling device. 
	Operation continuing on 1 devices
ata3: command 0xe7 timeout, stat 0x50 host_stat 0x0
ata3: status=0x50 { DriveReady SeekComplete }
ata3: command 0xca timeout, stat 0x50 host_stat 0x4
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0xdf93746
ata3: command 0xe7 timeout, stat 0x50 host_stat 0x0
ata3: status=0x50 { DriveReady SeekComplete }
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdc1
 disk 1, wo:1, o:0, dev:sdd1
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdc1
ata3: command 0xca timeout, stat 0x50 host_stat 0x4
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0x121e
[/sbin/fsck.ext3 (1) -- /local] fsck.ext3 -a -C0 /dev/data_vg/local_lv 
ata3: command 0xc8 timeout, stat 0x50 host_stat 0x4
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0x50001de
ata3: command 0xe7 timeout, stat 0x50 host_stat 0x0
ata3: status=0x50 { DriveReady SeekComplete }
ata3: command 0xca timeout, stat 0x50 host_stat 0x4
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0xdf93746
ata3: command 0xe7 timeout, stat 0x50 host_stat 0x0
ata3: status=0x50 { DriveReady SeekComplete }

.
.
.

rebooted here and booted back into 2.6.17-rc3.

Any other info I can provide?  

John
