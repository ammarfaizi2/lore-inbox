Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVAXPvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVAXPvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVAXPvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:51:16 -0500
Received: from hydra.gt.owl.de ([195.71.99.218]:57245 "EHLO hydra.gt.owl.de")
	by vger.kernel.org with ESMTP id S261524AbVAXPvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:51:08 -0500
Date: Mon, 24 Jan 2005 16:51:00 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/sysfs/symlink.c:87
Message-ID: <20050124155100.GA2583@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
while using the bridging code between a tap0 and a real eth1 i got this:

Linux zmgr1.wstk.mediaways.net 2.6.10-zmgr-p3cel #1 Mon Jan 24 16:15:39 CET=
 2005 i686 GNU/Linux

UP, P3 Celeron, Non-Preempt, Vanilla Kernel

kernel BUG at fs/sysfs/symlink.c:87!
invalid operand: 0000 [#1]
Modules linked in: ppp_deflate bsd_comp ppp_async crc_ccitt ppp_generic slh=
c 3c59x bridge tun autofs eepro100 e100 mii i2c_i801 i2c_core uhci_hcd usbc=
ore
CPU:    0
EIP:    0060:[<c017cac6>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-zmgr-p3cel)
EIP is at sysfs_create_link+0x56/0x60
eax: c45ef738   ebx: 00000000   ecx: c709f000   edx: c39b3ec0
esi: c8880878   edi: c7915728   ebp: c79156a0   esp: c4d91e94
ds: 007b   es: 007b   ss: 0068
Process brctl (pid: 3500, threadinfo=3Dc4d90000 task=3Dc52b25e0)
Stack: c017b8cf c68ba7e4 c8880824 00000000 c887aa57 c45ef738 c7915728 c709f=
000
       c45ef220 c709f000 c79156a0 c45ef220 00000000 c887762d c79156a0 c7915=
6a0
       c709f090 00000001 c709f000 c45ef220 ffffffed c4d91f34 c8877c34 c45ef=
220
Call Trace:
 [<c017b8cf>] sysfs_create_file+0x2f/0x50
 [<c887aa57>] br_sysfs_addif+0xe7/0x140 [bridge]
 [<c887762d>] br_add_if+0xbd/0x160 [bridge]
 [<c8877c34>] add_del_if+0x64/0x80 [bridge]
 [<c022d564>] dev_ifsioc+0x384/0x3f0
 [<c022d7b7>] dev_ioctl+0x1e7/0x260
 [<c0269d2c>] inet_ioctl+0x9c/0xb0
 [<c02231c9>] sock_ioctl+0xc9/0x240
 [<c015bc79>] sys_ioctl+0xc9/0x240
 [<c01024a3>] syscall_call+0x7/0xb
Code: 4c 24 04 8b 44 24 18 89 1c 24 89 44 24 08 e8 f2 fe ff ff 89 c1 8b 53 =
08 ff 42 68 0f 8e 0b 02 00 00 8b 5c 24 0c 89 c8 83 c4 10 c3 <0f> 0b 57 00 f=
5 59 2c c0 eb be 8b 44 24 04 8b 40 30 89 44 24 04
 <7>tap0: no IPv6 routers present



Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB9RlkUaz2rXW+gJcRAgu4AKC4WX+aLoSGNwnWqKKOiXaTrqZBGQCggw+I
U3S/XoEP+5c9WgWiHpREbJw=
=Z8OJ
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
