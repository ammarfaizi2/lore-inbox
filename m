Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUA2TZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUA2TZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:25:30 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:8833 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S266303AbUA2TYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:24:51 -0500
Message-ID: <40195C71.8080608@lbl.gov>
Date: Thu, 29 Jan 2004 11:18:09 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Can't boot a 2.6 kernel..
Content-Type: multipart/mixed;
 boundary="------------050409090207030409040505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050409090207030409040505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I'm trying to get a 2.6 kernel to boot on my desktop here at work.

I have tried 3 different kernels - 2.6.1, 2.6.2rc1, and arjanv's 2.6.1 kernel.

After the grub prompt, I get the grub kernel description, and then..

Nothing. Nada. Zip. Zilch.

2.4 kernels boot and works fine; I've attached the dmesg output of one of it's boots.

Any ideas on what to try?

The /proc/cpuinfo shows:

[root@lanshark boot]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2200+
stepping        : 0
cpu MHz         : 1792.044
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3578.26

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) Processor
stepping        : 0
cpu MHz         : 1792.044
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3578.26

--------------050409090207030409040505
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.22-1.2149.nptlsmp (bhcompile@porky.devel.redhat.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 SMP Wed Jan 7 12:48:31 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff6c00 (ACPI data)
 BIOS-e820: 000000003fff6c00 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000f74c0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7460
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x3fff451b
ACPI: FADT (v001 TYAN   GUINNESS 0x06040000 PTEC 0x000f4240) @ 0x3fff6b2e
ACPI: MADT (v001 PTLTD    APIC   0x06040000  LTP 0x00000000) @ 0x3fff6ba2
ACPI: DSDT (v001    AMD  AMDACPI 0x06040000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 Pentium(tm) Pro APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
xAPIC support is not present
Enabling APIC mode: Flat.	Using 1 I/O APICs
Kernel command line: ro root=LABEL=/ hdd=ide-scsi rhgb
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1792.044 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 1031828k/1048512k available (1578k kernel code, 16296k reserved, 1175k data, 164k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 2200+ stepping 00
per-CPU timeslice cutoff: 731.42 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3578.26 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 00
Total of 2 processors activated (7156.53 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-16, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 000 00  1    0    0   0   0    0    0    00
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1791.9813 MHz.
..... host bus clock speed is 265.4779 MHz.
cpu: 0, clocks: 2654779, slice: 884926
CPU0<T0:2654768,T1:1769840,D:2,S:884926,C:2654779>
cpu: 1, clocks: 2654779, slice: 884926
CPU1<T0:2654768,T1:884912,D:4,S:884926,C:2654779>
Starting migration thread for cpu 0
smp_num_cpus: 2.
Starting migration thread for cpu 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I15,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
PCI->APIC IRQ transform: (B1,I5,P0) -> 17
Setting AMD recommended values for PCI bus. It isn't fully PCI standards compliant
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller at PCI slot 00:07.1
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD_IDE: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE (rev 01) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hdb: CDU5211, ATAPI CD/DVD-ROM drive
blk: queue c047f280, I/O limit 4095Mb (mask 0xffffffff)
hdc: IC35L040AVER07-0, ATA DISK drive
hdd: PLEXTOR CD-R PX-W1610A, ATAPI CD/DVD-ROM drive
blk: queue c047f6f4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdc: hdc1 hdc2
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 000000cd]
 [events: 000000cd]
md: autorun ...
md: considering hdc2 ...
md:  adding hdc2 ...
md:  adding hda4 ...
md: created md0
md: bind<hda4,1>
md: bind<hdc2,2>
md: running: <hdc2><hda4>
md: hdc2's event counter: 000000cd
md: hda4's event counter: 000000cd
kmod: failed to exec /sbin/modprobe -s -k md-personality-2, errno = 2
md: personality 2 is not loaded!
md :do_md_run() returned -22
md: md0 stopped.
md: unbind<hdc2,1>
md: export_rdev(hdc2)
md: unbind<hda4,0>
md: export_rdev(hda4)
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 165k freed
VFS: Mounted root (ext2 filesystem).
md: raid0 personality registered as nr 2
Journalled Block Device driver loaded
md: Autodetecting RAID arrays.
 [events: 000000cd]
 [events: 000000cd]
md: autorun ...
md: considering hda4 ...
md:  adding hda4 ...
md:  adding hdc2 ...
md: created md0
md: bind<hdc2,1>
md: bind<hda4,2>
md: running: <hda4><hdc2>
md: hda4's event counter: 000000cd
md: hdc2's event counter: 000000cd
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid0: looking at hda4
raid0:   comparing hda4(30651904) with hda4(30651904)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc2
raid0:   comparing hdc2(39160192) with hda4(30651904)
raid0:   NOT EQUAL
raid0:   comparing hdc2(39160192) with hdc2(39160192)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 0
raid0: checking hda4 ... contained as device 0
  (30651904) is smallest!.
raid0: checking hdc2 ... contained as device 1
raid0: zone->nb_dev: 2, size: 61303808
raid0: current zone offset: 30651904
raid0: zone 1
raid0: checking hda4 ... nope.
raid0: checking hdc2 ... contained as device 0
  (39160192) is smallest!.
raid0: zone->nb_dev: 1, size: 8508288
raid0: current zone offset: 39160192
raid0: done.
raid0 : md_size is 69812096 blocks.
raid0 : conf->smallest->size is 8508288 blocks.
raid0 : nb_zone is 9.
raid0 : Allocating 72 bytes for hash.
md: updating md0 RAID superblock on device
md: hda4 [events: 000000ce]<6>(write) hda4's sb offset: 30651904
md: hdc2 [events: 000000ce]<6>(write) hdc2's sb offset: 39160192
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 164k freed
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xc00dc000, IRQ 19
usb-ohci.c: usb-00:07.4, Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1052248k swap-space (priority -1)
Adding Swap: 1048784k swap-space (priority -2)
hub.c: new USB device 00:07.4-1, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdb: attached ide-cdrom driver.
hdb: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W1610A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
inserting floppy driver for 2.4.22-1.2149.nptlsmp
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0f.0: 3Com PCI 3c980C Python-T at 0x1000. Vers LK1.1.18-ac
 00:e0:81:03:bb:c9, IRQ 18
  product code 0000 rev 00.3 date 00-00-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
00:0f.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
See Documentation/networking/vortex.txt
00:10.0: 3Com PCI 3c980C Python-T at 0x1080. Vers LK1.1.18-ac
 00:e0:81:03:bb:ca, IRQ 19
  product code 0000 rev 00.3 date 00-00-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
00:10.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth1
divert: freeing divert_blk for eth0
divert: freeing divert_blk for eth1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 292 bytes per conntrack
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0f.0: 3Com PCI 3c980C Python-T at 0x1000. Vers LK1.1.18-ac
 00:e0:81:03:bb:c9, IRQ 18
  product code 0000 rev 00.3 date 00-00-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
00:0f.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
See Documentation/networking/vortex.txt
00:10.0: 3Com PCI 3c980C Python-T at 0x1080. Vers LK1.1.18-ac
 00:e0:81:03:bb:ca, IRQ 19
  product code 0000 rev 00.3 date 00-00-00
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
00:10.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth1
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready

--------------050409090207030409040505--
