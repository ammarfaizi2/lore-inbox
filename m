Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUKVPfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUKVPfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKVOjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:39:42 -0500
Received: from dialpool1-74.dial.tijd.com ([62.112.10.74]:35464 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261370AbUKVOaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:30:30 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-rc2] XFS filesystem corruption
User-Agent: KMail/1.7.1
Cc: linux-xfs@oss.sgi.com
MIME-Version: 1.0
Date: Mon, 22 Nov 2004 15:30:29 +0100
Content-Type: multipart/signed;
  boundary="nextPart1804421.FSafbFRWjE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411221530.30325.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1804421.FSafbFRWjE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello lists,

[resend with correct email address for LKML]

[Please CC all answers from linux-xfs to me, since I'm not subscribed on th=
at list]

Yesterday I encountered an on-the-fly corruption of my /home filesystem. It=
 worked perfectly one second, the next I hit these nice errors:

Nov 21 16:37:22 precious kernel: 0x0: 31 9e ce 63 cf ff 9c cf ff 31 61 63 f=
f ff ff ff=20
Nov 21 16:37:23 precious kernel: Filesystem "hda5": XFS internal error xfs_=
da_do_buf(2) at line 2273 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01fb908
Nov 21 16:37:23 precious kernel:  [xfs_da_do_buf+905/2160] xfs_da_do_buf+0x=
389/0x870
Nov 21 16:37:23 precious kernel:  [xfs_da_read_buf+88/96] xfs_da_read_buf+0=
x58/0x60
Nov 21 16:37:23 precious last message repeated 2 times
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_lookup_int+386/720] xfs_di=
r2_leaf_lookup_int+0x182/0x2d0
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_lookup_int+386/720] xfs_di=
r2_leaf_lookup_int+0x182/0x2d0
Nov 21 16:37:23 precious kernel:  [__wake_up_common+65/112] __wake_up_commo=
n+0x41/0x70
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_lookup+55/224] xfs_dir2_le=
af_lookup+0x37/0xe0
Nov 21 16:37:23 precious kernel:  [xfs_dir2_lookup+298/352] xfs_dir2_lookup=
+0x12a/0x160
Nov 21 16:37:23 precious kernel:  [xfs_dir_lookup_int+76/304] xfs_dir_looku=
p_int+0x4c/0x130
Nov 21 16:37:23 precious kernel:  [xfs_lookup+80/144] xfs_lookup+0x50/0x90
Nov 21 16:37:23 precious kernel:  [linvfs_lookup+82/144] linvfs_lookup+0x52=
/0x90
Nov 21 16:37:23 precious kernel:  [real_lookup+193/240] real_lookup+0xc1/0x=
f0
Nov 21 16:37:23 precious kernel:  [do_lookup+150/176] do_lookup+0x96/0xb0
Nov 21 16:37:23 precious kernel:  [link_path_walk+1732/3424] link_path_walk=
+0x6c4/0xd60
Nov 21 16:37:23 precious kernel:  [link_path_walk+2603/3424] link_path_walk=
+0xa2b/0xd60
Nov 21 16:37:23 precious kernel:  [cp_new_stat64+248/272] cp_new_stat64+0xf=
8/0x110
Nov 21 16:37:23 precious kernel:  [path_lookup+124/320] path_lookup+0x7c/0x=
140
Nov 21 16:37:23 precious kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
Nov 21 16:37:23 precious kernel:  [dput+51/544] dput+0x33/0x220
Nov 21 16:37:23 precious kernel:  [sys_access+133/336] sys_access+0x85/0x150
Nov 21 16:37:23 precious kernel:  [path_release+21/80] path_release+0x15/0x=
50
Nov 21 16:37:23 precious kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 21 16:37:23 precious kernel: 0x0: 31 9e ce 63 cf ff 9c cf ff 31 61 63 f=
f ff ff ff=20
Nov 21 16:37:23 precious kernel: Filesystem "hda5": XFS internal error xfs_=
da_do_buf(2) at line 2273 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01fb908
Nov 21 16:37:23 precious kernel:  [xfs_da_do_buf+905/2160] xfs_da_do_buf+0x=
389/0x870
Nov 21 16:37:23 precious kernel:  [xfs_da_read_buf+88/96] xfs_da_read_buf+0=
x58/0x60
Nov 21 16:37:23 precious last message repeated 2 times
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_lookup_int+386/720] xfs_di=
r2_leaf_lookup_int+0x182/0x2d0
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_lookup_int+386/720] xfs_di=
r2_leaf_lookup_int+0x182/0x2d0
Nov 21 16:37:23 precious kernel:  [__wake_up_common+65/112] __wake_up_commo=
n+0x41/0x70
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_lookup+55/224] xfs_dir2_le=
af_lookup+0x37/0xe0
Nov 21 16:37:23 precious kernel:  [xfs_dir2_lookup+298/352] xfs_dir2_lookup=
+0x12a/0x160
Nov 21 16:37:23 precious kernel:  [xfs_dir_lookup_int+76/304] xfs_dir_looku=
p_int+0x4c/0x130
Nov 21 16:37:23 precious kernel:  [xfs_lookup+80/144] xfs_lookup+0x50/0x90
Nov 21 16:37:23 precious kernel:  [linvfs_lookup+82/144] linvfs_lookup+0x52=
/0x90
Nov 21 16:37:23 precious kernel:  [real_lookup+193/240] real_lookup+0xc1/0x=
f0
Nov 21 16:37:23 precious kernel:  [do_lookup+150/176] do_lookup+0x96/0xb0
Nov 21 16:37:23 precious kernel:  [link_path_walk+1732/3424] link_path_walk=
+0x6c4/0xd60
Nov 21 16:37:23 precious kernel:  [link_path_walk+2603/3424] link_path_walk=
+0xa2b/0xd60
Nov 21 16:37:23 precious kernel:  [cp_new_stat64+248/272] cp_new_stat64+0xf=
8/0x110
Nov 21 16:37:23 precious kernel:  [path_lookup+124/320] path_lookup+0x7c/0x=
140
Nov 21 16:37:23 precious kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
Nov 21 16:37:23 precious kernel:  [sys_access+133/336] sys_access+0x85/0x150
Nov 21 16:37:23 precious kernel:  [path_release+21/80] path_release+0x15/0x=
50
Nov 21 16:37:23 precious kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 21 16:37:23 precious kernel: 0x0: 10 10 10 10 10 10 00 00 21 10 10 10 1=
0 10 10 10=20
Nov 21 16:37:23 precious kernel: Filesystem "hda5": XFS internal error xfs_=
da_do_buf(2) at line 2273 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01fb908
Nov 21 16:37:23 precious kernel:  [xfs_da_do_buf+905/2160] xfs_da_do_buf+0x=
389/0x870
Nov 21 16:37:23 precious kernel:  [xfs_da_read_buf+88/96] xfs_da_read_buf+0=
x58/0x60
Nov 21 16:37:23 precious kernel:  [xfs_da_read_buf+88/96] xfs_da_read_buf+0=
x58/0x60
Nov 21 16:37:23 precious kernel:  [xfs_initialize_vnode+780/800] xfs_initia=
lize_vnode+0x30c/0x320
Nov 21 16:37:23 precious kernel:  [xfs_da_read_buf+88/96] xfs_da_read_buf+0=
x58/0x60
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_addname+875/2688] xfs_dir2=
_leaf_addname+0x36b/0xa80
Nov 21 16:37:23 precious kernel:  [xfs_dir2_leaf_addname+875/2688] xfs_dir2=
_leaf_addname+0x36b/0xa80
Nov 21 16:37:23 precious kernel:  [xfs_bmap_last_offset+197/304] xfs_bmap_l=
ast_offset+0xc5/0x130
Nov 21 16:37:23 precious kernel:  [xfs_dir2_isleaf+44/112] xfs_dir2_isleaf+=
0x2c/0x70
Nov 21 16:37:23 precious kernel:  [xfs_dir2_createname+341/384] xfs_dir2_cr=
eatename+0x155/0x180
Nov 21 16:37:23 precious kernel:  [xfs_dir_ialloc+145/736] xfs_dir_ialloc+0=
x91/0x2e0
Nov 21 16:37:23 precious kernel:  [xfs_trans_ijoin+53/144] xfs_trans_ijoin+=
0x35/0x90
Nov 21 16:37:23 precious kernel:  [xfs_create+1115/1888] xfs_create+0x45b/0=
x760
Nov 21 16:37:23 precious kernel:  [linvfs_mknod+475/576] linvfs_mknod+0x1db=
/0x240
Nov 21 16:37:23 precious kernel:  [xfs_dir2_lookup+298/352] xfs_dir2_lookup=
+0x12a/0x160
Nov 21 16:37:23 precious kernel:  [real_lookup+193/240] real_lookup+0xc1/0x=
f0
Nov 21 16:37:23 precious kernel:  [dput+51/544] dput+0x33/0x220
Nov 21 16:37:23 precious kernel:  [xfs_dir_lookup_int+76/304] xfs_dir_looku=
p_int+0x4c/0x130
Nov 21 16:37:23 precious kernel:  [permission+53/96] permission+0x35/0x60
Nov 21 16:37:23 precious kernel:  [vfs_create+121/224] vfs_create+0x79/0xe0
Nov 21 16:37:23 precious kernel:  [open_namei+1462/1552] open_namei+0x5b6/0=
x610
Nov 21 16:37:23 precious kernel:  [filp_open+62/112] filp_open+0x3e/0x70
Nov 21 16:37:23 precious kernel:  [get_unused_fd+57/224] get_unused_fd+0x39=
/0xe0
Nov 21 16:37:23 precious kernel:  [sys_open+73/144] sys_open+0x49/0x90
Nov 21 16:37:23 precious kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 21 16:37:23 precious kernel: xfs_force_shutdown(hda5,0x8) called from l=
ine 1091 of file fs/xfs/xfs_trans.c.  Return address =3D 0xc0244e4b
Nov 21 16:37:23 precious kernel: Filesystem "hda5": Corruption of in-memory=
 data detected.  Shutting down filesystem: hda5
Nov 21 16:37:23 precious kernel: Please umount the filesystem, and rectify =
the problem(s)

Doing an unmount/remount didn't solve it, i had to run xfs_repair on the fi=
lesystem to get it back to 'work', which caused me to lose=20
a lot of stuff. (thank <deity> for backups.)=20

Any idea what can cause this?

Thanks,

Jan

=2D-=20
What's the MATTER Sid? ... Is your BEVERAGE unsatisfactory?

--nextPart1804421.FSafbFRWjE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBofgGUQQOfidJUwQRAnYBAJ9xOG7UpqqV+EpWvKdhsJ5tyAf3awCfemAL
ccy405zgbhzS6nQJD67uX5A=
=lRFH
-----END PGP SIGNATURE-----

--nextPart1804421.FSafbFRWjE--
