Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUDSPIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUDSPIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:08:40 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:6032 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S263654AbUDSPHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:07:30 -0400
Date: Mon, 19 Apr 2004 17:07:27 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: LSI Logic FC HBA / mptscsih hang
Message-ID: <20040419150727.GA25544@ii.uib.no>
Mail-Followup-To: "Moore, Eric Dean" <Emoore@lsil.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E570442C522@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570442C522@exa-atlanta.se.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 19, 2004 at 10:53:47AM -0400, Moore, Eric Dean wrote:
> Can you send me full dmesg boot log for the failing 
> system. 

Attached (both working single-cpu boot, and hanging dual-cpu boot).

> Also is the same cables and drives being used
> between this system and the other one that is failing?

It doesn't need any cabling to fail.. It fails both with and without
cables attached. 

> Is the Dell PowerEdge having onboard mpt scsi chip?

No, I moved the adapter from the x330 to the Dell PowerEdge. Didn't
connect the cabling/storage when I booted this system. 


  -jf

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.21-9.0.1.EL (buildsys@builder) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #1 Thu Feb 19 20:23:14 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffec340 (usable)
 BIOS-e820: 000000007ffec340 - 000000007fff0000 (ACPI data)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 524268
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294892 pages.
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=LABEL=/ console=tty0 console=ttyS1,9600
Initializing CPU#0
Detected 1261.372 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2516.58 BogoMIPS
Memory: 2059956k/2097072k available (1526k kernel code, 32496k reserved, 1089k data, 164k init, 1179568k highmem)
zapping low mappings.
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Process timing init...done.
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd61c, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 01
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Total HugeTLB memory allocated, 0
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 131067
aio_setup: sizeof(struct page) = 56
Hugetlbfs mounted.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS1 at 0x02f8 (irq = 3) is a 16550A
ttyS3 at 0x02e8 (irq = 0) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 256 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x0708-0x070f, BIOS settings: hdc:DMA, hdd:DMA
hda: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 344k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Starting timer : 0 0
blk: queue f7fd9e14, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM-ESXS  Model: ST318452LC    !#  Rev: B841
  Type:   Direct-Access                      ANSI SCSI revision: 03
Starting timer : 0 0
blk: queue f7fd9c14, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: FTlV1 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
Starting timer : 0 0
blk: queue f7fd9014, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
Partition check:
 sda: sda1 sda2 sda3
Fusion MPT base driver 2.05.05+
Copyright (c) 1999-2002 LSI Logic Corporation
PCI: Enabling device 01:05.0 (0000 -> 0003)
mptbase: Initiating ioc0 bringup
ioc0: FC919X: Capabilities={Initiator,Target,LAN}
mptbase: 1 MPT adapter found, 1 installed.
Fusion MPT SCSI Host driver 2.05.05+
scsi1 : ioc0: LSIFC919X, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
Starting timer : 0 0
blk: queue f7498814, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
  Vendor: IFT       Model: ES A16F-G         Rev: 331P
  Type:   Direct-Access                      ANSI SCSI revision: 03
Starting timer : 0 0
blk: queue f7498a14, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
mptscsih: ioc0: scsi1: Id=0 Lun=0: Queue depth=31
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 3415035904 512-byte hdwr sectors (1748498 MB)
 sdb: sdb1
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 164k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf88c5000, IRQ 7
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
Adding Swap: 2040244k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
microcode: CPU0 already at revision 28 (current=28)
microcode: freed 2048 bytes
Attached scsi generic sg1 at scsi0, channel 0, id 8, lun 0,  type 3
inserting floppy driver for 2.4.21-9.0.1.EL
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

divert: allocating divert_blk for eth0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

divert: allocating divert_blk for eth1
e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
divert: allocating divert_blk for eth2
eth2: Intel(R) PRO/1000 Network Connection
divert: freeing divert_blk for eth0
divert: freeing divert_blk for eth1
divert: freeing divert_blk for eth2
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 304 bytes per conntrack
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

divert: allocating divert_blk for eth0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

divert: allocating divert_blk for eth1
e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
divert: allocating divert_blk for eth2
eth2: Intel(R) PRO/1000 Network Connection
e1000: eth2 NIC Link is Up 1000 Mbps Full Duplex
lp: driver loaded but no devices found
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 304 bytes per conntrack

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.dualcpuhang"

Linux version 2.4.21-9.0.1.ELsmp (buildsys@builder) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #1 SMP Thu Feb 19 19:57:33 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffec340 (usable)
 BIOS-e820: 000000007ffec340 - 000000007fff0000 (ACPI data)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009e1d0
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 524268
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294892 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: NF 4100R SMP APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Processors: 2
xAPIC support is not present
Enabling APIC mode: Flat.       Using 2 I/O APICs
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=LABEL=/ console=tty0 console=ttyS1,9600
Initializing CPU#0
Detected 1261.373 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2516.58 BogoMIPS
Memory: 2056784k/2097072k available (1685k kernel code, 35668k reserved, 1317k data, 224k init, 1179568k
highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
per-CPU timeslice cutoff: 1462.32 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2516.58 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
Total of 2 processors activated (5033.16 BogoMIPS).
apic 0 pin 9 is an SMI pin!
apic 0 pin 10 is an SMI pin!
apic 1 pin 5 is an SMI pin!
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
..TIMER: vector=0x31 pin1=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................
                                           
 
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1261.3513 MHz.
..... host bus clock speed is 132.7737 MHz.
cpu: 0, clocks: 1327737, slice: 442579
CPU0<T0:1327728,T1:885136,D:13,S:442579,C:1327737>
cpu: 1, clocks: 1327737, slice: 442579
CPU1<T0:1327728,T1:442560,D:10,S:442579,C:1327737>
zapping low mappings.
Process timing init...done.
Starting migration thread for cpu 0
Starting migration thread for cpu 1
PCI: PCI BIOS revision 2.10 entry at 0xfd61c, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I2,P0) -> 27
PCI->APIC IRQ transform: (B0,I10,P0) -> 25
PCI->APIC IRQ transform: (B0,I15,P0) -> 7
PCI->APIC IRQ transform: (B1,I3,P0) -> 28
PCI->APIC IRQ transform: (B1,I6,P0) -> 18
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Total HugeTLB memory allocated, 0
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 131067
aio_setup: sizeof(struct page) = 60
Hugetlbfs mounted.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS1 at 0x02f8 (irq = 3) is a 16550A
ttyS3 at 0x02e8 (irq = 0) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 256 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x0708-0x070f, BIOS settings: hdc:DMA, hdd:DMA
hda: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 352k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash verSCSI subsystem driver Revision: 1.00
sion 3.5.13 starting
Loading scsi_mod.o module
Loading sd_mod.o module
Loading aic7xxx.o module
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
                                                                 
Starting timer : 0 0
blk: queue f7fd3e18, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM-ESXS  Model: ST318452LC    !#  Rev: B841
  Type:   Direct-Access                      ANSI SCSI revision: 03
Starting timer : 0 0
blk: queue f7fd3c18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: FTlV1 S2          Rev: 0
  Type:   Processor                          ANSI SCSI revision: 02
Starting timer : 0 0
blk: queue f7fd4018, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
Partition check:
 sda: sda1 sda2 sda3
Loading mptbase.Fusion MPT base driver 2.05.05+
o module
Copyright (c) 1999-2002 LSI Logic Corporation
PCI: Enabling device 01:05.0 (0000 -> 0003)
mptbase: Initiating ioc0 bringup
ioc0: FC919X: Capabilities={Initiator,Target,LAN}
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: 1 MPT adapter found, 1 installed.
Loading mptscsihFusion MPT SCSI Host driver 2.05.05+
.o module
scsi1 : ioc0: LSIFC919X, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
Starting timer : 0 0
blk: queue f752d618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
scsi : aborting command due to timeout : pid 25, scsi1, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00
mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f752d400)
  IOs outstanding = 1
mptscsih: Attempting ABORT SCSI IO! (mf=f74e0100:sc=f752d400)
SCSI host 1 abort (pid 25) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
mptscsih: OldReset scheduling BUS_RESET (sc=f752d400)
  IOs outstanding = 1
SCSI host 1 channel 0 reset (pid 25) timed out - trying harder
SCSI bus is being reset for host 1 channel 0.
mptscsih: OldReset scheduling BUS_RESET (sc=f752d400)
  IOs outstanding = 1
SCSI host 1 reset (pid 25) timed out again -
probably an unrecoverable SCSI bus or device hang.
mptbase: Initiating ioc0 recovery
SCSI host 1 reset (pid 26) timed out again -
probably an unrecoverable SCSI bus or device hang.

--9amGYk9869ThD9tj--
