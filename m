Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSKAI3c>; Fri, 1 Nov 2002 03:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265682AbSKAI3c>; Fri, 1 Nov 2002 03:29:32 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:14290 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265681AbSKAI3a>; Fri, 1 Nov 2002 03:29:30 -0500
Date: Fri, 1 Nov 2002 09:35:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [2.5. PATCH] cpufreq: VIA longhaul v.1 update
Message-ID: <20021101093541.D1268@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Updates for better support of VIA longhaul v.1. which is found on
Samuel/CyrixIII, Samuel2/C3 processors. (Dave Jones)

	Dominik

--- linux-2545original/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Oct 31 1=
2:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Oct 31 23:50:00 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: longhaul.c,v 1.72 2002/09/29 23:43:10 db Exp $
+ *  $Id: longhaul.c,v 1.77 2002/10/31 21:17:40 db Exp $
  *
  *  (C) 2001  Dave Jones. <davej@suse.de>
  *  (C) 2002  Padraig Brady. <padraig@antefacto.com>
@@ -436,8 +436,10 @@
 	switch (longhaul) {
 	case 1:
 		/* Ugh, Longhaul v1 didn't have the min/max MSRs.
-		   Assume max =3D whatever we booted at. */
+		   Assume min=3D3.0x & max =3D whatever we booted at. */
+		minmult =3D 30;
 		maxmult =3D longhaul_get_cpu_mult();
+		minfsb =3D maxfsb =3D current_fsb;
 		break;
=20
 	case 2 ... 3:

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9wjzbZ8MDCHJbN8YRAjk/AJsG1INOc4AuH+DtxgnDVrbCUiB6BACfe6vN
f9lneRW2tvvnirQH6OY+eX8=
=qOdF
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
