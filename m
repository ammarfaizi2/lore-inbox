Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130412AbQKTUF7>; Mon, 20 Nov 2000 15:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbQKTUFu>; Mon, 20 Nov 2000 15:05:50 -0500
Received: from p3E9BB367.dip.t-dialin.net ([62.155.179.103]:49139 "EHLO
	mail.linsoft.de") by vger.kernel.org with ESMTP id <S130416AbQKTUFg> convert rfc822-to-8bit;
	Mon, 20 Nov 2000 15:05:36 -0500
From: Oliver Poths <oliver.poths@linsoft.de>
Date: Mon, 20 Nov 2000 19:35:12 GMT
Message-ID: <20001120.19351200@rock.>
Subject: Kernel-2.4-Bug in raid-code ?
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I´ve set up a Debian-2.2-System and built a Kernel-2.4.0-test11 on it.
Hardwareconfiguration : athlon-850MHz, Asus-A7V (promise ultra-100 on
board), additional promise ultra-100-card. 3 IBM DTLA 307045 Disks only
one at each IDE-channel. The three ata-100 disks should become a raid-5.

Additional small IDE boot-disk with the Debian-system. Kernel-messages at
boot-time looked fine.

After installing a raid5-array with 3 45MB-Partitions(fd) on 3 IBM DTLA
307045-Disks, i tried to boot the system. The first 2 times the kernel
crashed while outputting an oops-message. I know that it´s important to
send you the exact message, but i didn´t expect that it would go away
after the second attempt and now i just don´t have it. SORRY.
The third attempt to boot succeeded, BUT the raid array couldn´t start:
log of boot-process:


Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 32748
zone(0): 4096 pages.
zone(1): 28652 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: BOOT_IMAGE=Linux ro root=303
BOOT_FILE=/boot/linux-2.4.0
Initializing CPU#0
Detected 857.660 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1710.49 BogoMIPS
Memory: 126516k/130992k available (1378k kernel code, 4080k reserved, 91k
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf10f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
PDC20267: IDE controller on PCI bus 00 dev 58
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide4: BM-DMA at 0x7000-0x7007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x7008-0x700f, BIOS settings: hdk:pio, hdl:pio
hda: Conner Peripherals 425MB - CFS425A, ATA DISK drive
hdc: OnStream DI-30, ATAPI TAPE drive
hdd: ATAPI CDROM, ATAPI CDROM drive
hde: IBM-DTLA-307045, ATA DISK drive
hdg: IBM-DTLA-307045, ATA DISK drive
hdi: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa400-0xa407,0xa002 on irq 11
ide3 at 0x9800-0x9807,0x9402 on irq 11
ide4 at 0x8400-0x8407,0x8002 on irq 11
hda: 832288 sectors (426 MB) w/64KiB Cache, CHS=839/16/62
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
UDMA(100)
hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
UDMA(100)
hdi: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
UDMA(100)
hdd: ATAPI 24X CD-ROM drive, 120kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
ide-tape: hdc <-> ht0: OnStream DI-30 rev 1.08
ide-tape: hdc <-> ht0: 990KBps, 64*32kB buffer, 10208kB pipeline, 60ms
tDSC, DMA
Partition check:
 hda: hda1 hda2 hda3
 hde: hde1 hde2
 hdg: hdg1 hdg2
 hdi: hdi1 hdi2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0x8800, IRQ 12, 52:54:05:FE:C1:C5.
usb.c: registered new driver hub
usb.c: registered new driver usblp
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5 personality registered
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
(read) hde2's sb offset: 45025280 [events: 00000002]
(read) hdg2's sb offset: 45025280 [events: 00000002]
(read) hdi2's sb offset: 45025280 [events: 00000004]
autorun ...
considering hdi2 ...
  adding hdi2 ...
  adding hdg2 ...
  adding hde2 ...
created md0
bind<hde2,1>
bind<hdg2,2>
bind<hdi2,3>
running: <hdi2><hdg2><hde2>
now!
hdi2's event counter: 00000004
hdg2's event counter: 00000002
hde2's event counter: 00000002
md: superblock update time inconsistency -- using the most recent one
freshest: hdi2
md: kicking non-fresh hdg2 from array!
unbind<hdg2,2>
export_rdev(hdg2)
md: kicking non-fresh hde2 from array!
unbind<hde2,1>
export_rdev(hde2)
md0: former device hde2 is unavailable, removing from array!
md0: former device hdg2 is unavailable, removing from array!
md0: max total readahead window set to 1024k
md0: 2 data-disks, max readahead per data-disk: 512k
raid5: device hdi2 operational as raid disk 2
raid5: not enough operational devices for md0 (2/3 failed)
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, s:0, o:0, n:0 rd:0 us:1 dev:[dev 00:00]
 disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdi2
 disk 3, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 4, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 5, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 6, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 7, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 8, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 9, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 10, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 11, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 12, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 13, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 14, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 15, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 16, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 17, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 18, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 19, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 20, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 21, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 22, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 23, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 24, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 25, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 26, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
raid5: failed to run raid set md0
pers->run() failed ...
do_md_run() returned -22
md0 stopped.
unbind<hdi2,0>
export_rdev(hdi2)
... autorun DONE.
raid5: measuring checksumming speed
   8regs     :  1098.042 MB/sec
   32regs    :  1159.383 MB/sec
   pII_mmx   :  2007.108 MB/sec
   p5_mmx    :  2527.554 MB/sec
raid5: using function: p5_mmx (2527.554 MB/sec)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 20332k swap-space (priority -1)



autodetecting the raid seems to work, but starting doesn´t.

This looks to me like the kernel kicks 2 from 3 disks in the raid5-array
because of a kind of timestamp? and then the whole array isn`t
recoverable anymore.
I don´t know anything about that update time, but may it be better to
ignore it in advance to be able to keep the array running ?

The same thing happens when i try to start the raid manually with
raidstart /dev/md0.

In the log above you can see, that the settings for the three ibm-disks
(connected with 80-pin cables) are pio and not DMA! This log was created
at the first time the boot-process succeeded after installing the raid.
After this, i booted the machine several times and the settings were DMA,
which is correct.

Now the system is booting well, but the raid5 gives up every time.

The Raid-Disks contain no data yet, so i´ll try to make the raid array
again.
But i thought this case could be important for the Kernel-Developers.

Next time i have a kernel-crash i WILL write down the output.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
