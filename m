Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTDPHDN (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTDPHDM 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:03:12 -0400
Received: from pfepb.post.tele.dk ([193.162.153.3]:39241 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261373AbTDPHDL 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 03:03:11 -0400
Subject: kernel panic in 2.5.67-mm3
From: Mads Christensen <mfc@krycek.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SwdZYrfuN/7XnpdDwwv0"
Organization: krycek.org
Message-Id: <1050477303.694.3.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Apr 2003 09:15:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SwdZYrfuN/7XnpdDwwv0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hey

So i guess I discovered a oops in 2.5.67-mm3=20
syslog reads:=20
Apr 16 08:11:49 krycek kernel: unmap_vmas: VMA list is not sorted
correctly!
Apr 16 08:11:49 krycek kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000084
Apr 16 08:11:49 krycek kernel:  printing eip:
Apr 16 08:11:49 krycek kernel: c013bb00
Apr 16 08:11:49 krycek kernel: *pde =3D 00000000
Apr 16 08:11:49 krycek kernel: Oops: 0000 [#1]
Apr 16 08:11:49 krycek kernel: CPU:    0
Apr 16 08:11:49 krycek kernel: EIP:    0060:[unmap_vmas+224/544]  =20
Tainted: P   VLI
Apr 16 08:11:49 krycek kernel: EFLAGS: 00010202
Apr 16 08:11:49 krycek kernel: eax: 401ba000   ebx: 000b0000   ecx:
00000000   edx: 00000080
Apr 16 08:11:49 krycek kernel: esi: 401ba000   edi: 401ba000   ebp:
f3a09dc0   esp: f36dfe44
Apr 16 08:11:49 krycek kernel: ds: 007b   es: 007b   ss: 0068
Apr 16 08:11:49 krycek kernel: Process irssi (pid: 684,
threadinfo=3Df36de000 task=3Df39519c0)
Apr 16 08:11:49 krycek kernel: Stack: c03e2e04 f3a09dc0 4010a000
401ba000 f36de000 401ba000 00000013 00050000=20
Apr 16 08:11:49 krycek kernel:        f52164c0 f52164c0 f36de000
f39519c0 c013fabb f36dfe90 f52164c0 f3a09680=20
Apr 16 08:11:49 krycek kernel:        00000000 ffffffff f36dfe94
c03e2e04 00000125 f52164c0 00000000 00000000=20
Apr 16 08:11:49 krycek kernel: Call Trace: [exit_mmap+123/400]=20
[mmput+84/176]  [do_exit+284/1040]  [do_group_exit+123/176]=20
[get_signal_to_deliver+493/816]  [do_signal+214/272]  [poll_freew
ait+58/80]  [vfs_write+213/304]  [do_page_fault+0/1111]=20
[do_notify_resume+86/88]  [work_notifysig+19/21]=20
Apr 16 08:11:49 krycek kernel: Code: 7c 24 0c 89 fe 8b 02 89 04 24 e8 cc
fe ff ff 29 5c 24 1c 8b 44 24 1c 85 c0 7e 55 3b 7c 24 14 75 c0 8b 55 0c
85 d2 74 08 8b 45 08 <39> 42 04 72 21 85 d2 8
9 d5 74 0f 8b 52 04 3b 54 24 44 89 d1 0f=20
Apr 16 08:11:49 krycek kernel:  <6>note: irssi[684] exited with
preempt_count 1

good luck :)
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| Mads F. Christensen     || email:                                    |
| phone:  +45 27 47 58 66 || mfc@krycek.org                            |
| Webdesign Development   || www.krycek.org - personal data site       |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


--=-SwdZYrfuN/7XnpdDwwv0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nQL244SvOSUXdFgRAlyMAKCJ/JONl4HHp4qqViEpZ16sQpyXnQCghrmI
n2igu4RSXOVEy6KChG/N8BM=
=wnHz
-----END PGP SIGNATURE-----

--=-SwdZYrfuN/7XnpdDwwv0--

