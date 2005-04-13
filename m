Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVDMKRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDMKRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVDMKRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:17:32 -0400
Received: from hs-grafik.net ([80.237.205.72]:52997 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S261288AbVDMKRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:17:24 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NULL pointe rin reiserfs
Date: Wed, 13 Apr 2005 12:17:15 +0200
User-Agent: KMail/1.7.2
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1627162.6abTV5Z7vx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504131217.17308@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1627162.6abTV5Z7vx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

after resizing a reiserfs partition, the next cvs process produced:
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0192701
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: usbserial md5 ipv6 sk98lin
CPU:    0
EIP:    0060:[<c0192701>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc1-k7-vrs1)
EIP is at scan_bitmap_block+0x41/0x2c0
eax: f2d0d000   ebx: c6630eac   ecx: 00027305   edx: 00000000
esi: f2d0d060   edi: c6630c48   ebp: eeeb3200   esp: c6630bdc
ds: 007b   es: 007b   ss: 0068
Process cvs (pid: 11807, threadinfo=3Dc6630000 task=3Dd7545ae0)
Stack: 04040404 04040404 00005109 00184859 430034ec 00000800 542e1a94 3e846=
bff
       b75bcfc3 0000000c c6630c48 eeeb3200 00000000 c0192c57 c6630eac 00000=
00c
       c6630c48 00008000 00000002 00000002 00000001 eef8ce20 00007fff c6630=
d68
Call Trace:
 [<c0192c57>] scan_bitmap+0x1d7/0x260
 [<c0193ea6>] reiserfs_allocate_blocknrs+0x196/0x4f0
 [<c01a15b2>] reiserfs_allocate_blocks_for_region+0x302/0x16d0
 [<c0139b18>] add_to_page_cache+0x68/0xc0
 [<c019b085>] make_cpu_key+0x55/0x60
 [<c01a39a3>] reiserfs_prepare_file_region_for_write+0x6b3/0xa10
 [<c01a42d5>] reiserfs_file_write+0x5d5/0x840
 [<c0149b73>] do_no_page+0x63/0x350
 [<c0117b80>] do_page_fault+0x3d0/0x5ee
 [<c015913e>] vfs_write+0xbe/0x130
 [<c0159281>] sys_write+0x51/0x80
 [<c010623b>] syscall_call+0x7/0xb
Code: 3c 8b 28 8b 0f 8b 85 50 01 00 00 8b 40 08 89 4c 24 14 8b 4b 10 85 c9 =
8d=20
34 d0 0f 84 7c 02 00 00 85 f6 0f 84 5a 02 00 00 8b 56 04 <8b> 02 83 e0 04 0=
f=20
85 3f 02 00 00 8d 74 26 00 0f b7 46 02 3b 44

regards
Alex
=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart1627162.6abTV5Z7vx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCXPGt/aHb+2190pERAnRYAJ0RNf+794DNourR3RBs9tPIuCJgnwCgo3VV
eLKcRmIK78h3NRYa2j2nDDA=
=c3ms
-----END PGP SIGNATURE-----

--nextPart1627162.6abTV5Z7vx--
