Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWCARDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWCARDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWCARDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:03:42 -0500
Received: from mivlgu.ru ([81.18.140.87]:28615 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751762AbWCARDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:03:41 -0500
Date: Wed, 1 Mar 2006 20:03:30 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: kernel.suid_dumpable or fs.suid_dumpable?
Message-ID: <20060301170330.GR26440@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6ArjEZjY3m60389"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G6ArjEZjY3m60389
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Apparently the patch to add kernel.suid_dumpable sysctl:

http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3Dd6e711448137ca3301512cec41a2c2ce852b3d0a

was applied wrongly - the sysctl was added under "fs" instead of "kernel".
So currently it is fs.suid_dumpable instead of kernel.suid_dumpable, but
the docs (Documentation/sysctl/kernel.txt) and include/linux/sysctl.h
(KERN_SETUID_DUMPABLE) say that it should be under "kernel".

Which way this should be fixed - should the sysctl definition be moved
from fs_table to kern_table (thus moving it from fs.suid_dumpable to
kernel.suid_dumpable, as docs say), or should docs be fixed to reflect the
current location of sysctl (and include/linux/sysctl would need to be
fixed too)?

I have filed this as http://bugzilla.kernel.org/show_bug.cgi?id=3D6145 to
make sure it is not forgotten completely.

--=20
Sergey Vlasov

--G6ArjEZjY3m60389
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEBdPiW82GfkQfsqIRAm+KAKCCM3aaTXDqjT0DDh1ZbSRvkuuscACfc7Lg
bosDIYZ6JDDwtC7h1QQ+ncs=
=dc86
-----END PGP SIGNATURE-----

--G6ArjEZjY3m60389--
