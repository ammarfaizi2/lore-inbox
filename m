Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTKAWsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTKAWsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 17:48:36 -0500
Received: from 4demon.com ([217.160.186.4]:52444 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S261226AbTKAWsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 17:48:32 -0500
Date: Sat, 1 Nov 2003 23:48:29 +0100
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 autofs4 Oops
Message-ID: <20031101224829.GE7107@mandel.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

found an Oops from automount 4.0 in my syslog. I'm using the autofs4
kernel module.

kernel: kernel BUG at page_alloc.c:106!
kernel: invalid operand: 0000
kernel: CPU:    1
kernel: EIP:    0010:[__free_pages_ok+130/752]    Not tainted
kernel: EFLAGS: 00010202
kernel: eax: 1fca9015   ebx: c1572188   ecx: c1572188   edx: 00000000
kernel: esi: 00000000   edi: c033fa10   ebp: c0833c00   esp: c0835ed0
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process automount (pid: 5169, stackpage=3Dc0835000)
kernel: Stack: c1572188 00000007 c033fa10 c0833c00 c100001c 00001000 c10217=
80 c100001c=20
kernel:        c02c3dbc 00000217 ffffffff 0000062f 00000317 c013a4ac c013a9=
94 c1572188=20
kernel:        c012ad40 c1572188 00000006 c012b459 1faf1067 dbcd58bc de5800=
84 bfff9000=20
kernel: Call Trace:    [__free_pages+28/32] [free_page_and_swap_cache+52/64=
] [__free_pte+64/80] [zap_page_range+857/960] [exit_mmap+271/368]
kernel:   [mmput+129/160] [do_exit+284/1184] [sys_exit+14/16] [system_call+=
51/56]
kernel:=20
kernel: Code: 0f 0b 6a 00 9a fc 27 c0 8b 43 18 a8 80 74 08 0f 0b 6c 00 9a=
=20

Modules:

Module                  Size  Used by    Not tainted
radeon                 98432   1
parport_pc             25576   1  (autoclean)
lp                      7300   0  (autoclean)
parport                24960   1  (autoclean) [parport_pc lp]
autofs4                10164   1  (autoclean)
nfs                    72792   1  (autoclean)
lockd                  50480   1  (autoclean) [nfs]
sunrpc                 73980   1  (autoclean) [nfs lockd]
ext3                   64772   3  (autoclean)
jbd                    42352   3  (autoclean) [ext3]
thermal                 6720   0  (unused)
processor               9036   0  [thermal]
fan                     1664   0  (unused)
button                  2636   0  (unused)
ac                      1888   0  (unused)
usb-ohci               22152   0  (unused)
usbcore                61984   1  [usb-ohci]
agpgart                15872   3
e100                   55532   1

The system is Dual Athlon MP 2000+.

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pDg9LbySPj3b3eoRAghgAJ0RjupMJGJ/mSD/29m+MUZ57Zoc9wCgmNBG
Enmc2t65WT4HXAFfHSt3VRE=
=kZBR
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
