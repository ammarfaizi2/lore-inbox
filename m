Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTA3OuI>; Thu, 30 Jan 2003 09:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTA3OuI>; Thu, 30 Jan 2003 09:50:08 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:14522
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267512AbTA3OuH>; Thu, 30 Jan 2003 09:50:07 -0500
Subject: 2.5.59 __find_symbol oops
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-G61ahDJVsPWIpWgH+wNM"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Jan 2003 14:59:40 +0000
Message-Id: <1043938780.722.3.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G61ahDJVsPWIpWgH+wNM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Reproduce by loading a module (AFAICS).

Unable to handle kernel paging request at virtual address 2d8c20c0
 printing eip:
c012cee6
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c012cee6>]    Not tainted
EFLAGS: 00010093
EIP is at __find_symbol+0x46/0x90
eax: 00000617   ebx: c0383280   ecx: 00000000   edx: e90eb38d
esi: 2d8c20c0   edi: e90eb38d   ebp: c02d5947   esp: cc8d5ec8
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 722, threadinfo=3Dcc8d4000 task=3Dd4f10040)
Stack: c02e4d70 00000617 e90eaae8 e90ec100 000000a8 e90df8f0 c012da9e e90eb=
38d=20
       cc8d5ef0 00000001 00000001 e90eaae8 00000062 c012dd2a e90df8f0 00000=
015=20
       e90eaf48 e90eb38d e90ec100 00000000 e90eaf48 e90d8000 e90ec100 e90df=
8f0=20
Call Trace:
 [<c012da9e>] resolve_symbol+0x2e/0x70
 [<c012dd2a>] simplify_symbols+0xba/0x120
 [<c012e4d7>] load_module+0x477/0x8d0
 [<c013f609>] do_mmap_pgoff+0x409/0x640
 [<c012e9bc>] sys_init_module+0x8c/0x1c0
 [<c010b153>] syscall_call+0x7/0xb

Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 24=20
--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-G61ahDJVsPWIpWgH+wNM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+OT3bkbV2aYZGvn0RAusnAJ9JsHXlZBtwHXCm3wRo5c/O6D7TkgCeM2dQ
71T2g5RdGdlnjwqHSVr9ReQ=
=pm63
-----END PGP SIGNATURE-----

--=-G61ahDJVsPWIpWgH+wNM--

