Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWHITGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWHITGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWHITGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:06:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39616 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751278AbWHITGk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:06:40 -0400
Message-Id: <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: Your message of "Sun, 06 Aug 2006 03:08:09 PDT."
             <20060806030809.2cfb0b1e.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155150395_4328P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 15:06:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155150395_4328P
Content-Type: text/plain; charset=us-ascii

On Sun, 06 Aug 2006 03:08:09 PDT, Andrew Morton said:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

Yum managed to get wedged: 'echo t > /proc/sysrq-trigger' says:

[ 4514.840000] yum           D D5C32AA0     0  4747   4430                     (NOTLB)
[ 4514.840000]        d5c3dda4 d5c3dd78 00000007 d5c32aa0 bd3ddd00 00000338 00000000 d5c32bc0
[ 4514.840000]        c1601628 d5c3dd9c 64600300 0000001f d5c3ddd8 d5c3ddd8 c1601628 d5c3ddac
[ 4514.840000]        c034fef8 d5c3ddb4 c0136e8e d5c3ddcc c0350026 c0136e58 d5c3ddd8 00000000
[ 4514.840000] Call Trace:
[ 4514.840000]  [<c034fef8>] io_schedule+0x25/0x44
[ 4514.840000]  [<c0136e8e>] sync_page+0x36/0x3a
[ 4514.840000]  [<c0350026>] __wait_on_bit_lock+0x30/0x58
[ 4514.840000]  [<c0136e44>] __lock_page+0x51/0x59
[ 4514.840000]  [<c013f099>] truncate_inode_pages_range+0x1de/0x230
[ 4514.840000]  [<c013f0f7>] truncate_inode_pages+0xc/0x11
[ 4514.840000]  [<c018ea12>] ext3_delete_inode+0x16/0xbd
[ 4514.840000]  [<c016798f>] generic_delete_inode+0xb6/0x130
[ 4514.840000]  [<c0167a1b>] generic_drop_inode+0x12/0x166
[ 4514.840000]  [<c01673f1>] iput+0x67/0x6a
[ 4514.840000]  [<c0165662>] dentry_iput+0x97/0xcc
[ 4514.840000]  [<c016613d>] dput+0x183/0x19c
[ 4514.840000]  [<c015f64f>] sys_renameat+0x17a/0x1d3
[ 4514.840000]  [<c015f6ba>] sys_rename+0x12/0x14
[ 4514.840000]  [<c0102849>] sysenter_past_esp+0x56/0x79

A careful check of the dmesg doesn't reveal anything particularly helpful,
like an oops or other relevant kernel message.

--==_Exmh_1155150395_4328P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE2jI7cC3lWbTT17ARAsjHAKCVyN/eG/9vuOY6+IWDPPfakssOiACfUPFE
UL8aZAhzczwABOUUbi2e2Yg=
=JPaq
-----END PGP SIGNATURE-----

--==_Exmh_1155150395_4328P--
