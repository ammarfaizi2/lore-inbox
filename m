Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUCRAgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUCRAgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:36:41 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:43183 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262253AbUCRAgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:36:03 -0500
Date: Thu, 18 Mar 2004 00:36:01 +0000
From: Peter Samuelson <peter@p12n.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [uPATCH] matroxfb undefined parameter
Message-ID: <20040318003601.GA1105@p12n.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


With CONFIG_MTRR=n, the matroxfb_base module refuses to load properly,
because a MODULE_PARM doesn't have a corresponding global variable.
Trivial patch appended, please apply.

Peter

--- 2.6.4/drivers/video/matrox/matroxfb_base.c~	2004-02-04 03:44:04.000000000 +0000
+++ 2.6.4/drivers/video/matrox/matroxfb_base.c	2004-03-18 00:23:20.000000000 +0000
@@ -2409,8 +2409,10 @@
 MODULE_PARM_DESC(noinit, "Disables W/SG/SD-RAM and bus interface initialization (0 or 1=do not initialize) (default=0)");
 MODULE_PARM(memtype, "i");
 MODULE_PARM_DESC(memtype, "Memory type for G200/G400 (see Documentation/fb/matroxfb.txt for explanation) (default=3 for G200, 0 for G400)");
+#ifdef CONFIG_MTRR
 MODULE_PARM(mtrr, "i");
 MODULE_PARM_DESC(mtrr, "This speeds up video memory accesses (0=disabled or 1) (default=1)");
+#endif
 MODULE_PARM(sgram, "i");
 MODULE_PARM_DESC(sgram, "Indicates that G100/G200/G400 has SGRAM memory (0=SDRAM, 1=SGRAM) (default=0)");
 MODULE_PARM(inv24, "i");

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWO7xXk7sIRPQRh0RAvNwAJ97Cba1sHc2iSEYMx8ypMhilBASaQCgv4cQ
ognIlMjbZL8FrEUDPgRHtgQ=
=2dZ2
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
