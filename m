Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTGTEOW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 00:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTGTEOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 00:14:22 -0400
Received: from adsl-67-124-157-42.dsl.pltn13.pacbell.net ([67.124.157.42]:992
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S261741AbTGTEOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 00:14:19 -0400
Date: Sat, 19 Jul 2003 21:29:18 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm2
Message-ID: <20030720042918.GA19219@triplehelix.org>
References: <20030719174350.7dd8ad59.akpm@osdl.org> <20030720024102.GA18576@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20030720024102.GA18576@triplehelix.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2003 at 07:41:02PM -0700, Joshua Kwan wrote:
> 2.6.0-test1-mm2 requires attached patch to build with software suspend.

That and it just spilled its guts all over me.

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0194e8f
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
CPU:    0
EIP:    0060:[<c0194e8f>]    Not tainted VLI
EFLAGS: 00210202
EIP is at journal_dirty_metadata+0x41/0x207
eax: c0a6e000   ebx: cf4b3e00   ecx: 00000000   edx: cf96ef60
esi: 00000000   edi: cf732e80   ebp: cf96a910   esp: c0a6fe78
ds: 007b   es: 007b   ss: 0068
Process cvs (pid: 8960, threadinfo=3Dc0a6e000 task=3Dc7d01940)
Stack: c1373600 cf85bb90 c0152a7a c0151389 cf96ef60 cf96ef60 cf96a910 00000=
001=20
       cf85bb90 c0186674 cf96a910 cf96ef60 00001000 c0a6febc 00000001 00000=
001=20
       00000000 00000030 00000000 00000000 0000001a 000e0224 cf955ed0 00004=
000=20
Call Trace:
 [<c0152a7a>] __getblk+0x2b/0x51
 [<c0151389>] wake_up_buffer+0xf/0x26
 [<c0186674>] ext3_getblk+0xdb/0x284
 [<c0186850>] ext3_bread+0x33/0xb6
 [<c018c17c>] ext3_mkdir+0xd1/0x2c6
 [<c018c0ab>] ext3_mkdir+0x0/0x2c6
 [<c015f01c>] vfs_mkdir+0x6a/0xbc
 [<c015f125>] sys_mkdir+0xb7/0xf6
 [<c014558f>] sys_munmap+0x44/0x64
 [<c0109167>] syscall_call+0x7/0xb

Code: 28 8b 54 24 2c 8b 5d 00 f6 45 18 04 8b 72 24 8b 3b 0f 85 d8 00 00
00 f6 07 02 0f 85 cf 00 00 00 b8 00 e0 ff ff 21 e0 83 40 14 01 <8b> 46
14 3b 45 00 0f 84 6e 01 00 00 b8 00 e0 ff ff 21 e0 83 40=20
 <6>note: cvs[8960] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011a503>] schedule+0x3f6/0x3fb
 [<c0141b8c>] unmap_page_range+0x43/0x69
 [<c0141d63>] unmap_vmas+0x1b1/0x209
 [<c0145874>] exit_mmap+0x7c/0x190
 [<c011bec4>] mmput+0x7b/0xe4
 [<c011f9ec>] do_exit+0x120/0x3f8
 [<c01188e4>] do_page_fault+0x0/0x459
 [<c0109a06>] do_divide_error+0x0/0xfa
 [<c0118a10>] do_page_fault+0x12c/0x459
 [<c0189275>] ext3_mark_iloc_dirty+0x28/0x35
 [<c01893aa>] ext3_mark_inode_dirty+0x4f/0x51
 [<c0186087>] ext3_splice_branch+0x123/0x1da
 [<c0152935>] bh_lru_install+0xaf/0xeb
 [<c01188e4>] do_page_fault+0x0/0x459
 [<c0109391>] error_code+0x2d/0x38
 [<c015007b>] vfs_read+0xef/0x119
 [<c0194e8f>] journal_dirty_metadata+0x41/0x207
 [<c0152a7a>] __getblk+0x2b/0x51
 [<c0151389>] wake_up_buffer+0xf/0x26
 [<c0186674>] ext3_getblk+0xdb/0x284
 [<c0186850>] ext3_bread+0x33/0xb6
 [<c018c17c>] ext3_mkdir+0xd1/0x2c6
 [<c018c0ab>] ext3_mkdir+0x0/0x2c6
 [<c015f01c>] vfs_mkdir+0x6a/0xbc
 [<c015f125>] sys_mkdir+0xb7/0xf6
 [<c014558f>] sys_munmap+0x44/0x64
 [<c0109167>] syscall_call+0x7/0xb

Any ideas?

-Josh

--=20
Using words to describe magic is like using a screwdriver to cut roast beef.
		-- Tom Robbins

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/GhqeT2bz5yevw+4RAkUIAJsGvo+iTwM/2AfjqgsE1AQv64cYuACffDIL
BhVLYdT2nBALz+F6SErGedo=
=D7k5
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
