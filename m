Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277034AbRJKXED>; Thu, 11 Oct 2001 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277039AbRJKXDz>; Thu, 11 Oct 2001 19:03:55 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:3897 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277034AbRJKXDf>; Thu, 11 Oct 2001 19:03:35 -0400
Date: Fri, 12 Oct 2001 01:03:10 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
Message-ID: <20011012010310.A1255@christian.chrullrich.de>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011012003148.B435@christian.chrullrich.de> <Pine.GSO.4.21.0110111854080.24742-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0110111854080.24742-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 11, 2001 at 06:59:03PM -0400
X-Current-Uptime: 0 d, 00:25:20 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Viro wrote on Thursday, 2001-10-11:

> On Fri, 12 Oct 2001, Christian Ullrich wrote:
> 
> > a) -10-ac11, -10-ac12 and -12 with your patch all behave like -11.
> 
> _Ouch_.  So even bread()-based variant fails to read extended partition
> table in some cases.
> 
> Hmm... Just in case - what processor are you using?

Full dmesg output from 2.4.10:

Linux version 2.4.10 (root@christian) (gcc version 2.95.3 20010315 (SuSE)) #1 Fri Oct 12 00:13:47 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
On node 0 totalpages: 262124
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32748 pages.
Kernel command line: auto BOOT_IMAGE=L ro root=802 BOOT_FILE=/boot/vmlinuz-2.4.10+line 3 2.4.10+l 2
Initializing CPU#0
Detected 1208.772 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2411.72 BogoMIPS
Memory: 1029868k/1048496k available (678k kernel code, 18240k reserved, 164k data, 168k init, 130992k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 10 for device 00:0b.0
PCI: Sharing IRQ 10 with 00:11.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 599k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3): 8.333MB/s transfers (8.333MHz, offset 15)
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
scsi0:0:6:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda:[63 16002]
 sda1[16065 401625]
 sda2[417690 8401995]
 sda3[8819685 9092790]
 sda4 <[8819748 5253192]
 sda5[14073003 273042]
 sda6[14346108 995967]
 sda7[15342138 2570337]
 sda8 >
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb:[63 10490382]
 sdb1[10490445 7164990]
 sdb2[17655435 257040]
 sdb4
reiserfs: checking transaction log (device 08:02) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... okay
Freeing unused kernel memory: 168k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 136512k swap-space (priority -1)
Adding Swap: 128512k swap-space (priority -2)
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PCI: Sharing IRQ 10 with 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdb: FUJITSU MPG3409AT E, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63, UDMA(100)
 hda:[63 2104452]
 hda1[2104515 37768815]
 hda2 <[2104578 20980827]
 hda5[23085468 48132]
 hda6[23133663 16739667]
 hda7 >
 hdb:[63 10000305]
 hdb1[10000368 68063184]
 hdb2 <[10000431 20972889]
 hdb5[48063519 30000033]
 hdb6 >[78063552 1999872]
 hdb3
Adding Swap: 999928k swap-space (priority -3)
reiserfs: checking transaction log (device 08:03) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:05) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:11) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:12) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:46) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ip_conntrack (8191 buckets, 65528 max)
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:04.2
PCI: Sharing IRQ 5 with 00:04.3
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905C Tornado at 0xa400. Vers LK1.1.16

----------------------------------------------------------------------------

Full dmesg output from 2.4.12+first-patch+line:

Linux version 2.4.12 (root@christian) (gcc version 2.95.3 20010315 (SuSE)) #1 Don Okt 11 23:51:44 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
On node 0 totalpages: 262124
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32748 pages.
Kernel command line: auto BOOT_IMAGE=L ro root=802 BOOT_FILE=/boot/vmlinuz-2.4.12+patch+line 3 2.4.12+p+l 2
Initializing CPU#0
Detected 1208.767 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2411.72 BogoMIPS
Memory: 1029868k/1048496k available (674k kernel code, 18240k reserved, 164k data, 172k init, 130992k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Trying to stomp on Athlon bug...
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 10 for device 00:0b.0
PCI: Sharing IRQ 10 with 00:11.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 603k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3): 8.333MB/s transfers (8.333MHz, offset 15)
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
scsi0:0:6:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda:[63 16002]
 sda1[16065 401625]
 sda2[417690 8401995]
 sda3[8819685 9092790]
 sda4 <[8819748 5253192]
 sda5[14073003 273042]
 sda6[14346108 995967]
 sda7[15342138 2570337]
 sda8 >
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb:[63 10490382]
 sdb1[10490445 7164990]
 sdb2[17655435 257040]
 sdb4
reiserfs: checking transaction log (device 08:02) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... okay
Freeing unused kernel memory: 172k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 136512k swap-space (priority -1)
Adding Swap: 128512k swap-space (priority -2)
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PCI: Sharing IRQ 10 with 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdb: FUJITSU MPG3409AT E, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63, UDMA(100)
 hda:[63 2104452]
 hda1[2104515 37768815]
 hda2 <[2104578 20980827]
 hda5[23085468 48132]
 hda6[23133663 16739667]
 hda7 >
 hdb:[63 10000305]
 hdb1[10000368 68063184]
 hdb2 < >[78063552 1999872]
 hdb3
Adding Swap: 999928k swap-space (priority -3)
reiserfs: checking transaction log (device 08:03) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:05) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:11) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:12) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
hdb6: bad access: block=128, count=2
end_request: I/O error, dev 03:46 (hdb), sector 128
read_super_block: bread failed (dev 03:46, block 64, size 1024)
hdb6: bad access: block=16, count=2
end_request: I/O error, dev 03:46 (hdb), sector 16
read_super_block: bread failed (dev 03:46, block 8, size 1024)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ip_conntrack (8191 buckets, 65528 max)
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:04.2
PCI: Sharing IRQ 5 with 00:04.3
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905C Tornado at 0xa400. Vers LK1.1.16

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
