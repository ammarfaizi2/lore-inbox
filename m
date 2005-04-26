Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVDZPGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVDZPGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDZPGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:06:13 -0400
Received: from [62.206.217.67] ([62.206.217.67]:22915 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261564AbVDZPFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:05:09 -0400
Message-ID: <426E5889.8060108@trash.net>
Date: Tue, 26 Apr 2005 17:04:41 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ed Tomlinson <tomlins@cam.org>, Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
References: <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net> <20050426135312.GI5098@wotan.suse.de> <426E48C0.9090503@trash.net> <426E4DD2.8060808@trash.net> <20050426142252.GJ5098@wotan.suse.de> <426E5571.8000101@trash.net> <20050426145351.GD13305@wotan.suse.de>
In-Reply-To: <20050426145351.GD13305@wotan.suse.de>
Content-Type: multipart/mixed;
 boundary="------------020109020508020004050100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020109020508020004050100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> It is Checking NMI watchdog .... if you see "stuck" after that it is
> broken. Or do the NMIs actually increase when you make the machine
> busy (run while true ; do true ; done on each CPU)?

It increases at about 1 interrupt/sec. I've attached the dmesg output
from booting.


--------------020109020508020004050100
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Bootdata ok (command line is root=/dev/md0 ro netconsole=4444@172.16.1.123/eth0,6666@172.16.195.3/ff:ff:ff:ff:ff:ff )
Linux version 2.6.12-rc3-2005-04-26 (kaber@kaber) (gcc-Version 3.3.5 (Debian 1:3.3.5-12)) #4 Tue Apr 26 16:07:53 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
 BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
 BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000faac0
ACPI: XSDT (v001 A M I  OEMXSDT  0x08000403 MSFT 0x00000097) @ 0x000000007ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x08000403 MSFT 0x00000097) @ 0x000000007ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x08000403 MSFT 0x00000097) @ 0x000000007ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000403 MSFT 0x00000097) @ 0x000000007ff40040
ACPI: DSDT (v001  A0091 A0091006 0x00000006 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 524080
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 519984 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:12 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7ff80000)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Built 1 zonelists
Kernel command line: root=/dev/md0 ro netconsole=4444@172.16.1.123/eth0,6666@172.16.195.3/ff:ff:ff:ff:ff:ff 
netconsole: local port 4444
netconsole: local IP 172.16.1.123
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 172.16.195.3
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2002.579 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2056404k/2096320k available (2487k kernel code, 39224k reserved, 1309k data, 152k init)
Calibrating delay loop... 3923.96 BogoMIPS (lpj=1961984)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
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
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G550 AGP
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 177
sk98lin: Asus mainboard with buggy VPD? Correcting data.
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
netconsole: network logging started
libata version 1.10 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
sata_via(0000:00:0f.0): routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 185
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 185
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
md: raid0 personality registered as nr 2
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:11.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
logips2pp: Detected unknown logitech mouse model 99
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
ALSA device list:
  #0: VIA 8237 with AD1980 at 0xc800, irq 193
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80466480(lo)
IPv6 over IPv4 tunneling driver
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
cpu_init done, current fid 0xc, vid 0x0
powernow-k8: ph2 null fid transition 0xc
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb2
raid0:   comparing sdb2(194378368) with sdb2(194378368)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(194378368) with sdb2(194378368)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 388756736 blocks.
raid0 : conf->hash_spacing is 388756736 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: md0: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 18105388
ext3_orphan_cleanup: deleting unreferenced inode 18105387
ext3_orphan_cleanup: deleting unreferenced inode 18105386
ext3_orphan_cleanup: deleting unreferenced inode 18104335
EXT3-fs: md0: 4 orphan inodes deleted
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
NET: Registered protocol family 1
Adding 979924k swap on /dev/sdb1.  Priority:-1 extents:1
EXT3 FS on md0, internal journal
Generic RTC Driver v1.07
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 185
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVD-ROM PX-116A2 0100, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Probing IDE interface ide1...
hdc: HDS722540VLAT20, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 201, io base 0x0000dc00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 201, io base 0x0000ec00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
eth0: no IPv6 routers present
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 201, io base 0x0000c000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 201, io base 0x0000c400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hdc: max request size: 1024KiB
hdc: 80418240 sectors (41174 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2

--------------020109020508020004050100--
