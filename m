Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVDESBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVDESBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDERsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:48:51 -0400
Received: from box3.punkt.pl ([217.8.180.76]:49423 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261849AbVDERWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:22:40 -0400
Message-ID: <4252CA25.70803@punkt.pl>
Date: Tue, 05 Apr 2005 19:25:57 +0200
From: |TEcHNO| <techno@punkt.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041122
X-Accept-Language: en-gb, en-us, en-ca, en-au, ja, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: [SCSI] Driver Broken in 2.6.x (attemp 2)
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This is my second attemp to make anyone notice the bug that is in the 
2.6.x tree. While many people tried to put blame on nvidia, here's a log 
that shows that it's purely kernel fault not to work.
	At the end of this mail you can find some logs which show how 2.4.x and 
2.6.x kernels work with my card. I hope now someone can really  show 
intrest into this, it's a shame something in 2.4.x worked (not perfect 
but worked), and fails completely (system hang) in 2.6.x.
	It's also not nice if the system hangs (in 2.4.x) for a few seconds 
while getting a preview (form the scanner), and gets jaggy and useless 
while scanning, a userspace app (runned form normal user) shoudl not do 
so, and it's not using more than 20% of CPU.

<2.4.26>
<syslog>
Apr  5 17:25:15 techno kernel: Linux version 2.4.26 (root@techno) (gcc 
version 3.3.4) #11 Mon Oct 25 20:20:49 CEST 2004
Apr  5 17:25:15 techno kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Apr  5 17:25:15 techno kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Apr  5 17:25:15 techno kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Apr  5 17:25:15 techno kernel:  BIOS-e820: 0000000000100000 - 
000000001bff0000 (usable)
Apr  5 17:25:15 techno kernel:  BIOS-e820: 000000001bff0000 - 
000000001bff8000 (ACPI data)
Apr  5 17:25:15 techno kernel:  BIOS-e820: 000000001bff8000 - 
000000001c000000 (ACPI NVS)
Apr  5 17:25:15 techno kernel:  BIOS-e820: 00000000ffff0000 - 
0000000100000000 (reserved)
Apr  5 17:25:15 techno kernel: On node 0 totalpages: 114672
Apr  5 17:25:15 techno kernel: zone(0): 4096 pages.
Apr  5 17:25:15 techno kernel: zone(1): 110576 pages.
Apr  5 17:25:15 techno kernel: zone(2): 0 pages.
Apr  5 17:25:15 techno kernel: Kernel command line: BOOT_IMAGE=Linux ro 
root=301
Apr  5 17:25:15 techno kernel: Local APIC disabled by BIOS -- reenabling.
Apr  5 17:25:15 techno kernel: Found and enabled local APIC!
Apr  5 17:25:15 techno kernel: Detected 787.524 MHz processor.
Apr  5 17:25:15 techno kernel: Console: colour VGA+ 80x25
Apr  5 17:25:15 techno kernel: Calibrating delay loop... 1572.86 BogoMIPS
Apr  5 17:25:16 techno kernel: Page-cache hash table entries: 131072 
(order: 7, 524288 bytes)
Apr  5 17:25:16 techno kernel: CPU: Intel Celeron (Coppermine) stepping 06
Apr  5 17:25:16 techno kernel: POSIX conformance testing by UNIFIX
Apr  5 17:25:16 techno kernel: enabled ExtINT on CPU#0
Apr  5 17:25:16 techno kernel: ESR value before enabling vector: 00000000
Apr  5 17:25:16 techno kernel: ESR value after enabling vector: 00000000
Apr  5 17:25:17 techno kernel: Using local APIC timer interrupts.
Apr  5 17:25:17 techno kernel: calibrating APIC timer ...
Apr  5 17:25:17 techno kernel: ..... CPU clock speed is 787.5442 MHz.
Apr  5 17:25:17 techno kernel: ..... host bus clock speed is 75.0041 MHz.
Apr  5 17:25:17 techno kernel: cpu: 0, clocks: 750041, slice: 375020
Apr  5 17:25:17 techno kernel: 
CPU0<T0:750032,T1:375008,D:4,S:375020,C:750041>
Apr  5 17:25:17 techno kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Apr  5 17:25:17 techno kernel: mtrr: detected mtrr type: Intel
Apr  5 17:25:17 techno kernel: PCI: ACPI tables contain no PCI IRQ 
routing entries
Apr  5 17:25:17 techno kernel: PCI: Probing PCI hardware (bus 00)
Apr  5 17:25:17 techno kernel: Initializing RT netlink socket
Apr  5 17:25:17 techno kernel: Starting kswapd
Apr  5 17:25:18 techno kernel: pty: 256 Unix98 ptys configured
Apr  5 17:25:18 techno kernel: xd: Out of memory.
Apr  5 17:25:18 techno kernel: RAMDISK driver initialized: 16 RAM disks 
of 4096K size 1024 blocksize
Apr  5 17:25:18 techno kernel: 8139cp: pci dev 00:09.0 (id 10ec:8139 rev 
10) is not an 8139C+ compatible chip
Apr  5 17:25:18 techno kernel: 8139cp: Try the "8139too" driver instead.
Apr  5 17:25:19 techno kernel: hda: ST330621A, ATA DISK drive
Apr  5 17:25:19 techno kernel: hdb: LG CD-RW CED-8083B, ATAPI CD/DVD-ROM 
drive
Apr  5 17:25:19 techno kernel: blk: queue c05a1860, I/O limit 4095Mb 
(mask 0xffffffff)
Apr  5 17:25:19 techno kernel: hdc: ST3160023A, ATA DISK drive
Apr  5 17:25:19 techno kernel: blk: queue c05a1cb4, I/O limit 4095Mb 
(mask 0xffffffff)
Apr  5 17:25:19 techno kernel: hde: ST3120026A, ATA DISK drive
Apr  5 17:25:19 techno kernel: hdf: Maxtor 6B200P0, ATA DISK drive
Apr  5 17:25:19 techno kernel: blk: queue c05a2108, I/O limit 4095Mb 
(mask 0xffffffff)
Apr  5 17:25:19 techno kernel: blk: queue c05a2244, I/O limit 4095Mb 
(mask 0xffffffff)
Apr  5 17:25:19 techno kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr  5 17:25:19 techno kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr  5 17:25:19 techno kernel: ide2 at 0xdc868e80-0xdc868e87,0xdc868e8a 
on irq 9
Apr  5 17:25:19 techno kernel: hda: attached ide-disk driver.
Apr  5 17:25:19 techno kernel: hda: host protected area => 1
Apr  5 17:25:19 techno kernel: hdc: attached ide-disk driver.
Apr  5 17:25:19 techno kernel: hdc: host protected area => 1
Apr  5 17:25:19 techno kernel: hde: attached ide-disk driver.
Apr  5 17:25:19 techno kernel: hde: host protected area => 1
Apr  5 17:25:19 techno kernel: hdf: attached ide-disk driver.
Apr  5 17:25:19 techno kernel: hdf: host protected area => 1
Apr  5 17:25:20 techno kernel: hdb: attached ide-cdrom driver.
Apr  5 17:25:20 techno kernel:   Vendor: SCANNER   Model: 
     Rev: V100
Apr  5 17:25:20 techno kernel:   Type:   Scanner 
     ANSI SCSI revision: 01 CCS
Apr  5 17:25:21 techno kernel: Colour QuickCam for Video4Linux v0.05
Apr  5 17:25:23 techno kernel: VFS: Mounted root (ext3 filesystem) readonly.
Apr  5 17:25:47 techno kernel: hda3: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:03 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda3: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:03 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:47 techno kernel: hda4: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:04 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda4: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:04 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:47 techno kernel: hda5: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:05 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda5: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:05 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:47 techno kernel: hda6: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:06 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda6: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:06 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:47 techno kernel: hda7: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:07 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda7: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:07 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:47 techno kernel: hda8: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:08 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda8: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:08 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:47 techno kernel: hda9: bad access: block=2, count=2
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:09 (hda), 
sector 2
Apr  5 17:25:47 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:47 techno kernel: hda9: bad access: block=0, count=1
Apr  5 17:25:47 techno kernel: end_request: I/O error, dev 03:09 (hda), 
sector 0
Apr  5 17:25:47 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:48 techno kernel: hda:: bad access: block=2, count=2
Apr  5 17:25:48 techno kernel: end_request: I/O error, dev 03:0a (hda), 
sector 2
Apr  5 17:25:48 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:48 techno kernel: hda:: bad access: block=0, count=1
Apr  5 17:25:48 techno kernel: end_request: I/O error, dev 03:0a (hda), 
sector 0
Apr  5 17:25:48 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:48 techno kernel: reiserfs: found format "3.6" with 
standard journal
Apr  5 17:25:56 techno kernel: reiserfs: checking transaction log 
(device ide1(22,1)) ...
Apr  5 17:25:56 techno kernel: for (ide1(22,1))
Apr  5 17:25:56 techno kernel: ide1(22,1):Using r5 hash to sort names
Apr  5 17:25:56 techno kernel: hdc2: bad access: block=2, count=2
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:02 (hdc), 
sector 2
Apr  5 17:25:56 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:56 techno kernel: hdc2: bad access: block=0, count=1
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:02 (hdc), 
sector 0
Apr  5 17:25:56 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:56 techno kernel: hdc3: bad access: block=2, count=2
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:03 (hdc), 
sector 2
Apr  5 17:25:56 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:56 techno kernel: hdc3: bad access: block=0, count=1
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:03 (hdc), 
sector 0
Apr  5 17:25:56 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:56 techno kernel: hdc4: bad access: block=2, count=2
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:04 (hdc), 
sector 2
Apr  5 17:25:56 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:56 techno kernel: hdc4: bad access: block=0, count=1
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:04 (hdc), 
sector 0
Apr  5 17:25:56 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:56 techno kernel: hdc5: bad access: block=2, count=2
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:05 (hdc), 
sector 2
Apr  5 17:25:56 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:56 techno kernel: hdc5: bad access: block=0, count=1
Apr  5 17:25:56 techno kernel: end_request: I/O error, dev 16:05 (hdc), 
sector 0
Apr  5 17:25:56 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:57 techno kernel: hdc6: bad access: block=2, count=2
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:06 (hdc), 
sector 2
Apr  5 17:25:57 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:57 techno kernel: hdc6: bad access: block=0, count=1
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:06 (hdc), 
sector 0
Apr  5 17:25:57 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:57 techno kernel: hdc7: bad access: block=2, count=2
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:07 (hdc), 
sector 2
Apr  5 17:25:57 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:57 techno kernel: hdc7: bad access: block=0, count=1
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:07 (hdc), 
sector 0
Apr  5 17:25:57 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:57 techno kernel: hdc8: bad access: block=2, count=2
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:08 (hdc), 
sector 2
Apr  5 17:25:57 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:57 techno kernel: hdc8: bad access: block=0, count=1
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:08 (hdc), 
sector 0
Apr  5 17:25:57 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:57 techno kernel: hdc9: bad access: block=2, count=2
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:09 (hdc), 
sector 2
Apr  5 17:25:57 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:57 techno kernel: hdc9: bad access: block=0, count=1
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:09 (hdc), 
sector 0
Apr  5 17:25:57 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:57 techno kernel: hdc:: bad access: block=2, count=2
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:0a (hdc), 
sector 2
Apr  5 17:25:57 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:25:57 techno kernel: hdc:: bad access: block=0, count=1
Apr  5 17:25:57 techno kernel: end_request: I/O error, dev 16:0a (hdc), 
sector 0
Apr  5 17:25:57 techno kernel: FAT: unable to read boot sector
Apr  5 17:25:57 techno kernel: reiserfs: found format "3.6" with 
standard journal
Apr  5 17:26:03 techno kernel: reiserfs: checking transaction log 
(device ide2(33,1)) ...
Apr  5 17:26:03 techno kernel: for (ide2(33,1))
Apr  5 17:26:03 techno kernel: ide2(33,1):Using r5 hash to sort names
Apr  5 17:26:03 techno kernel: hde2: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:02 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde2: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:02 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde3: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:03 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde3: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:03 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde4: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:04 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde4: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:04 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde5: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:05 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde5: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:05 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde6: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:06 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde6: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:06 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde7: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:07 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde7: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:07 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde8: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:08 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde8: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:08 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde9: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:09 (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde9: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:09 (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: hde:: bad access: block=2, count=2
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:0a (hde), 
sector 2
Apr  5 17:26:03 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:03 techno kernel: hde:: bad access: block=0, count=1
Apr  5 17:26:03 techno kernel: end_request: I/O error, dev 21:0a (hde), 
sector 0
Apr  5 17:26:03 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:03 techno kernel: reiserfs: found format "3.6" with 
standard journal
Apr  5 17:26:15 techno kernel: reiserfs: checking transaction log 
(device ide2(33,65)) ...
Apr  5 17:26:15 techno kernel: for (ide2(33,65))
Apr  5 17:26:15 techno kernel: ide2(33,65):Using r5 hash to sort names
Apr  5 17:26:15 techno kernel: hdf2: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:42 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf2: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:42 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf3: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:43 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf3: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:43 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf4: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:44 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf4: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:44 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf5: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:45 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf5: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:45 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf6: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:46 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf6: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:46 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf7: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:47 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf7: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:47 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf8: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:48 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf8: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:48 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf9: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:49 (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf9: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:49 (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:26:15 techno kernel: hdf:: bad access: block=2, count=2
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:4a (hdf), 
sector 2
Apr  5 17:26:15 techno kernel: EXT3-fs: unable to read superblock
Apr  5 17:26:15 techno kernel: hdf:: bad access: block=0, count=1
Apr  5 17:26:15 techno kernel: end_request: I/O error, dev 21:4a (hdf), 
sector 0
Apr  5 17:26:15 techno kernel: FAT: unable to read boot sector
Apr  5 17:27:28 techno kernel: bttv0: using tuner=-1
Apr  5 17:27:41 techno kernel: bttv0: unloading
</syslog>

<debug>
Apr  5 17:25:16 techno kernel: CPU:     After generic, caps: 0383fbff 
00000000 00000000 00000000
Apr  5 17:25:16 techno kernel: CPU:             Common caps: 0383fbff 
00000000 00000000 00000000
Apr  5 17:25:18 techno kernel: i2c-core.o: driver i2c-dev dummy driver 
registered.
Apr  5 17:25:18 techno kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
Apr  5 17:25:21 techno kernel: parport0 (bw-qcam): use data_reverse for 
this!
Apr  5 17:26:29 techno pam_console[387]: user is "root"
Apr  5 17:26:29 techno pam_console[387]: user "root" is root
Apr  5 17:27:28 techno kernel: i2c-dev.o: Registered 'bt848 #0' as minor 0
Apr  5 17:27:28 techno kernel: i2c-core.o: adapter bt848 #0 registered 
as adapter 0.
Apr  5 17:27:41 techno kernel: i2c-core.o: adapter unregistered: bt848 #0
Apr  5 17:28:19 techno kernel: ppdev0: registered pardevice
Apr  5 17:28:19 techno kernel: ppdev0: unregistered pardevice
</debug>
</2.4.26>

<2.6.11.3>
<syslog>
Apr  5 17:31:49 techno kernel: Linux version 2.6.11.3 (root@techno) (gcc 
version 3.3.5) #1 Tue Mar 15 14:23:17 CET 2005
Apr  5 17:31:49 techno kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Apr  5 17:31:49 techno kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Apr  5 17:31:49 techno kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Apr  5 17:31:49 techno kernel:  BIOS-e820: 0000000000100000 - 
000000001bff0000 (usable)
Apr  5 17:31:49 techno kernel:  BIOS-e820: 000000001bff0000 - 
000000001bff8000 (ACPI data)
Apr  5 17:31:49 techno kernel:  BIOS-e820: 000000001bff8000 - 
000000001c000000 (ACPI NVS)
Apr  5 17:31:49 techno kernel:  BIOS-e820: 00000000ffff0000 - 
0000000100000000 (reserved)
Apr  5 17:31:54 techno kernel: Allocating PCI resources starting at 
1c000000 (gap: 1c000000:e3ff0000)
Apr  5 17:31:54 techno kernel: Built 1 zonelists
Apr  5 17:31:55 techno kernel: Kernel command line: auto 
BOOT_IMAGE=Linux-bzImage ro root=301
Apr  5 17:31:55 techno kernel: Local APIC disabled by BIOS -- you can 
enable it with "lapic"
Apr  5 17:31:56 techno kernel: PID hash table entries: 2048 (order: 11, 
32768 bytes)
Apr  5 17:31:56 techno kernel: Detected 787.705 MHz processor.
Apr  5 17:31:56 techno kernel: Console: colour VGA+ 80x25
Apr  5 17:31:57 techno kernel: Dentry cache hash table entries: 65536 
(order: 6, 262144 bytes)
Apr  5 17:31:57 techno kernel: Inode-cache hash table entries: 32768 
(order: 5, 131072 bytes)
Apr  5 17:31:57 techno kernel: Checking if this processor honours the WP 
bit even in supervisor mode... Ok.
Apr  5 17:31:58 techno kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Apr  5 17:32:02 techno kernel: CPU: Intel Celeron (Coppermine) stepping 06
Apr  5 17:32:03 techno kernel: ACPI: setting ELCR to 0800 (from 0e20)
Apr  5 17:32:05 techno kernel:     ACPI-1138: *** Error: Method 
execution failed [\MCTH] (Node dbfeeea0), AE_AML_BUFFER_LIMIT
Apr  5 17:32:06 techno kernel:     ACPI-1138: *** Error: Method 
execution failed [\_SB_.PCI0._INI] (Node dbfeec20), AE_AML_BUFFER_LIMIT
Apr  5 17:32:07 techno kernel: PCI: Probing PCI hardware (bus 00)
Apr  5 17:32:11 techno kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 
5 6 7 9 10 *11 12 14 15)
Apr  5 17:32:12 techno kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 
5 6 7 *9 10 11 12 14 15)
Apr  5 17:32:12 techno kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 
*5 6 7 9 10 11 12 14 15)
Apr  5 17:32:12 techno kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 
5 6 7 9 *10 11 12 14 15)
Apr  5 17:32:23 techno kernel: ipmi_si: Trying "kcs" at I/O port 0xca2
Apr  5 17:32:23 techno kernel: ipmi_si: Trying "smic" at I/O port 0xca9
Apr  5 17:32:23 techno kernel: ipmi_si: Trying "bt" at I/O port 0xe4
Apr  5 17:32:23 techno kernel: ipmi_si: Unable to find any System 
Interface(s)
Apr  5 17:32:23 techno kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Apr  5 17:32:23 techno kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Apr  5 17:32:23 techno kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Apr  5 17:32:23 techno kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Apr  5 17:32:23 techno kernel: xd: Out of memory.
Apr  5 17:32:23 techno kernel: ACPI: PCI Interrupt Link [LNKB] enabled 
at IRQ 9
Apr  5 17:32:23 techno kernel: PCI: setting IRQ 9 as level-triggered
Apr  5 17:32:23 techno kernel: Colour QuickCam for Video4Linux v0.05
Apr  5 17:32:23 techno kernel: hda: ST330621A, ATA DISK drive
Apr  5 17:32:23 techno kernel: hdb: LG CD-RW CED-8083B, ATAPI CD/DVD-ROM 
drive
Apr  5 17:32:23 techno kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr  5 17:32:23 techno kernel: hdc: ST3160023A, ATA DISK drive
Apr  5 17:32:23 techno kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr  5 17:32:23 techno kernel: hde: ST3120026A, ATA DISK drive
Apr  5 17:32:23 techno kernel: hdf: Maxtor 6B200P0, ATA DISK drive
Apr  5 17:32:23 techno kernel: ide2 at 0xdc85ae80-0xdc85ae87,0xdc85ae8a 
on irq 9
Apr  5 17:32:24 techno kernel: Loading Adaptec I2O RAID: Version 2.4 
Build 5go
Apr  5 17:32:24 techno kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 11
Apr  5 17:32:24 techno kernel: PCI: setting IRQ 11 as level-triggered
Apr  5 17:32:24 techno kernel: ACPI: PCI Interrupt Link [LNKD] enabled 
at IRQ 10
Apr  5 17:32:24 techno kernel: PCI: setting IRQ 10 as level-triggered
Apr  5 17:32:25 techno kernel: i2c-parport: Unable to register with parport
Apr  5 17:32:25 techno kernel: pc87360: PC8736x not detected, module not 
inserted.
Apr  5 17:32:25 techno kernel: TCP established hash table entries: 16384 
(order: 5, 131072 bytes)
Apr  5 17:32:25 techno kernel: TCP bind hash table entries: 16384 
(order: 4, 65536 bytes)
Apr  5 17:32:25 techno kernel: ACPI wakeup devices:
Apr  5 17:32:25 techno kernel: PCI0  USB USB1
Apr  5 17:32:25 techno kernel: VFS: Mounted root (ext3 filesystem) readonly.
Apr  5 17:36:51 techno kernel: scsi0 : aborting command
Apr  5 17:36:51 techno kernel: scsi0 : destination target 6, lun 0
Apr  5 17:36:51 techno kernel:
Apr  5 17:36:51 techno kernel: NCR5380 core release=7.
Apr  5 17:36:51 techno kernel: Base Addr: 0x00000    io_port: d800 
IRQ: 11.
Apr  5 17:36:51 techno kernel: scsi0 : destination target 6, lun 0
Apr  5 17:36:51 techno kernel:         command = 42 (0x2a)00 03 00 00 00 
00 10 00 00
Apr  5 17:36:51 techno kernel: scsi0: issue_queue
Apr  5 17:36:51 techno kernel: scsi0: disconnected_queue
Apr  5 17:36:51 techno kernel:
Apr  5 17:36:51 techno kernel: scsi0 : aborting command
Apr  5 17:36:51 techno kernel: scsi0 : destination target 6, lun 0
Apr  5 17:36:51 techno kernel:
Apr  5 17:36:51 techno kernel: NCR5380 core release=7.
Apr  5 17:36:51 techno kernel: Base Addr: 0x00000    io_port: d800 
IRQ: 11.
Apr  5 17:36:51 techno kernel: scsi0 : destination target 6, lun 0
Apr  5 17:36:51 techno kernel:         command = 42 (0x2a)00 03 00 00 00 
00 10 00 00
Apr  5 17:36:51 techno kernel: scsi0: issue_queue
Apr  5 17:36:51 techno kernel: scsi0: disconnected_queue
Apr  5 17:36:51 techno kernel:
Apr  5 17:36:51 techno kernel:
Apr  5 17:36:51 techno kernel: NCR5380 core release=7.
Apr  5 17:36:51 techno kernel: Base Addr: 0x00000    io_port: d800 
IRQ: 11.
Apr  5 17:36:51 techno kernel: scsi0 : destination target 6, lun 0
Apr  5 17:36:51 techno kernel:         command = 42 (0x2a)00 03 00 00 00 
00 10 00 00
Apr  5 17:36:51 techno kernel: scsi0: issue_queue
Apr  5 17:36:51 techno kernel: scsi0: disconnected_queue
Apr  5 17:36:51 techno kernel:

[system hanged, most probably by xsane/sane, something's wrong with 
kernel? My guess is that xsane hangs the system if SCSI system timeouts]
</syslog>

<debug>
Apr  5 17:31:49 techno kernel: On node 0 totalpages: 114672
Apr  5 17:31:49 techno kernel:   DMA zone: 4096 pages, LIFO batch:1
Apr  5 17:31:49 techno kernel:   Normal zone: 110576 pages, LIFO batch:16
Apr  5 17:31:49 techno kernel:   HighMem zone: 0 pages, LIFO batch:1
Apr  5 17:31:50 techno kernel: ACPI: RSDP (v000 AMI 
               ) @ 0x000fc610
Apr  5 17:31:51 techno kernel: ACPI: RSDT (v001 AMIINT 
0x00000010 MSFT 0x00000097) @ 0x1bff0000
Apr  5 17:31:53 techno kernel: ACPI: FADT (v001 AMIINT 
0x00000010 MSFT 0x00000097) @ 0x1bff0030
Apr  5 17:31:53 techno kernel: ACPI: DSDT (v001    VIA APOLLO-P 
0x00001000 MSFT 0x0100000b) @ 0x00000000
Apr  5 17:31:55 techno kernel: mapped APIC to ffffd000 (01382000)
Apr  5 17:31:57 techno kernel: Calibrating delay loop... 1552.38 
BogoMIPS (lpj=776192)
Apr  5 17:31:59 techno kernel: CPU: After generic identify, caps: 
0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
Apr  5 17:31:59 techno kernel: CPU: After vendor identify, caps: 
0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
Apr  5 17:32:00 techno kernel: CPU: After all inits, caps: 0383f9ff 
00000000 00000000 00000040 00000000 00000000 00000000
Apr  5 17:32:09 techno kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Apr  5 17:32:23 techno kernel: parport_pc: VIA 686A/8231 detected
Apr  5 17:32:23 techno kernel: parport_pc: probing current configuration
Apr  5 17:32:23 techno kernel: parport_pc: Current parallel port base: 0x378
Apr  5 17:32:23 techno kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
Apr  5 17:32:23 techno kernel: parport0 (bw-qcam): use data_reverse for 
this!
Apr  5 17:32:23 techno kernel: Probing IDE interface ide0...
Apr  5 17:32:23 techno kernel: Probing IDE interface ide1...
Apr  5 17:32:23 techno kernel: Probing IDE interface ide2...
Apr  5 17:32:23 techno kernel: Probing IDE interface ide3...
Apr  5 17:32:23 techno kernel: Probing IDE interface ide3...
Apr  5 17:32:23 techno kernel: Probing IDE interface ide4...
Apr  5 17:32:23 techno kernel: Probing IDE interface ide5...
Apr  5 17:32:23 techno kernel: hda: cache flushes not supported
Apr  5 17:32:24 techno kernel: hdc: cache flushes supported
Apr  5 17:32:24 techno kernel: hde: cache flushes supported
Apr  5 17:32:24 techno kernel: hdf: cache flushes supported
Apr  5 17:32:25 techno kernel: parport0: cannot grant exclusive access 
for device i2c-parport
Apr  5 17:32:25 techno kernel: eth0: no IPv6 routers present
Apr  5 17:32:34 techno kernel: eth0: no IPv6 routers present
Apr  5 17:33:02 techno pam_console[1966]: user is "techno"
Apr  5 17:33:02 techno pam_console[1966]: parsing config file 
/etc/security/console.perms
Apr  5 17:33:02 techno pam_console[1966]: check console tty1
Apr  5 17:33:02 techno pam_console[1966]: checking possible console "tty1"
Apr  5 17:33:02 techno pam_console[1966]: console tty1 is owned by UID 0
Apr  5 17:33:02 techno pam_console[1966]: console tty1 is a character device
Apr  5 17:33:22 techno pam_console[2034]: user is "root"
Apr  5 17:33:22 techno pam_console[2034]: user "root" is root
Apr  5 17:35:00 techno pam_console[1967]: user is "root"
Apr  5 17:35:00 techno pam_console[1967]: user "root" is root
</debug>
</2.6.11.3>

-- 
pozdrawiam     |"Help me master, I felt the burning twilight behind
techno@punkt.pl|those gates of stell..." --Perihelion, Prophecy Sequence
