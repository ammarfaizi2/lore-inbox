Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284509AbRLUJ3O>; Fri, 21 Dec 2001 04:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284516AbRLUJ26>; Fri, 21 Dec 2001 04:28:58 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:33810 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S284509AbRLUJ2f>;
	Fri, 21 Dec 2001 04:28:35 -0500
Date: Sat, 22 Dec 2001 12:32:16 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: brain@artax.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with GUS PnP: ad1848, pnp
Message-ID: <20011222123216.A2283@pazke.ipt>
In-Reply-To: <20011220175753.A277@pazke.ipt> <Pine.LNX.4.30.0112202021360.796-200000@ghost.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.30.0112202021360.796-200000@ghost.ucw.cz>; from brain@artax.karlin.mff.cuni.cz on Thu, Dec 20, 2001 at 08:25:44PM +0100
X-Uname: Linux pazke 2.5.1-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2001 at 08:25:44PM +0100, brain@artax.karlin.mff.cuni.cz wr=
ote:
> On Thu, 20 Dec 2001, Andrey Panin wrote:
>=20
> > IIRC, Gravis Ultrasound PnP listed as supported in Hardware Compatibili=
ty
> > HOWTO, but it can lack ISA PnP configuration support. So send us a copy
> > of /proc/isapnp anyway :))
>=20
> OK. Here it is. It was set by isapnptools, so the values are a bit wild :=
-) But
> the resources are visible.
>=20

Does the attached patch help you ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-gus-isapnp
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/sound/ad1848.c /linux.2.5=
.1/drivers/sound/ad1848.c
--- /linux.vanilla/drivers/sound/ad1848.c	Sat Dec 22 12:22:18 2001
+++ /linux.2.5.1/drivers/sound/ad1848.c	Sat Dec 22 11:41:03 2001
@@ -2965,6 +2965,10 @@
         	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021),
                 1, 0, 0, 1, 1},
+	{"Advanced Gravis InterWave Audio",
+		ISAPNP_VENDOR('G','R','V'), ISAPNP_DEVICE(0x0001),
+		ISAPNP_VENDOR('G','R','V'), ISAPNP_FUNCTION(0x0000),
+		0, 0, 0, 1, 0},
 	{0}
 };
=20
@@ -2977,6 +2981,8 @@
 		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0100), 0 },
         {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021), 0 },
+	{	ISAPNP_VENDOR('G','R','V'), ISAPNP_DEVICE(0x0001),
+		ISAPNP_VENDOR('G','R','V'), ISAPNP_FUNCTION(0x0000), 0 },
 	{0}
 };
=20

--3V7upXqbjpZ4EhLz--

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JFMgBm4rlNOo3YgRAictAJ9gxmR0CxVFbDcxdDL+xtqELJAm2gCfcpLl
DAsisrLounOFGGQ0uzt1vs0=
=Cp/n
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
