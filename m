Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWFPOJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWFPOJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFPOJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:09:26 -0400
Received: from flexserv.de ([213.239.215.214]:18381 "EHLO lion.flexserv.de")
	by vger.kernel.org with ESMTP id S1751407AbWFPOJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:09:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Bug: XFS internal error XFS_WANT_CORRUPTED_RETURN
Organization: Flexserv
From: daniel+devel.linux.lkml@flexserv.de
X-GPG-ID: 0x7B196671
X-GPG-FP: A9CE 5788 44D3 A1A2 46B6  A727 53D8 DD4B 7B19 6671
X-message-flag: Formating hard disk. please wait...   10%...   20%...
Date: Fri, 16 Jun 2006 16:09:11 +0200
Message-ID: <878xnx19bs.fsf@xserver.flexserv.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Running 2.6.17-rc6
same when running it inside a new created partition.
No matter if on sda or inside a lvm on sdb
Reproducible.
Kernel is compiled with debug symbols i think.
What additional informatiuon can i get you?
Daniel


XFS internal error XFS_WANT_CORRUPTED_RETURN at line 298 of file
fs/xfs/xfs_alloc.c.  Caller 0x0000000000586974
Call Trace:
 [000000000058646c] xfs_alloc_ag_vextent+0x16c/0x1a0
 [0000000000588b84] xfs_alloc_vextent+0x384/0x480
 [0000000000595be0] xfs_bmap_btalloc+0x240/0x700
 [0000000000598da8] xfs_bmapi+0xc08/0xec0
 [00000000005be2ec] xfs_iomap_write_allocate+0x18c/0x3a0
 [00000000005bd69c] xfs_iomap+0x27c/0x360
 [00000000005da1ac] xfs_map_blocks+0x2c/0x80
 [00000000005db33c] xfs_page_state_convert+0x3bc/0x640
 [00000000005db638] xfs_vm_writepage+0x78/0x140
 [00000000004c71e4] mpage_writepages+0x244/0x3c0
 [000000000047ef40] do_writepages+0x60/0x80
 [00000000004c5310] __sync_single_inode+0x50/0x240
 [00000000004c5590] __writeback_single_inode+0x90/0x180
 [00000000004c586c] sync_sb_inodes+0x1ec/0x320
 [00000000004c5a80] writeback_inodes+0xe0/0x120
 [000000000047ec34] wb_kupdate+0xb4/0x160
XFS internal error XFS_WANT_CORRUPTED_RETURN at line 298 of file
fs/xfs/xfs_alloc.c.  Caller 0x0000000000586974
Call Trace:
 [000000000058646c] xfs_alloc_ag_vextent+0x16c/0x1a0
 [0000000000588b84] xfs_alloc_vextent+0x384/0x480
 [0000000000595be0] xfs_bmap_btalloc+0x240/0x700
 [0000000000598da8] xfs_bmapi+0xc08/0xec0
 [00000000005be2ec] xfs_iomap_write_allocate+0x18c/0x3a0
 [00000000005bd69c] xfs_iomap+0x27c/0x360
 [00000000005da1ac] xfs_map_blocks+0x2c/0x80
 [00000000005db33c] xfs_page_state_convert+0x3bc/0x640
 [00000000005db638] xfs_vm_writepage+0x78/0x140
 [00000000004c71e4] mpage_writepages+0x244/0x3c0
 [000000000047ef40] do_writepages+0x60/0x80
 [00000000004c5310] __sync_single_inode+0x50/0x240
 [00000000004c5590] __writeback_single_inode+0x90/0x180
 [00000000004c586c] sync_sb_inodes+0x1ec/0x320
 [00000000004c5a80] writeback_inodes+0xe0/0x120
 [000000000047ec34] wb_kupdate+0xb4/0x160

bilbao:~#
bilbao:~# XFS internal error XFS_WANT_CORRUPTED_RETURN at line 298 of
file fs/xfs/xfs_alloc.c.  Caller 0x0000000000586974
Call Trace:
 [000000000058646c] xfs_alloc_ag_vextent+0x16c/0x1a0
 [0000000000588b84] xfs_alloc_vextent+0x384/0x480
 [0000000000595be0] xfs_bmap_btalloc+0x240/0x700
 [0000000000598da8] xfs_bmapi+0xc08/0xec0
 [00000000005a518c] xfs_dir2_grow_inode+0x8c/0x2c0
 [00000000005a69dc] xfs_dir2_sf_to_block+0x7c/0x520
 [00000000005abfc0] xfs_dir2_sf_addname+0xe0/0x1a0
 [00000000005a4a90] xfs_dir2_createname+0x130/0x160
 [00000000005d6c3c] xfs_mkdir+0x3dc/0x660
 [00000000005e1d60] xfs_vn_mknod+0x360/0x420
 [00000000004aff90] vfs_mkdir+0x90/0x140
 [00000000004b00f0] sys_mkdirat+0xb0/0x100
 [0000000000406bd4] linux_sparc_syscall32+0x34/0x40
 [0000000000010ba8] 0x10ba8
Filesystem "sda2": XFS internal error xfs_trans_cancel at line 1150 of
file fs/xfs/xfs_trans.c.  Caller 0x00000000005d6abc
Call Trace:
 [00000000005e1d60] xfs_vn_mknod+0x360/0x420
 [00000000004aff90] vfs_mkdir+0x90/0x140
 [00000000004b00f0] sys_mkdirat+0xb0/0x100
 [0000000000406bd4] linux_sparc_syscall32+0x34/0x40
 [0000000000010ba8] 0x10ba8
xfs_force_shutdown(sda2,0x8) called from line 1151 of file
fs/xfs/xfs_trans.c.  Return address = 0x00000000005e57fc
Filesystem "sda2": Corruption of in-memory data detected.  Shutting down
filesystem: sda2
Please umount the filesystem, and rectify the problem(s)


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkruKU9jdS3sZZnERAtIMAJwJiCpFCdv4nOU+VvlKkn9OK9vN5ACeMZ/N
kx477OV7kwFrkGrzkkRZG2o=
=D7mh
-----END PGP SIGNATURE-----
--=-=-=--

