Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWIXLrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWIXLrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 07:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWIXLrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 07:47:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:65438 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750978AbWIXLrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 07:47:48 -0400
Date: Sun, 24 Sep 2006 13:46:55 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-kernel@vger.kernel.org
Cc: mj@atrey.karlin.mff.cuni.cz, crutcher+kernel@datastacks.com
Subject: [PATCH] Prevent multiple inclusion of linux/sysrq.h
Message-ID: <20060924134655.73704fa9@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_hscf+uu0JVJnBYxX.E7k/n_";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_hscf+uu0JVJnBYxX.E7k/n_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

From: Thomas Petazzoni <thomas.petazzoni@enix.org>

Prevent multiple inclusions of include/linux/sysrq.h using traditional
#ifndef..#endif.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@enix.org>

---

Index: linux-2.6/include/linux/sysrq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/sysrq.h	2006-09-23 00:04:05.000000000 +0200
+++ linux-2.6/include/linux/sysrq.h	2006-09-23 00:05:27.000000000 +0200
@@ -11,6 +11,8 @@
  *	based upon discusions in irc://irc.openprojects.net/#kernelnewbies
  */
=20
+#ifndef _LINUX_SYSRQ_H
+#define _LINUX_SYSRQ_H
=20
 struct pt_regs;
 struct tty_struct;
@@ -57,3 +59,5 @@
 #define unregister_sysrq_key(ig,nore) __reterr()
=20
 #endif
+
+#endif /* _LINUX_SYSRQ_H */
--=20
PETAZZONI Thomas - thomas.petazzoni@enix.org=20
http://{thomas,sos,kos}.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://{agenda,livret}dulibre.org - http://www.toulibre.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--Sig_hscf+uu0JVJnBYxX.E7k/n_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFFnAz9lPLMJjT96cRApywAJ9z1whrsPUW8Tm62gikmRolB4aoogCgtGC1
qNGZZOqxrjAwj3EoxSpZH50=
=bnpj
-----END PGP SIGNATURE-----

--Sig_hscf+uu0JVJnBYxX.E7k/n_--
