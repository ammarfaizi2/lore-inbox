Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTK1UzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTK1UzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 15:55:22 -0500
Received: from cpc2-bele1-3-0-cust240.blfs.cable.ntl.com ([62.254.35.240]:22020
	"EHLO sedai.lesleymews.net") by vger.kernel.org with ESMTP
	id S263453AbTK1UzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 15:55:13 -0500
Subject: 2.6.0-test10-mm1 crash with CONFIG_PREEMPT
From: Jonathan Brown <jbrown@emergence.uk.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-62Xlx8WwkKBe7JyR3E+v"
Message-Id: <1070052911.4478.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 20:55:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-62Xlx8WwkKBe7JyR3E+v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Does this crash have anything to do with the preemption instability?

Nov 28 20:36:35 akalabeth invalid operand: 0000 [#1]
Nov 28 20:36:35 akalabeth PREEMPT
Nov 28 20:36:35 akalabeth CPU:    0
Nov 28 20:36:35 akalabeth EIP:    0060:[<c019e4ce>]    Not tainted VLI
Nov 28 20:36:35 akalabeth EFLAGS: 00210246
Nov 28 20:36:35 akalabeth EIP is at __copy_from_user_ll+0x16/0x58
Nov 28 20:36:35 akalabeth eax: 00000000   ebx: 00000008   ecx:
00000008   edx: 08af63c0
Nov 28 20:36:35 akalabeth esi: 08af63b8   edi: f7ffffff   ebp:
ec2ed608   esp: df827f78
Nov 28 20:36:35 akalabeth ds: 007b   es: 007b   ss: 0068
Nov 28 20:36:35 akalabeth Process MozillaFirebird (pid: 6465,
threadinfo=3Ddf826000 task=3De176c6e0)
Nov 28 20:36:35 akalabeth Stack: ec2ed600 08af63b8 c0156cdd ec2ed608
08af63b8 00000008 ec2ed600 ec2ed600
Nov 28 20:36:35 akalabeth 00000001 fffffff4 c01561f7 00000000 00000000
3fc7b1d3 08af63b8 00000000
Nov 28 20:36:35 akalabeth 4ac06938 df826000 c025e57a 08af63b8 00000001
00000000 00000000 4ac06938
Nov 28 20:36:35 akalabeth Call Trace:
Nov 28 20:36:35 akalabeth [<c0156cdd>] sys_poll+0x158/0x257
Nov 28 20:36:35 akalabeth [<c01561f7>] __pollwait+0x0/0x9a
Nov 28 20:36:35 akalabeth [<c025e57a>] sysenter_past_esp+0x43/0x65
Nov 28 20:36:35 akalabeth
Nov 28 20:36:35 akalabeth Code: a4 eb 0d 51 56 57 e8 7c fe ff ff 89 c1
83 c4 0c 5e 89 c8 5f c3 57 56 8b 4c 24 14 8b 7c 24 25 8b 74 24 10 83 f9
3f 25 0e 89 f8 31 <f0> 23 05 29 5c 32 c0 85 c0 75 23 25 c8 83 f9 07 76
18 89 2d f7
Nov 28 20:36:35 akalabeth invalid operand: 0000 [#2]
Nov 28 20:36:35 akalabeth PREEMPT
Nov 28 20:36:35 akalabeth CPU:    0
Nov 28 20:36:35 akalabeth EIP:    0060:[<c019e4ce>]    Not tainted VLI
Nov 28 20:36:35 akalabeth EFLAGS: 00010246
Nov 28 20:36:35 akalabeth EIP is at __copy_from_user_ll+0x16/0x58
Nov 28 20:36:35 akalabeth eax: 00000000   ebx: 00000008   ecx:
00000008   edx: 080a4dc8
Nov 28 20:36:35 akalabeth esi: 080a4dc0   edi: 20efc221   ebp:
df4e62c0   esp: e6ad1de4
Nov 28 20:36:35 akalabeth ds: 007b   es: 007b   ss: 0068
Nov 28 20:36:35 akalabeth Process gnome-terminal (pid: 5239,
threadinfo=3De6ad0000 task=3Debd999a0)
Nov 28 20:36:35 akalabeth Stack: e6ad1f4c 00000000 c021c158 df4e62c0
080a4dc0 00000008 00000008 efc22140
Nov 28 20:36:35 akalabeth df4e62c0 efc22180 e45c7e20 c0259ce8 df4e62c0
e6ad1f4c 00000008 00000008
Nov 28 20:36:35 akalabeth 00000000 e45c7cc0 e6ad1f10 ffffff95 00001477
000003e8 00000064 00000000
Nov 28 20:36:35 akalabeth Call Trace:
Nov 28 20:36:35 akalabeth [<c021c158>] memcpy_fromiovec+0x52/0x98
Nov 28 20:36:35 akalabeth [<c0259ce8>] unix_stream_sendmsg+0x1f4/0x38e
Nov 28 20:36:35 akalabeth [<c0122730>] update_process_times+0x29/0x2f
Nov 28 20:36:35 akalabeth [<c0217e6f>] sock_aio_write+0xb1/0xbd
Nov 28 20:36:35 akalabeth [<c01476c3>] do_sync_write+0xa4/0xd2
Nov 28 20:36:35 akalabeth [<c0133fb0>] __alloc_pages+0x93/0x2b2
Nov 28 20:36:35 akalabeth [<c011a52d>] autoremove_wake_function+0x0/0x36
Nov 28 20:36:35 akalabeth [<c01ceb91>] pty_write_room+0x22/0x24
Nov 28 20:36:35 akalabeth [<c01cdee5>] normal_poll+0x10b/0x11f
Nov 28 20:36:35 akalabeth [<c01ca69b>] tty_poll+0x69/0x70
Nov 28 20:36:35 akalabeth [<c0147795>] vfs_write+0xa4/0xc0
Nov 28 20:36:35 akalabeth [<c014781f>] sys_write+0x2b/0x43
Nov 28 20:36:35 akalabeth [<c025e57a>] sysenter_past_esp+0x43/0x65
Nov 28 20:36:35 akalabeth
Nov 28 20:36:35 akalabeth Code: a4 eb 0d 51 56 57 e8 7c fe ff ff 89 c1
83 c4 0c 5e 89 c8 5f c3 57 56 8b 4c 24 14 8b 7c 24 25 8b 74 24 10 83 f9
3f 25 0e 89 f8 31 <f0> 23 05 29 5c 32 c0 85 c0 75 23 25 c8 83 f9 07 76
18 89 2d f7


--=20
Jonathan Brown
http://emergence.uk.net/


--=-62Xlx8WwkKBe7JyR3E+v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/x7Yumany35ffRscRAklrAKC4ODwZdo5zLtXAY1EY61vWOmfJwwCdE8/j
9A0ETjholoqE+h7ymWgpStk=
=gW8X
-----END PGP SIGNATURE-----

--=-62Xlx8WwkKBe7JyR3E+v--

