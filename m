Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUFDWDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUFDWDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUFDWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:03:39 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:55236 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265981AbUFDWCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:02:24 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2: serial console affects local keyboard on a dual Opteron system
Date: Fri, 4 Jun 2004 23:57:28 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Message-Id: <200406042355.50562.rjwysocki@sisk.pl>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IBPwA/aY3MyZz8o"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_IBPwA/aY3MyZz8o
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Testing the 2.6.7-rc2 kernel I observed that on my dual Opteron system the 
local keyboard is effectively broken (ie. the keys are apparently not 
registered or they are repreated excessively by the kernel) when the serial 
console is connected (ie. it suffices to unplug the cable from the computer 
serial port to prevent this).

Attached are: the serial console log, hardware environment info, software 
environment info.

Yours,
rjw


--Boundary-00=_IBPwA/aY3MyZz8o
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.6.7-rc2-serial-console.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.7-rc2-serial-console.log"

Bootdata ok (command line is root=/dev/sdb3 vga=792 console=ttyS0,115200 console=tty0 hdc=ide-scsi )
Linux version 2.6.7-rc2 (rafael@chimera) (gcc version 3.4.1 20040508 (prerelease) (SuSE Linux)) #1 SMP Sun May 30 23:34
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
No mptable found.
No mptable found.
setting up node 0 0-1ffff
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
setting up node 1 20000-3fff0
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Kernel command line: root=/dev/sdb3 vga=792 console=ttyS0,115200 console=tty0 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1386.692 MHz processor.
Console: colour dummy device 80x25
Memory: 1029084k/1048512k available (2126k kernel code, 0k reserved, 1090k data, 180k init)
Calibrating delay loop... 2727.93 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 1024.36 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 1003ff93f58
Initializing CPU#1
Calibrating delay loop... 2768.89 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 01
Total of 2 processors activated (5496.83 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.381 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCIB] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
testing the IO APIC.......................



.................................... done.
PCI: Using ACPI for IRQ routing
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
vesafb: framebuffer at 0xe0000000, mapped to 0xffffff000004f000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1086385112.855:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON DVDRW LDW-851S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
sym0: <1010-66> rev 0x1 at pci 0000:02:07.0 irq 26
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: asynchronous.
sym0:0: wide asynchronous.
sym0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
scsi(0:0:0:0): Ending Domain Validation
  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:10:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:10:0): Beginning Domain Validation
sym0:10: wide asynchronous.
sym0:10: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
scsi(0:0:10:0): Ending Domain Validation
3ware Storage Controller device driver for Linux v1.26.00.039.
scsi1 : Found a 3ware Storage Controller at 0x8c00, IRQ: 27, P-chip: 1.3
scsi1 : 3ware Storage Controller
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
ata1: SATA max UDMA/100 cmd 0xFFFFFF0000655C80 ctl 0xFFFFFF0000655C8A bmdma 0xFFFFFF0000655C00 irq 17
ata2: SATA max UDMA/100 cmd 0xFFFFFF0000655CC0 ctl 0xFFFFFF0000655CCA bmdma 0xFFFFFF0000655C08 irq 17
ata3: SATA max UDMA/100 cmd 0xFFFFFF0000655E80 ctl 0xFFFFFF0000655E8A bmdma 0xFFFFFF0000655E00 irq 17
ata4: SATA max UDMA/100 cmd 0xFFFFFF0000655EC0 ctl 0xFFFFFF0000655ECA bmdma 0xFFFFFF0000655E08 irq 17
ata1: no device found (phy stat 00000000)
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
ata3: no device found (phy stat 00000000)
scsi4 : sata_sil
ata4: no device found (phy stat 00000000)
scsi5 : sata_sil
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 >
Attached scsi disk sdb at scsi0, channel 0, id 10, lun 0
SCSI device sdc: 156365968 512-byte hdwr sectors (80059 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 >
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   generic_sse:  4204.000 MB/sec
raid5: using function: generic_sse (4204.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 440 bytes per conntrack
NET: Registered protocol family 1
NET: Registered protocol family 15
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
md: raidstart(pid 651) used deprecated START_ARRAY ioctl. This will not be supported beyond 2.6
md: invalid raid superblock magic on sdc7
md: sdc7 has invalid sb, not importing!
md: could not import sdc7!
md: autostart unknown-block(0,2087) failed!
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on sdb3, internal journal
EXT3 FS on sdb3, internal journal
Adding 1001464k swap on /dev/sda2.  Priority:42 extents:1
Adding 525304k swap on /dev/sdb2.  Priority:42 extents:1
EXT3 FS on sdb3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi6 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: JLMS      Model: XJ-HD166S         Rev: DS18
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi7 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: DVDRW LDW-851S    Rev: GS08
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 10, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi6, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg4 at scsi7, channel 0, id 0, lun 0,  type 5
inserting floppy driver for 2.6.7-rc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ip_tables: (C) 2000-2002 Netfilter core team
tg3.c:v3.5 (May 25, 2004)
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:a0:bf
eth0: HostTXDS[0] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[fc8ff000-fc8ff7ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:03:0a.2: NEC Corporation USB 2.0
ehci_hcd 0000:03:0a.2: irq 18, pci mem ffffff0000757800
ehci_hcd 0000:03:0a.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:03:0a.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd 0000:03:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:03:00.0: irq 19, pci mem ffffff000076f000
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:03:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:03:00.1: irq 19, pci mem ffffff0000771000
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ohci_hcd 0000:03:0a.0: NEC Corporation USB
ohci_hcd 0000:03:0a.0: irq 16, pci mem ffffff0000773000
ohci_hcd 0000:03:0a.0: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
ohci_hcd 0000:03:0a.1: NEC Corporation USB (#2)
ohci_hcd 0000:03:0a.1: irq 17, pci mem ffffff0000775000
ohci_hcd 0000:03:0a.1: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver


--Boundary-00=_IBPwA/aY3MyZz8o
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="hardware.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hardware.log"

chimera:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1386.744
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 2727.93
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1386.744
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 2768.89
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

chimera:~ # cat /proc/modules
snd_seq 62848 1 - Live 0xffffffffa01a7000
ipt_TCPMSS 4736 1 - Live 0xffffffffa01a4000
ipt_TOS 3008 18 - Live 0xffffffffa01a2000
usbserial 30900 0 - Live 0xffffffffa0199000
ipt_MASQUERADE 5376 1 - Live 0xffffffffa0196000
ipt_LOG 7040 87 - Live 0xffffffffa0193000
ipt_state 2560 75 - Live 0xffffffffa0191000
parport_pc 40128 1 - Live 0xffffffffa0186000
lp 12392 0 - Live 0xffffffffa017f000
parport 46220 2 parport_pc,lp, Live 0xffffffffa0172000
ppp_generic 29728 0 - Live 0xffffffffa0169000
slhc 8256 1 ppp_generic, Live 0xffffffffa0165000
snd_pcm_oss 66024 0 - Live 0xffffffffa0153000
snd_mixer_oss 21504 1 snd_pcm_oss, Live 0xffffffffa014c000
snd_ioctl32 17984 0 - Live 0xffffffffa0146000
snd_intel8x0 39956 5 - Live 0xffffffffa013b000
snd_ac97_codec 78724 1 snd_intel8x0, Live 0xffffffffa0126000
snd_pcm 116896 4 snd_pcm_oss,snd_ioctl32,snd_intel8x0, Live 0xffffffffa0108000
snd_timer 28680 2 snd_seq,snd_pcm, Live 0xffffffffa00ff000
snd_page_alloc 14160 2 snd_intel8x0,snd_pcm, Live 0xffffffffa00fa000
gameport 5184 1 snd_intel8x0, Live 0xffffffffa00f7000
snd_mpu401_uart 9536 1 snd_intel8x0, Live 0xffffffffa00f3000
snd_rawmidi 29440 1 snd_mpu401_uart, Live 0xffffffffa00ea000
snd_seq_device 9804 2 snd_seq,snd_rawmidi, Live 0xffffffffa00e6000
snd 70184 21 snd_seq,snd_pcm_oss,snd_mixer_oss,snd_ioctl32,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xffffffffa00d3000
soundcore 11168 1 snd, Live 0xffffffffa00cf000
eth1394 22352 0 - Live 0xffffffffa00c8000
usblp 14080 0 - Live 0xffffffffa00c3000
ohci_hcd 21828 0 - Live 0xffffffffa00bc000
ehci_hcd 29636 0 - Live 0xffffffffa00b3000
usbcore 121656 6 usbserial,usblp,ohci_hcd,ehci_hcd, Live 0xffffffffa0094000
raw1394 28312 0 - Live 0xffffffffa008c000
ohci1394 34180 0 - Live 0xffffffffa0082000
ieee1394 116472 3 eth1394,raw1394,ohci1394, Live 0xffffffffa0064000
tg3 82692 0 - Live 0xffffffffa004e000
ipt_REJECT 7232 3 - Live 0xffffffffa004b000
iptable_mangle 3520 1 - Live 0xffffffffa0049000
iptable_filter 3456 1 - Live 0xffffffffa0047000
ip_nat_ftp 6672 0 - Live 0xffffffffa0044000
iptable_nat 32572 3 ipt_MASQUERADE,ip_nat_ftp, Live 0xffffffffa003b000
ip_tables 21952 9 ipt_TCPMSS,ipt_TOS,ipt_MASQUERADE,ipt_LOG,ipt_state,ipt_REJECT,iptable_mangle,iptable_filter,iptable_nat, Live 0xffffffffa0034000
floppy 64984 0 - Live 0xffffffffa0023000
sg 41464 0 - Live 0xffffffffa0017000
sr_mod 19684 0 - Live 0xffffffffa0011000
cdrom 39016 1 sr_mod, Live 0xffffffffa0006000
ide_scsi 18628 0 - Live 0xffffffffa0000000
chimera:~ # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5008-500b : ACPI timer
5010-5015 : ACPI CPU throttle
8000-8fff : PCI Bus #02
  8800-88ff : 0000:02:07.0
    8800-88ff : sym53c8xx
  8c00-8c0f : 0000:02:08.0
    8c00-8c0f : 3ware Storage Controller
9000-9fff : PCI Bus #03
  9400-940f : 0000:03:0b.0
    9400-940f : sata_sil
  9480-9483 : 0000:03:0b.0
    9480-9483 : sata_sil
  9800-9807 : 0000:03:0b.0
    9800-9807 : sata_sil
  9880-9883 : 0000:03:0b.0
    9880-9883 : sata_sil
  9c00-9c07 : 0000:03:0b.0
    9c00-9c07 : sata_sil
b480-b49f : 0000:00:07.2
b800-b8ff : 0000:00:07.5
  b800-b8ff : AMD AMD8111 - AC'97
bc00-bc3f : 0000:00:07.5
  bc00-bc3f : AMD AMD8111 - Controller
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
chimera:~ # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000cf800-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0031397c : Kernel code
  0031397d-00424560 : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
daf00000-daffffff : PCI Bus #01
db000000-db0fffff : PCI Bus #02
db100000-db1fffff : PCI Bus #03
db300000-eb3fffff : PCI Bus #05
  e0000000-e7ffffff : 0000:05:00.0
    e0000000-e05fffff : vesafb
f0000000-f7ffffff : 0000:04:00.0
  f0000000-f7ffffff : aperture
fb500000-fb5fffff : PCI Bus #01
fb600000-fc6fffff : PCI Bus #02
  fb800000-fbffffff : 0000:02:08.0
  fc6dc000-fc6ddfff : 0000:02:07.0
    fc6dc000-fc6ddfff : sym53c8xx
  fc6df800-fc6dfbff : 0000:02:07.0
    fc6df800-fc6dfbff : sym53c8xx
  fc6dfc00-fc6dfc0f : 0000:02:08.0
  fc6f0000-fc6fffff : 0000:02:09.0
    fc6f0000-fc6fffff : tg3
fc700000-fc8fffff : PCI Bus #03
  fc8f7000-fc8f7fff : 0000:03:00.0
    fc8f7000-fc8f7fff : ohci_hcd
  fc8f8000-fc8fbfff : 0000:03:0c.0
  fc8fc000-fc8fcfff : 0000:03:00.1
    fc8fc000-fc8fcfff : ohci_hcd
  fc8fd000-fc8fdfff : 0000:03:0a.0
    fc8fd000-fc8fdfff : ohci_hcd
  fc8fe000-fc8fefff : 0000:03:0a.1
    fc8fe000-fc8fefff : ohci_hcd
  fc8ff000-fc8ff7ff : 0000:03:0c.0
    fc8ff000-fc8ff7ff : ohci1394
  fc8ff800-fc8ff8ff : 0000:03:0a.2
    fc8ff800-fc8ff8ff : ehci_hcd
  fc8ffc00-fc8fffff : 0000:03:0b.0
    fc8ffc00-fc8fffff : sata_sil
fc9fe000-fc9fefff : 0000:00:0a.1
fc9ff000-fc9fffff : 0000:00:0b.1
fca00000-feafffff : PCI Bus #05
  fd000000-fdffffff : 0000:05:00.0
ff7c0000-ffffffff : reserved
chimera:~ # lspci -vvv
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fc700000-fc8fffff
        Prefetchable memory behind bridge: db100000-db1fffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 19
        Region 0: I/O ports at b480 [size=32]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
        Subsystem: Tyan Computer: Unknown device 2885
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at b800 [size=256]
        Region 1: I/O ports at bc00 [size=64]

00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fb600000-fc6fffff
        Prefetchable memory behind bridge: 00000000db000000-00000000db000000
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc9fe000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fb500000-fb5fffff
        Prefetchable memory behind bridge: 00000000daf00000-00000000daf00000
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc9ff000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

02:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Subsystem: Intel Corp.: Unknown device 7830
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4250ns min, 4500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 26
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at fc6df800 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at fc6dc000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at fc6b0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), cache line size 10
        Interrupt: pin A routed to IRQ 27
        Region 0: I/O ports at 8c00 [size=16]
        Region 1: Memory at fc6dfc00 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at fb800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at fc6c0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gigabit Ethernet (rev 02)
        Subsystem: Tyan Computer: Unknown device 2885
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fc6f0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fc6e0000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 0000400844824000  Data: 0420

03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fc8f7000 (32-bit, non-prefetchable) [size=4K]

03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fc8fc000 (32-bit, non-prefetchable) [size=4K]

03:0a.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 2027:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fc8fd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 2027:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 10
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at fc8fe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Unknown device 2027:0032
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at fc8ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 3114 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3114
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9c00 [size=8]
        Region 1: I/O ports at 9880 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9480 [size=4]
        Region 4: I/O ports at 9400 [size=16]
        Region 5: Memory at fc8ffc00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at fc800000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Tyan Computer: Unknown device 2885
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fc8ff000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at fc8f8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

04:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 13)
        Subsystem: Advanced Micro Devices [AMD] AMD-8151 System Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh+ GART64- HTrans+ 64bit+ FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] #08 [0060]

04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 13) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: db300000-eb3fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

05:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2960
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at feae0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

chimera:~ # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: IBM      Model: IC35L018UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 0   Rev: 1.2
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: JLMS     Model: XJ-HD166S        Rev: DS18
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: DVDRW LDW-851S   Rev: GS08
  Type:   CD-ROM                           ANSI SCSI revision: 02
chimera:~ #


--Boundary-00=_IBPwA/aY3MyZz8o
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="software-2.6.7-rc2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="software-2.6.7-rc2.log"

chimera:~ # cat /proc/version
Linux version 2.6.7-rc2 (rafael@chimera) (gcc version 3.4.1 20040508 (prerelease) (SuSE Linux)) #1 SMP Sun May 30 23:31:13 CEST 2004
chimera:~ # /local/src/rc/linux-2.6.7-rc2/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux chimera 2.6.7-rc2 #1 SMP Sun May 30 23:31:13 CEST 2004 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
binutils               2.14.90.0.5
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.14-pre2
e2fsprogs              1.34
jfsutils               1.1.2
xfsprogs               2.5.6
quota-tools            3.10-pre1.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        x    1 root     root      1534814 Sep 23  2003 /lib64/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         snd_seq ipt_TCPMSS ipt_TOS usbserial ipt_MASQUERADE ipt_LOG ipt_state parport_pc lp parport ppp_generic slhc snd_pcm_oss snd_mixer_oss snd_ioctl32 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore eth1394 usblp ohci_hcd ehci_hcd usbcore raw1394 ohci1394 ieee1394 tg3 ipt_REJECT iptable_mangle iptable_filter ip_nat_ftp iptable_nat ip_tables floppy sg sr_mod cdrom ide_scsi
chimera:~ #


--Boundary-00=_IBPwA/aY3MyZz8o--


