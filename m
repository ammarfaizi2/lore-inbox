Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUHBDtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUHBDtn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHBDtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:49:42 -0400
Received: from [202.157.148.44] ([202.157.148.44]:25049 "EHLO
	apollo.dmz1.securecirt.com") by vger.kernel.org with ESMTP
	id S266244AbUHBDtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:49:17 -0400
Subject: Possible XFS Corruption
From: Callan Tham <callan.tham@securecirt.com>
Reply-To: callan.tham@securecirt.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BIn3PKOWTxM0Zlj3v2IB"
Organization: SecureCiRT Pte Ltd
Message-Id: <1091418545.6750.12.camel@taz.lan.securecirt.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 11:49:05 +0800
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.585, required 3,
	autolearn=not spam, AWL 2.31, BAYES_00 -4.90)
X-MailScanner-Envelope-From: callan.tham@securecirt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BIn3PKOWTxM0Zlj3v2IB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi list,

I'm running a Gentoo-patched 2.6.7 kernel, and am experiencing possible
XFS corruption on one of my partitions. I've included a sample of the
logs I've managed to see here:

Filesystem "hda1": XFS internal error xfs_da_do_buf(2) at line 2273 of
file fs/xfs/xfs_da_btree.c.  Caller 0xc02420ec
[<c0241b2f>] xfs_da_do_buf+0x41f/0x960
[<c02420ec>] xfs_da_read_buf+0x3c/0x40
[<c02420ec>] xfs_da_read_buf+0x3c/0x40
[<c02420ec>] xfs_da_read_buf+0x3c/0x40
[<c0249611>] xfs_dir2_leaf_lookup_int+0x41/0x280
[<c0249611>] xfs_dir2_leaf_lookup_int+0x41/0x280
[<c0132a80>] do_generic_mapping_read+0x180/0x3a0
[<c02340e9>] xfs_bmap_last_offset+0xa9/0x120
[<c0249540>] xfs_dir2_leaf_lookup+0x20/0xb0
[<c02441f2>] xfs_dir2_lookup+0x112/0x130
[<c0132ca0>] file_read_actor+0x0/0xe0
[<c0283687>] xfs_read+0x197/0x250
[<c02736dc>] xfs_dir_lookup_int+0x2c/0xe0
[<c02781e7>] xfs_lookup+0x37/0x70
[<c0282aaa>] linvfs_lookup+0x4a/0x90
[<c015700f>] real_lookup+0xaf/0xd0
[<c0157218>] do_lookup+0x68/0x80
[<c0157628>] link_path_walk+0x3f8/0x7d0
[<c0157c06>] path_lookup+0x66/0x110
[<c015489f>] open_exec+0x1f/0xe0
[<c015499c>] kernel_read+0x3c/0x50
[<c016f8cf>] load_elf_binary+0xaef/0xb70
[<c011bd3d>] mm_init+0x8d/0xc0
[<c0135d52>] buffered_rmqueue+0xd2/0x180
[<c0135ead>] __alloc_pages+0xad/0x340
[<c013605b>] __alloc_pages+0x25b/0x340
[<c0291628>] __copy_from_user_ll+0x58/0x60
[<c0155411>] search_binary_handler+0x51/0x1a0
[<c015570b>] do_execve+0x1ab/0x230
[<c01049de>] sys_execve+0x2e/0x60
[<c0105d07>] syscall_call+0x7/0xb

This is not the first time I have seen this error, and am wondering if
it is something anyone has experienced regularly. Any help in diagnosing
this problem is greatly appreciated.

Please CC me any replies, as I'm not subscribed to the list at this
address. Thanks in advance!

Callan

--=-BIn3PKOWTxM0Zlj3v2IB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBDbmvL0kD4kWwAZQRAvDoAKCQp34j0Xhh0Mvd9suV9JqEVhF3SQCdEAyc
CIUrHXJRZm4eI6xWWp3IHs4=
=NeFF
-----END PGP SIGNATURE-----

--=-BIn3PKOWTxM0Zlj3v2IB--

