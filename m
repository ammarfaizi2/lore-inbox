Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288334AbSAHVAA>; Tue, 8 Jan 2002 16:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288333AbSAHU7G>; Tue, 8 Jan 2002 15:59:06 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:48568 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S288342AbSAHU6O>; Tue, 8 Jan 2002 15:58:14 -0500
Message-Id: <200201082058.g08Kw8l19074@rgmgw5.us.oracle.com>
From: Uwe Teichmann <uwe.teichmann@oracle.com>
Reply-To: uwe.teichmann@oracle.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Q: I/O Problems with Linux 2.4.10 SMP on Tyan Tiger S2460 ?
Date: Tue, 8 Jan 2002 21:56:41 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_HU0NE5DDTUE9WUZ60A17"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_HU0NE5DDTUE9WUZ60A17
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Dear All,

I'm running a Tyan Tiger S2460 with two Athlon MP 1700+, using SuSE 7.3 
2.4.10 SMP Kernel. In addition i have 2 Adaptec 29160, each serving at the
moment only one Seagate Cheetah disk. Creating with Oracle in parallel 
4 datafiles each 1GB i come up with 34 MB/sec. 

On my previous Gigabyte i440 BX with SCSI U2W onboard using above Linux 
version and disk layout, i came up with 48 MB/sec.

So, where is the problem ? 

Attached i have the dmesg command output. The only thing i can see is the 

CPU has inconsistent mtrr settings

message. mtrr as a module is activated. Could this be the problem ? During
the run of the above creation of the datafiles, i get the expression only
cpu at a time works, but i do not know how to prove it.

Thanks for any help.

Ciao,
--------------Boundary-00=_HU0NE5DDTUE9WUZ60A17
Content-Type: text/plain;
  charset="iso-8859-1";
  name="boot.messages"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="boot.messages"

Linux version 2.4.10-64GB-SMP (root@SMP_X86.suse.de) (gcc version 2.95.3 20010315 (SuSE)) #1 SMP Tue Sep 25 12:36:09 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
found SMP MP-table at 000f7510
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux ro root=304 BOOT_FILE=/boot/vmlinuz noapic apm=off vga=0x0317 hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1466.741 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2929.45 BogoMIPS
Memory: 1028704k/1048576k available (1390k kernel code, 19484k reserved, 392k data, 128k init, 131072k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP Processor 1700+ stepping 02
per-CPU timeslice cutoff: 731.61 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2929.45 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Intel machine check reporting enabled on CPU#1.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (5858.91 BogoMIPS).
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1466.7487 MHz.
..... host bus clock speed is 266.6808 MHz.
cpu: 0, clocks: 2666808, slice: 888936
CPU0<T0:2666800,T1:1777856,D:8,S:888936,C:2666808>
cpu: 1, clocks: 2666808, slice: 888936
CPU1<T0:2666800,T1:888928,D:0,S:888936,C:2666808>
checking TSC synchronization across CPUs: passed.
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD7411: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L040J2, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78177792 sectors (40027 MB) w/1820KiB Cache, CHS=4866/255/63, UDMA(33)
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Uncompressing.....................................................done.
Freeing initrd memory: 569k freed
VFS: Mounted root (ext2 filesystem).
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.3
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.3
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318451LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST318451LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
SCSI device sda: 35843671 512-byte hdwr sectors (18352 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1 sdb3
SCSI device sdc: 35843671 512-byte hdwr sectors (18352 MB)
 sdc: sdc1 sdc2 sdc3
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: checking transaction log (device 03:04) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... okay
Freeing unused kernel memory: 128k freed
md: bind<sda1,1>
md: nonpersistent superblock ...
md: bind<sdc1,2>
md: nonpersistent superblock ...
md: sdc1's event counter: 00000000
md: sda1's event counter: 00000000
md: raid0 personality registered as nr 2
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at sda1
raid0:   comparing sda1(4193472) with sda1(4193472)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc1
raid0:   comparing sdc1(4193472) with sda1(4193472)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda1 ... contained as device 0
  (4193472) is smallest!.
raid0: checking sdc1 ... contained as device 1
raid0: zone->nb_dev: 2, size: 8386944
raid0: current zone offset: 4193472
raid0: done.
raid0 : md_size is 8386944 blocks.
raid0 : conf->smallest->size is 8386944 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: bind<sda2,1>
md: nonpersistent superblock ...
md: bind<sdc2,2>
md: nonpersistent superblock ...
md: sdc2's event counter: 00000000
md: sda2's event counter: 00000000
md1: max total readahead window set to 8192k
md1: 2 data-disks, max readahead per data-disk: 4096k
raid0: looking at sda2
raid0:   comparing sda2(13756416) with sda2(13756416)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc2
raid0:   comparing sdc2(13756416) with sda2(13756416)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda2 ... contained as device 0
  (13756416) is smallest!.
raid0: checking sdc2 ... contained as device 1
raid0: zone->nb_dev: 2, size: 27512832
raid0: current zone offset: 13756416
raid0: done.
raid0 : md_size is 27512832 blocks.
raid0 : conf->smallest->size is 27512832 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: array md0 already exists!
md: array md1 already exists!
Adding Swap: 2097136k swap-space (priority -1)
NTFS driver v1.1.19 [Flags: R/O MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
ip_tables: (c)2000 Netfilter core team
ip_conntrack (8192 buckets, 65536 max)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: KTI ET32P2 found at 0x1800, IRQ 11, 00:40:F6:AC:A0:47.
eth1: KTI ET32P2 found at 0x1840, IRQ 5, 00:40:F6:AC:C0:F3.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 13:00:18 Sep 25 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 9
0x378: readIntrThreshold is 9
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x48
0x378: ECP settings irq=7 dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_mux: aa55f00f52ad51(8f)
parport0: cpp_daisy: aa5500ff(88)
parport0: assign_addrs: aa5500ff(88)
parport0: cpp_mux: aa55f00f52ad51(8f)
parport0: cpp_daisy: aa5500ff(88)
parport0: assign_addrs: aa5500ff(88)
lp0: using parport0 (polling).
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 1
Attached scsi CD-ROM sr2 at scsi2, channel 0, id 0, lun 2
Attached scsi CD-ROM sr3 at scsi2, channel 0, id 0, lun 3
Attached scsi CD-ROM sr4 at scsi2, channel 0, id 0, lun 4
Attached scsi CD-ROM sr5 at scsi2, channel 0, id 0, lun 5
Attached scsi CD-ROM sr6 at scsi2, channel 0, id 0, lun 6
Attached scsi CD-ROM sr7 at scsi2, channel 0, id 1, lun 0
Attached scsi CD-ROM sr8 at scsi2, channel 0, id 1, lun 1
Attached scsi CD-ROM sr9 at scsi2, channel 0, id 1, lun 2
Attached scsi CD-ROM sr10 at scsi2, channel 0, id 1, lun 3
Attached scsi CD-ROM sr11 at scsi2, channel 0, id 1, lun 4
Attached scsi CD-ROM sr12 at scsi2, channel 0, id 1, lun 5
Attached scsi CD-ROM sr13 at scsi2, channel 0, id 1, lun 6
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr4: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr5: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr6: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr7: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr8: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr9: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr10: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr11: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr12: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr13: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
eth0: no IPv6 routers present
spurious 8259A interrupt: IRQ7.

--------------Boundary-00=_HU0NE5DDTUE9WUZ60A17--
