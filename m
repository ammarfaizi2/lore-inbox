Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTEJFXL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 01:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTEJFXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 01:23:11 -0400
Received: from adsl-67-124-157-215.dsl.pltn13.pacbell.net ([67.124.157.215]:1760
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263657AbTEJFXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 01:23:09 -0400
Date: Fri, 9 May 2003 22:35:48 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: OOPS in smbfs module - 2.5.69-mm1
Message-ID: <20030510053548.GA23841@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Got this trying to mount my MP3 partition in 2.5.69-mm1...

Unable to handle kernel paging request at virtual address af0272f7
 printing eip:
d4c8ffe9
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d4c8ffe9>]    Not tainted VLI
EFLAGS: 00010246
EIP is at find_request+0x15/0x45 [smbfs]
eax: cfa0c1a4   ebx: cfa0c180   ecx: 00000000   edx: c464ce80
esi: 00000000   edi: cfa0c180   ebp: d4c94e98   esp: ce513f64
ds: 007b   es: 007b   ss: 0068
Process smbiod (pid: 5051, threadinfo=3Dce512000 task=3Dc3bec690)
Stack: cfa0c180 00000025 00000000 d4c905a9 cfa0c180 00000000 cfa0c1e8 cfa0c=
180=20
       00000007 d4c8f542 cfa0c180 cfa0c1e8 cfa0c180 ce512000 d4c8f69e cfa0c=
180=20
       d4c94f0c d4c90f1e 000001c9 ce512000 ce512000 ce512000 ce512000 00000=
000=20
Call Trace:
 [<d4c905a9>] smb_request_recv+0x152/0x20a [smbfs]
 [<d4c8f542>] smbiod_doio+0x25/0xa3 [smbfs]
 [<d4c8f69e>] smbiod+0xde/0x251 [smbfs]
 [<d4c94f0c>] +0xc/0x200 [smbfs]
 [<d4c90f1e>] +0x30e/0x350 [smbfs]
 [<c011757b>] default_wake_function+0x0/0x12
 [<d4c94e90>] smbiod_wait+0x0/0x8 [smbfs]
 [<d4c94e90>] smbiod_wait+0x0/0x8 [smbfs]
 [<d4c8f5c0>] smbiod+0x0/0x251 [smbfs]
 [<c010706d>] kernel_thread_helper+0x5/0xb

Code: 1b 8b 46 1c 89 58 04 89 03 89 7b 04 89 5e 1c b8 fb ff ff ff eb ac
57 31 c9 56 53 8b 7c 24 10 8b 74 24 14 8b 57 24 8b 02 0f 18 00 <63> 8d
5f 24 39 da 74 15 39 72 18 89 d1 74 0e 89 c2 31 c9 8b 00=20

Any idea? This didn't happen in 2.5.68 AFAIR.

Regards,
Josh

--=20
New PGP public key: 0x27AFC3EE

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vI+0T2bz5yevw+4RArjtAKCcXlUj+G5Wi2MbEaFVZ+1gbqy6xgCgw7qg
0h99SUDn4T6VY/3eefeYZfY=
=bxVv
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
