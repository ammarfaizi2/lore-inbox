Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272288AbTHDXSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272289AbTHDXSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:18:53 -0400
Received: from adsl-67-121-153-186.dsl.pltn13.pacbell.net ([67.121.153.186]:53205
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S272288AbTHDXSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:18:52 -0400
Date: Mon, 4 Aug 2003 16:18:50 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: interesting oops - 2.6.0-test2-mm2
Message-ID: <20030804231850.GA7816@firesong>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This was the interesting result of 'less -f /dev/kmem' on 2.6.0-test2-mm2:

<1>Unable to handle kernel NULL pointer dereference at virtual address 0000=
0020
 printing eip:
c01b9d4a
*pde =3D 00000000
Oops: 0000 [#3]
PREEMPT
CPU:    0
EIP:    0060:[<c01b9d4a>]    Not tainted VLI
EFLAGS: 00010296
EIP is at __copy_user_intel+0x16/0xac
eax: 00000004   ebx: 00000000   ecx: 00002000   edx: 0806546c
esi: 00000000   edi: 0806346c   ebp: 00000000   esp: c6401f18
ds: 007b   es: 007b   ss: 0068
Process less (pid: 7815, threadinfo=3Dc6400000 task=3Dc400b900)
Stack: 00000000 0806346c c01b9ef4 0806346c 00000000 00002000 0806346c 00002=
000
       c01e48b6 0806346c 00000000 00002000 ce0fcbd4 0000000a 0000000a 08060=
42a
       c01ebd1f 00000000 00002000 00000000 c8134480 c81344a0 00002000 c0150=
344
Call Trace:
 [<c01b9ef4>] __copy_to_user_ll+0x68/0x6c
 [<c01e48b6>] read_kmem+0x158/0x15f
 [<c01ebd1f>] write_chan+0x0/0x255
 [<c0150344>] vfs_read+0xb0/0x119
 [<c01505eb>] sys_read+0x42/0x63
 [<c0109167>] syscall_call+0x7/0xb

Code: 29 ca 01 d0 8b 7c 24 08 21 f0 8b 1c 24 8b 74 24 04 83 c4 0c c3 83 ec =
08 89 34 24 89 7c 24 04 8b 4c 24 14 8b 7c 24=20
0c 8b 74 24 10 <8b> 46 20 83 f9 43 76 04 8b 46 40 90 8b 46 00 8b 56 04 89 4=
7 00

I'm not worried, I was explicitly trying to find ways to oops my kernel :)

-Josh

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LunaT2bz5yevw+4RAuoPAJ4su0B48uziyPd0VUNe9btplk/WEACeLjfD
oLvCivTHx/p7orfHZPloIEU=
=f5uD
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
