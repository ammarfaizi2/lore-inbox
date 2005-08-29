Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVH2Kch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVH2Kch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 06:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVH2Kcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 06:32:36 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:36252 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1750819AbVH2Kcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 06:32:36 -0400
Subject: Re: [PATCH] Watchdog device node name unification
From: Henrik Brix Andersen <brix@gentoo.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508131520520.3553@g5.osdl.org>
References: <1123969015.13656.13.camel@sponge.fungus>
	 <1123970037.13656.16.camel@sponge.fungus>
	 <Pine.LNX.4.58.0508131520520.3553@g5.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rM1wxgq3vSDdtqlZrN/8"
Organization: Gentoo Metadistribution
Date: Mon, 29 Aug 2005 12:32:35 +0200
Message-Id: <1125311556.20765.65.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rM1wxgq3vSDdtqlZrN/8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-13 at 15:21 -0700, Linus Torvalds wrote:
> Doesn't seem to be serious enough to be worth it at this late stage in th=
e=20
> 2.6.13 game. Can you re-send after I do a release?

Resending as requested:

Here's a patch for unifying the watchdog device node name
to /dev/watchdog as expected by most user-space applications.

Please CC: me on replies as I am not subscribed to LKML.


Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>


diff -Nurp linux-2.6.13/drivers/char/watchdog/ixp2000_wdt.c linux-2.6.13-wa=
tchdog/drivers/char/watchdog/ixp2000_wdt.c
--- linux-2.6.13/drivers/char/watchdog/ixp2000_wdt.c	2005-08-29 01:41:01.00=
0000000 +0200
+++ linux-2.6.13-watchdog/drivers/char/watchdog/ixp2000_wdt.c	2005-08-29 12=
:28:31.000000000 +0200
@@ -182,7 +182,7 @@ static struct file_operations ixp2000_wd
 static struct miscdevice ixp2000_wdt_miscdev =3D
 {
 	.minor		=3D WATCHDOG_MINOR,
-	.name		=3D "IXP2000 Watchdog",
+	.name		=3D "watchdog",
 	.fops		=3D &ixp2000_wdt_fops,
 };
=20
diff -Nurp linux-2.6.13/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6.13-wat=
chdog/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.6.13/drivers/char/watchdog/ixp4xx_wdt.c	2005-08-29 01:41:01.000=
000000 +0200
+++ linux-2.6.13-watchdog/drivers/char/watchdog/ixp4xx_wdt.c	2005-08-29 12:=
28:31.000000000 +0200
@@ -176,7 +176,7 @@ static struct file_operations ixp4xx_wdt
 static struct miscdevice ixp4xx_wdt_miscdev =3D
 {
 	.minor		=3D WATCHDOG_MINOR,
-	.name		=3D "IXP4xx Watchdog",
+	.name		=3D "watchdog",
 	.fops		=3D &ixp4xx_wdt_fops,
 };
=20
diff -Nurp linux-2.6.13/drivers/char/watchdog/scx200_wdt.c linux-2.6.13-wat=
chdog/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.13/drivers/char/watchdog/scx200_wdt.c	2005-08-29 01:41:01.000=
000000 +0200
+++ linux-2.6.13-watchdog/drivers/char/watchdog/scx200_wdt.c	2005-08-29 12:=
28:31.000000000 +0200
@@ -206,7 +206,7 @@ static struct file_operations scx200_wdt
=20
 static struct miscdevice scx200_wdt_miscdev =3D {
 	.minor =3D WATCHDOG_MINOR,
-	.name  =3D NAME,
+	.name  =3D "watchdog",
 	.fops  =3D &scx200_wdt_fops,
 };
=20


--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--=-rM1wxgq3vSDdtqlZrN/8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDEuRDv+Q4flTiePgRAhSoAJ0Ruj2uzTRtGsQalH6RgolmIFBDiQCffAcV
7b22DZN+Ms4VSP5pPxHXwC8=
=02HF
-----END PGP SIGNATURE-----

--=-rM1wxgq3vSDdtqlZrN/8--

