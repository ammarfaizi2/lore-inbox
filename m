Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTAKFiy>; Sat, 11 Jan 2003 00:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTAKFiy>; Sat, 11 Jan 2003 00:38:54 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:41708 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267090AbTAKFix>; Sat, 11 Jan 2003 00:38:53 -0500
Date: Sat, 11 Jan 2003 06:47:27 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.56
Message-Id: <20030111064727.0e494512.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.8claws22 (GTK+ 1.2.10; Linux 2.5.56)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.+OM.)5XI/Klwhb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.+OM.)5XI/Klwhb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2003 12:26:56 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.55 to v2.5.56
LT> ============================================

Hello,

I just got the following bug with 2.5.56 pretty much out of the blue:

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1182
Call Trace:
 [<c0147105>] __brelse+0x35/0x40
 [<c01472c9>] bh_lru_install+0xa9/0xe0
 [<c0147371>] __find_get_block+0x71/0x80
 [<c0146fa3>] __getblk_slow+0x23/0x100
 [<c01473cf>] __getblk+0x4f/0x60
 [<c01473ff>] __bread+0x1f/0x40
 [<c0180265>] ext3_get_inode_loc+0xe5/0x190
 [<c018033f>] ext3_read_inode+0x2f/0x390
 [<c015cd5e>] iget_locked+0x6e/0x70
 [<c0182908>] ext3_lookup+0xe8/0x100
 [<c0151330>] real_lookup+0xc0/0x100
 [<c015159a>] do_lookup+0x11a/0x170
 [<c01519e2>] link_path_walk+0x3f2/0x790
 [<c0152239>] __user_walk+0x49/0x60
 [<c014d8fc>] vfs_lstat+0x1c/0x60
 [<c014df3b>] sys_lstat64+0x1b/0x40
 [<c010933b>] syscall_call+0x7/0xb

Regards,
-Udo.

--=.+OM.)5XI/Klwhb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+H6/ynhRzXSM7nSkRAurmAJkBQbViQE4ogHTJPRe79BdQTKgk2gCffICa
ziwx8/mDKEn3vV20jty/56Q=
=SxnB
-----END PGP SIGNATURE-----

--=.+OM.)5XI/Klwhb--
