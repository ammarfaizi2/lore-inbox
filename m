Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRDBMFt>; Mon, 2 Apr 2001 08:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRDBMFk>; Mon, 2 Apr 2001 08:05:40 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:11024 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S129393AbRDBMFa> convert rfc822-to-8bit; Mon, 2 Apr 2001 08:05:30 -0400
Date: Mon, 2 Apr 2001 14:04:28 +0200 (CEST)
From: Robert NEDBAL <R.Nedbal@sh.cvut.cz>
To: <linux-kernel@vger.kernel.org>
Subject: ReiserFS - corrupted files (2.4.3)
Message-ID: <Pine.BSF.4.31.0104021352030.24794-100000@veverka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm using ReiserFS on my primary filesystem and yesterday, I have found
that some files are corrupted. Yesterday I had to reset computer becase
X Window freezed. Maybe it caused this problem.

This comes from log:

It began yesterday 4 a.m., I havent figured it out at that time:
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110133 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110135 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110137 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110132 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110136 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110134 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 04:03:00 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 04:03:00 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 04:03:00 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110131 0x0 SD]
Apr  2 04:03:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found

Now I'm turning computer off and go to sleep :)

Hello morning, turning computer on again:
Apr  2 11:01:42 topo kernel: Linux version 2.4.3 (root@topo) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Pá bøe 30 17:48:56 CEST 2001
Apr  2 11:01:42 topo kernel: BIOS-provided physical RAM map:
Apr  2 11:01:42 topo kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Apr  2 11:01:42 topo kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (usable)
Apr  2 11:01:42 topo kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Apr  2 11:01:42 topo kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Apr  2 11:01:42 topo kernel:  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
Apr  2 11:01:42 topo kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb3d0, last bus=1
Apr  2 11:01:42 topo kernel: PCI: Using configuration type 1
Apr  2 11:01:42 topo kernel: PCI: Probing PCI hardware
Apr  2 11:01:42 topo kernel: PCI: Disabled enhanced CPU to PCI posting #2
Apr  2 11:01:42 topo kernel: PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Apr  2 11:01:42 topo kernel: Activating ISA DMA hang workarounds.
Apr  2 11:01:42 topo kernel: isapnp: Scanning for Pnp cards...
Apr  2 11:01:42 topo kernel: isapnp: No Plug & Play device found
Apr  2 11:01:42 topo kernel: Starting kswapd v1.8
Apr  2 11:01:42 topo kernel: block: queued sectors max/low 84080kB/28026kB, 256 slots per queue
Apr  2 11:01:42 topo kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Apr  2 11:01:42 topo kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr  2 11:01:42 topo kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Apr  2 11:01:42 topo kernel: VP_IDE: chipset revision 6
Apr  2 11:01:42 topo kernel: VP_IDE: not 100% native mode: will probe irqs later
Apr  2 11:01:42 topo kernel:     ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
Apr  2 11:01:42 topo kernel:     ide1: BM-DMA at 0xf408-0xf40f, BIOS settings: hdc:DMA, hdd:DMA
Apr  2 11:01:42 topo kernel: hda: WDC AC24300L, ATA DISK drive
Apr  2 11:01:42 topo kernel: hdc: IBM-DTLA-307045, ATA DISK drive
Apr  2 11:01:42 topo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr  2 11:01:42 topo kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr  2 11:01:42 topo kernel: hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=524/255/63, UDMA(33)
Apr  2 11:01:42 topo kernel: hdc: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, (U)DMA
Apr  2 11:01:42 topo kernel: Partition check:
Apr  2 11:01:42 topo kernel:  hda: hda1 hda2 < hda5 hda6 >
Apr  2 11:01:42 topo kernel:  hdc: hdc1 hdc2 hdc3
Apr  2 11:01:42 topo kernel: Floppy drive(s): fd0 is 1.44M
Apr  2 11:01:42 topo kernel: FDC 0 is a post-1991 82077
Apr  2 11:01:42 topo kernel: reiserfs: checking transaction log (device 16:03) ...
Apr  2 11:01:42 topo kernel: Using r5 hash to sort names
Apr  2 11:01:42 topo kernel: ReiserFS version 3.6.25
Apr  2 11:01:42 topo kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Apr  2 11:01:42 topo kernel: Adding Swap: 124956k swap-space (priority -1)
Apr  2 11:01:42 topo kernel: reiserfs: checking transaction log (device 16:02) ...
Apr  2 11:01:42 topo kernel: Using r5 hash to sort names
Apr  2 11:01:42 topo kernel: ReiserFS version 3.6.25
Apr  2 12:39:47 topo kernel: es1370: version v0.34 time 18:02:06 Mar 30 2001
Apr  2 12:39:47 topo kernel: PCI: Found IRQ 10 for device 00:0a.0
Apr  2 12:39:47 topo kernel: IRQ routing conflict in pirq table for device 00:0a.0
Apr  2 12:39:47 topo kernel: es1370: found adapter at io 0xf600 irq 9
Apr  2 12:39:47 topo kernel: es1370: features: joystick off, line in, mic impedance 0
Apr  2 12:41:14 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:41:14 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:41:14 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110131 0x0 SD]
Apr  2 12:41:14 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:42:42 topo last message repeated 2 times
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110132 0x0 SD]
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110133 0x0 SD]
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110134 0x0 SD]
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110135 0x0 SD]
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110136 0x0 SD]
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:44:56 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:44:56 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:44:56 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110137 0x0 SD]
Apr  2 12:44:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:45:06 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:47:28 topo kernel: loop: loaded (max 8 devices)
Apr  2 12:47:28 topo insmod: Note: /etc/modules.conf is more recent than /lib/modules/2.4.3/modules.dep
Apr  2 12:47:28 topo insmod: Note: /etc/modules.conf is more recent than /lib/modules/2.4.3/modules.dep
Apr  2 12:48:47 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:48:48 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:48:48 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:48:48 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:48:48 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:48:48 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:48:48 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:50:16 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:50:16 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:50:16 topo kernel: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [110073 110130 0xfffffffffffffff DIRECT]
Apr  2 12:50:16 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:50:16 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:50:16 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110131 0x0 SD]
Apr  2 12:50:16 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:50:35 topo last message repeated 5 times
Apr  2 12:50:51 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:50:51 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:50:51 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110133 0x0 SD]
Apr  2 12:50:51 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:50:51 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:50:51 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:50:51 topo kernel: is_leaf: item location seems wrong (second one): *NEW* [110073 110133 0x1 IND], item_len 44, item_location 3560, free_space(entry_count) 65535
Apr  2 12:50:51 topo kernel: vs-5150: search_by_key: invalid format found in block 43512. Fsck?
Apr  2 12:50:51 topo kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [110073 110132 0x0 SD]
Apr  2 12:50:51 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:50:52 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:50:52 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:50:52 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:50:56 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:53:39 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:53:53 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:53:57 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:53:58 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:53:58 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:53:59 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:53:59 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:53:59 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found
Apr  2 12:54:00 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110133) not found
Apr  2 12:54:01 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110135) not found
Apr  2 12:54:01 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110137) not found
Apr  2 12:54:02 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110132) not found
Apr  2 12:54:02 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110136) not found
Apr  2 12:54:02 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110134) not found
Apr  2 12:54:03 topo kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (110073 110131) not found


When I want to list corrupted directory, I get this:
[root@topo lisp]# ll
ls: diff.elc: Access denied
ls: dired-x.elc: Access denied
ls: dirtrack.elc: Access denied
ls: desktop.elc: Access denied
ls: dired.elc: Access denied
ls: dired-aux.elc: Access denied
ls: derived.elc: Access denied
total 0

Kernel version: 2.4.3

What should I to do? I fear to run reiserfsck, because I have heard it
makes things even worse. Please, please help me.

Thank for your replies (plz CC me as I'm not subscribed to the list),
Robert Nedbal

PS: sorry for my english, it's not my first language.

-- 
--------------------------------------------------------------------
Robert Nedbal - Czech Technical University in Prague, Czech Republic
email: R.Nedbal@sh.cvut.cz             http://www.sh.cvut.cz/~robik/
          /* Debuggers are evil. Never ever trust them. */
--------------------------------------------------------------------

