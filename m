Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTJMAus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 20:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTJMAus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 20:50:48 -0400
Received: from bgp01038448bgs.sothwt01.mi.comcast.net ([68.43.98.24]:3712 "EHLO
	fire-eyes.dynup.net") by vger.kernel.org with ESMTP id S261299AbTJMAuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 20:50:25 -0400
Subject: 2.6.0-test7: ide / reiserfs errors? (reiserfs_read_locked_inode)
From: fire-eyes <sgtphou@fire-eyes.dynup.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4+QLQVPwGE3J5j6Q0z+0"
Message-Id: <1066006220.2347.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 12 Oct 2003 20:50:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4+QLQVPwGE3J5j6Q0z+0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is my first real post to the list. If I can better provide
information, please let me know, so I can give the best possible data.
Thanks for any hand-holding, and keep up the great work.

I am seeing ide/reiserfs errors in 2.6.0-test7. I did not stick around
long enough to investigate futher than what you see below:


System
Asus A7M266-D motherboard
Two AMD XP+ 1800 CPUs
512MB DDR RAM
Disk drive: hda: ST3120023A, ATA DISK drive



Paramaters passed to kernel via grub: root=3D/dev/hda6 idebus=3D66
ide0=3Data66 ide1=3Data66

I may be confused as to how the bus speed is set in 2.6, but I did not
have these problems in 2.6.0-test6 or earlier.

/var/log/syslog (hopefully this comes out sane):

Oct 12 20:19:49 localhost kernel: blk: queue dfd93c00, I/O limit 4095Mb
(mask 0xffffffff)
Oct 12 20:19:49 localhost kernel: hda: dma_intr: status=3D0x58 {
DriveReady SeekComplete DataRequest }
Oct 12 20:19:49 localhost kernel:=20
Oct 12 20:19:49 localhost kernel: hda: set_drive_speed_status:
status=3D0x58 { DriveReady SeekComplete DataRequest }
Oct 12 20:19:49 localhost kernel: ide0: Drive 0 didn't accept speed
setting. Oh, well.
Oct 12 20:19:49 localhost kernel: is_leaf: nr_item seems wrong: level=3D1,
nr_items=3D0, free_space=3D0 rdkey=20
Oct 12 20:19:49 localhost kernel: vs-5150: search_by_key: invalid format
found in block 1033191. Fsck?
Oct 12 20:19:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [373169 373170 0x0 SD]
Oct 12 20:19:49 localhost kernel: blk: queue dfd93800, I/O limit 4095Mb
(mask 0xffffffff)
Oct 12 20:19:49 localhost xinetd[3940]: Reading included configuration
file: /etc/xinetd.d/telnetd [file=3D/etc/xinetd.d/telnetd] [line=3D15]
Oct 12 20:19:49 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:19:49 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:19:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6549 497433 0x0 SD]

[later]

Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:20:41 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:20:41 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:20:41 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:21:15 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:21:15 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:21:15 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:21:22 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:21:22 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:21:22 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:21:22 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:21:22 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:21:22 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:22:49 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:22:49 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:22:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:23:07 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:23:07 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6549 123379 0x0 SD]
Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6549 118884 0x0 SD]
Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?
Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
i/o failure occurred trying to find stat data of [6549 496832 0x0 SD]
Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
not match to the expected one 1
Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
found in block 23404. Fsck?

This goes on for quite a while.

--=-4+QLQVPwGE3J5j6Q0z+0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/ifbM+yxhoW3DHu4RAsGiAKCDehbb2m6eIbRs0WivHtqgqxNgNACffur4
XgttQkYnSDOib18/pWZn/+8=
=JefF
-----END PGP SIGNATURE-----

--=-4+QLQVPwGE3J5j6Q0z+0--

