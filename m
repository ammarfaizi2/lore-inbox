Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264159AbUEXIoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUEXIoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUEXInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:43:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:29599 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264159AbUEXIda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:33:30 -0400
Date: Mon, 24 May 2004 04:33:05 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 7/14 linux-2.6.7-rc1] prism54: Fix 2.4 build
Message-ID: <20040524083305.GH3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8QM4kKE+nfbBA4vJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8QM4kKE+nfbBA4vJ
Content-Type: multipart/mixed; boundary="Jaerp9zHWz52Eeko"
Content-Disposition: inline


--Jaerp9zHWz52Eeko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-04-05      Margit Schubert-While <margitsw@t-online.de>

        * Fix 2.4 builds

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--Jaerp9zHWz52Eeko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="07-fix-24-build.patch"
Content-Transfer-Encoding: quoted-printable

2004-04-05	Margit Schubert-While <margitsw@t-online.de>

	* Fix 2.4 builds
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/prismcompat.h,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	20 Mar 2004 =
18:23:28 -0000	1.1
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	5 Apr 2004 0=
4:19:25 -0000	1.2
@@ -20,6 +20,10 @@
  *	Compatibility header file to aid support of different kernel versions
  */
=20
+#ifdef	PRISM54_COMPAT24
+#include "prismcompat24.h"
+#else	/* PRISM54_COMPAT24 */
+
 #ifndef _PRISM_COMPAT_H
 #define _PRISM_COMPAT_H
=20
@@ -45,3 +49,4 @@
 #define PRISM_FW_PDEV		&priv->pdev->dev
=20
 #endif				/* _PRISM_COMPAT_H */
+#endif				/* PRISM54_COMPAT24 */

--Jaerp9zHWz52Eeko--

--8QM4kKE+nfbBA4vJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbNBat1JN+IKUl4RAnDtAJwIARw99avzGhH2IT4wVh+l+dTXQgCeMJsX
MM2kqokwRP2o/cAQ3Og9UZo=
=9IUB
-----END PGP SIGNATURE-----

--8QM4kKE+nfbBA4vJ--
