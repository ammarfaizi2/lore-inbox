Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTABLSM>; Thu, 2 Jan 2003 06:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTABLSM>; Thu, 2 Jan 2003 06:18:12 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:20461 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S261356AbTABLSJ>;
	Thu, 2 Jan 2003 06:18:09 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 2 Jan 2003 12:26:35 +0100
To: linux-kernel@vger.kernel.org
Cc: Paul Bristow <paul@paulbristow.net>
Subject: [2.5.5x BUG] ide-floppy
Message-ID: <20030102112635.GB26362@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Paul Bristow <paul@paulbristow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  Some wierdness pops up when booting 2.5.5x with IDE ZIP disk inserted.
ZIP drive is otherwise usable.

adness in kobject_register at lib/kobject.c:113
Call Trace:
 [<c0189ae1>] kobject_register+0x39/0x48
 [<c015aeec>] add_partition+0x60/0x68
 [<c015b049>] register_disk+0x119/0x150
 [<c01b079d>] add_disk+0x4d/0x54
 [<c01b072c>] exact_match+0x0/0x8
 [<c01b0734>] exact_lock+0x0/0x1c
 [<c01ce5b9>] idefloppy_attach+0x13d/0x164
 [<c01c4ca4>] ata_attach+0x24/0x74
 [<c01c57ef>] ide_register_driver+0xa7/0xd8
 [<c01ce5f4>] idefloppy_init+0x14/0x20
 [<c0105024>] init+0x0/0x13c
 [<c010503e>] init+0x1a/0x13c
 [<c0105024>] init+0x0/0x13c
 [<c0106e1d>] kernel_thread_helper+0x5/0xc

Anyone's hot a clue whats happening?

	Cheers,
		Vita

dmesg from that kernel:
~~~~~~~~~~~~~~~~~~~~~~~
Linux version 2.5.53 (root@doma) (gcc version 2.95.3 20010315 (release)) #1 Sat Dec 28 15:35:27 CET 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000014000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
320MB LOWMEM available.
On node 0 totalpages: 81920
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77824 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=test ro root=302 reboot=w parport=auto idebus=41
ide_setup: idebus=41
Initializing CPU#0
Detected 416.390 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 823.29 BogoMIPS
Memory: 321080k/327680k available (1417k kernel code, 5840k reserved, 568k data, 280k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
Generic RTC Driver v1.06
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 41MHz system bus speed for PIO modes
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC24300L, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI680: IDE controller at PCI slot 00:10.0
PCI: Found IRQ 10 for device 00:10.0
SiI680: chipset revision 2
SiI680: not 100%% native mode: will probe irqs later
SiI680: BASE CLOCK == 133 
    ide2: MMIO-DMA at 0xd4800000-0xd4800007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xd4800008-0xd480000f, BIOS settings: hdg:pio, hdh:pio
hde: ST380021A, ATA DISK drive
hde: DMA disabled
ide2 at 0xd4800080-0xd4800087,0xd480008a on irq 10
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: host protected area => 1
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=8912/15/63
 hda: hda1 hda2 hda3 hda4
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hdd: 98288kB, 196576 blocks, 512 sector size
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hdd: hdd4
 hdd: hdd4
Badness in kobject_register at lib/kobject.c:113
Call Trace:
 [<c0189ae1>] kobject_register+0x39/0x48
 [<c015aeec>] add_partition+0x60/0x68
 [<c015b049>] register_disk+0x119/0x150
 [<c01b079d>] add_disk+0x4d/0x54
 [<c01b072c>] exact_match+0x0/0x8
 [<c01b0734>] exact_lock+0x0/0x1c
 [<c01ce5b9>] idefloppy_attach+0x13d/0x164
 [<c01c4ca4>] ata_attach+0x24/0x74
 [<c01c57ef>] ide_register_driver+0xa7/0xd8
 [<c01ce5f4>] idefloppy_init+0x14/0x20
 [<c0105024>] init+0x0/0x13c
 [<c010503e>] init+0x1a/0x13c
 [<c0105024>] init+0x0/0x13c
 [<c0106e1d>] kernel_thread_helper+0x5/0xc

device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Dec 17 19:01:13 2002 UTC).
PCI: Found IRQ 11 for device 00:14.0
ALSA device list:
  #0: Sound Blaster Live! at 0xe800, irq 11
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (2560 buckets, 20480 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.07 2002-Oct-24, 2 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 280k freed
Adding 48152k swap on /dev/hda1.  Priority:1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide2(33,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide2(33,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide2(33,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
microcode: CPU0 updated from revision 4 to 10, date=05051999
microcode: freed 2048 bytes
