Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270708AbRHPCjv>; Wed, 15 Aug 2001 22:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270709AbRHPCjl>; Wed, 15 Aug 2001 22:39:41 -0400
Received: from N23ch-01p18.ppp11.odn.ad.jp ([61.116.127.18]:9460 "HELO
	220fx.luky.org") by vger.kernel.org with SMTP id <S270708AbRHPCjh> convert rfc822-to-8bit;
	Wed, 15 Aug 2001 22:39:37 -0400
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: 4.7GB DVD-RAM geometry wrong?
In-Reply-To: <20010815233424P.shibata@luky.org>
In-Reply-To: <20010815111030Z271139-761+1405@vger.kernel.org>
	<20010815131733.I545@suse.de>
	<20010815233424P.shibata@luky.org>
X-Face: (p:N+d=)]R.hGpO.WD'FWD}r"'N]'G~TQL>ZMHN6Ev":krdN|{+={]m/yqX7|9Qzu[eX[+}
 ^=d9Vr7#OCKV?ZAYq=#iG2v&fyuJZWeVwGrmTRvpcWiSTzga-$8/W\XR"r]63S56VQ@[8w}/;iq)sm
 1=B_r2J$Uf~aN5@8f2Fk$Oa[wZ
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <20010816114439K.shibata@luky.org>
Date: Thu, 16 Aug 2001 11:44:39 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

> > > I have a Panasonic DVD-RAM, LF-D201 (SCSI 4.7/9.4GB).  I put in a
> > > 4.7GB type II cartridge (that's a single-sided disk), did 'mkfs 
> > > /dev/scd0' and then mounted it, and ... I have a 2.2GB disk!
> 
> Almost the same problem here w/ 5.2GB HITACHI DVD-RAM Drive, GF-2050.

Sorry, My 5.2GB SCSI DVD-RAM drive's correct name is GF-1050.

> > Attached patch should fix it, Linus please apply.
> 
> The patch with 2.4.8-ac5 fixed my problem.

The geometry problem is sloved.

But other problem has come with 4.7GB(9.4GB) ATAPI(IDE) DVD-RAM drive
named HITACHI GF-2000.

Here is my dmesg.
While I did "cp -auv DIR/ /mnt/floppy/", segv has happend.
file system on DVD-RAM is UDF.

Is this drive firmware broken? or chipset wrong? or else?

Thanks for your help.

Linux version 2.4.8-ac5 (root@hath.luky.org) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #5 ÌÚ 8·î 16 01:36:22 JST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=linux ro root=900 BOOT_FILE=/boot/bzImage-2.4.8
Initializing CPU#0
Detected 922.345 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1841.56 BogoMIPS
Memory: 899924k/917504k available (1122k kernel code, 17188k reserved, 321k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 922.3431 MHz.
..... host bus clock speed is 115.2928 MHz.
cpu: 0, clocks: 1152928, slice: 576464
CPU0<T0:1152928,T1:576464,D:0,S:576464,C:1152928>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf08c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnP: PNP BIOS installation structure at 0xc00fc240
PnP: PNP BIOS version 1.0, entry at f0000:c270, dseg at f0000
PnP: No devices found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:0c.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (4941,30865,4941,1)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: queued sectors max/low 597698kB/466626kB, 1792 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 38
PCI: Found IRQ 10 for device 00:07.0
PCI: Sharing IRQ 10 with 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:DMA, hdh:DMA
hdb: HITACHI DVD-RAM GF-2000, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-305040, ATA DISK drive
hdg: IBM-DTLA-305040, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xb000-0xb007,0xa802 on irq 10
ide3 at 0xa400-0xa407,0xa002 on irq 10
hde: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63, UDMA(100)
hdb: ATAPI DVD-ROM DVD-RAM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: hde1 hde2 < hde5 hde6 >
 hdg: hdg1 hdg2 < hdg5 hdg6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 3 for device 00:0a.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:11:13:B3, IRQ 3.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 352509-003, Physical connectors present: RJ45
  Primary interface chip DP83840 PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
cm: version $Revision: 5.64 $ time 01:39:08 Aug 16 2001
PCI: Found IRQ 9 for device 00:0d.0
PCI: Sharing IRQ 9 with 00:04.2
PCI: Sharing IRQ 9 with 00:09.0
cm: found CM8738 adapter at io 0x8400 irq 9
chip version = 037
md: raid0 personality registered
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) hde1's sb offset: 31104 [events: 0000001b]
(read) hde6's sb offset: 39128896 [events: 0000001b]
(read) hdg1's sb offset: 31104 [events: 0000001b]
(read) hdg6's sb offset: 39128896 [events: 0000001b]
md: autorun ...
md: considering hdg6 ...
md:  adding hdg6 ...
md:  adding hde6 ...
md: created md0
md: bind<hde6,1>
md: bind<hdg6,2>
md: running: <hdg6><hde6>
md: now!
md: hdg6's event counter: 0000001b
md: hde6's event counter: 0000001b
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at hde6
raid0:   comparing hde6(39128896) with hde6(39128896)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg6
raid0:   comparing hdg6(39128896) with hde6(39128896)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hde6 ... contained as device 0
  (39128896) is smallest!.
raid0: checking hdg6 ... contained as device 1
raid0: zone->nb_dev: 2, size: 78257792
raid0: current zone offset: 39128896
raid0: done.
raid0 : md_size is 78257792 blocks.
raid0 : conf->smallest->size is 78257792 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdg6 [events: 0000001c](write) hdg6's sb offset: 39128896
md: hde6 [events: 0000001c](write) hde6's sb offset: 39128896
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md1
md: bind<hde1,1>
md: bind<hdg1,2>
md: running: <hdg1><hde1>
md: now!
md: hdg1's event counter: 0000001b
md: hde1's event counter: 0000001b
request_module[md-personality-3]: Root fs not mounted
md :do_md_run() returned -22
md: md1 stopped.
md: unbind<hdg1,1>
md: export_rdev(hdg1)
md: unbind<hde1,0>
md: export_rdev(hde1)
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 1048784k swap-space (priority -1)
Adding Swap: 1048784k swap-space (priority -2)
usb.c: registered new driver hub
(read) hde1's sb offset: 31104 [events: 0000001b]
(read) hdg1's sb offset: 31104 [events: 0000001b]
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md1
md: bind<hde1,1>
md: bind<hdg1,2>
md: running: <hdg1><hde1>
md: now!
md: hdg1's event counter: 0000001b
md: hde1's event counter: 0000001b
md: raid1 personality registered
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdg1 operational as mirror 1
raid1: device hde1 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hdg1 [events: 0000001c](write) hdg1's sb offset: 31104
md: hde1 [events: 0000001c](write) hde1's sb offset: 31104
md: ... autorun DONE.
PCI: Found IRQ 9 for device 00:09.0
PCI: Sharing IRQ 9 with 00:04.2
PCI: Sharing IRQ 9 with 00:0d.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: HITACHI   Model: GF-1050           Rev: S00F
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 8)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2 cdda tray
scsi : 0 hosts left.
PCI: Enabling device 00:09.0 (0016 -> 0017)
PCI: Found IRQ 9 for device 00:09.0
PCI: Sharing IRQ 9 with 00:04.2
PCI: Sharing IRQ 9 with 00:0d.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: HITACHI   Model: GF-1050           Rev: S00F
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 8)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2 cdda tray
scsi : 0 hosts left.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
[drm] Initialized r128 2.1.2 20001215 on minor 63
VFS: Disk change detected on device ide0(3,64)
udf: registering filesystem
UDF-fs DEBUG lowlevel.c:56:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG super.c:1410:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:1419:udf_read_super: Lastblock=2236703
UDF-fs DEBUG super.c:409:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG super.c:758:udf_load_pvoldesc: recording time 997925361/534963, 2001/08/16 10:29 (121c)
UDF-fs DEBUG super.c:960:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
UDF-fs DEBUG super.c:969:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=160, partition=0
UDF-fs DEBUG super.c:806:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG super.c:839:udf_load_partdesc: unallocatedSpaceBitmap (part 0) @ 0
UDF-fs DEBUG super.c:879:udf_load_partdesc: Partition (0:0 type 1511) starts at physical 1408, block length 2235008
UDF-fs DEBUG super.c:1210:udf_load_partition: Using anchor in block 2236703
UDF-fs DEBUG super.c:731:udf_find_fileset: Fileset at block=160, partition=0
UDF-fs DEBUG super.c:792:udf_load_fileset: Rootdir at block=192, partition=0
UDF-fs INFO UDF 0.9.4.1-rw (2001/06/13) Mounting volume '', timestamp 2001/08/16 10:29 (121c)
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: status timeout: status=0xd0 { Busy }
hdb: drive not ready for command
hdb: ATAPI reset complete
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: status timeout: status=0xd0 { Busy }
hdb: drive not ready for command
hdb: ATAPI reset complete
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: status timeout: status=0xd0 { Busy }
hdb: drive not ready for command
hdb: ATAPI reset complete
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: status timeout: status=0xd0 { Busy }
hdb: drive not ready for command
hdb: ATAPI reset complete
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01440f8>]
EFLAGS: 00010202
eax: ffffffff   ebx: d26f53a0   ecx: d26f53a0   edx: 00000001
esi: fad31120   edi: de1c96c0   ebp: d26f53a0   esp: de159e60
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 930, stackpage=de159000)
Stack: d26f53a0 de159ed4 fad272e3 d26f53a0 fffffffb f7cd6000 c0143d97 00000000 
       f5dbe8a0 de1c96c0 de159f8c 00000000 fad2651d f5dbe8a0 f5dbe8a0 00000000 
       c1f22700 00020101 000100a8 00349be2 000c8066 1b000001 00000800 000c82c9 
Call Trace: [<fad272e3>] [<c0143d97>] [<fad2651d>] [<c013b585>] [<c013b41a>] 
   [<c013b70c>] [<c0130113>] [<c0130026>] [<c0130314>] [<c0106ccb>] 

Code: 0f 0b e9 86 00 00 00 90 39 1b 74 3c f6 83 08 01 00 00 0f 75 

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki SHibata @ FUkuoka, JAPAN
0(mmm)0 IRC: #luky
   ~    http://his.luky.org/ http://hoop.euqset.org/
