Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTIMU4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbTIMU4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:56:19 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:992
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262192AbTIMU4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:56:17 -0400
Date: Sat, 13 Sep 2003 13:56:15 -0700
To: linux-kernel@vger.kernel.org
Cc: Thomas Molina <tmolina@cablespeed.com>, rmk@arm.linux.org.uk
Subject: Re: presario laptop pcmcia loading problems
Message-ID: <20030913205615.GK27104@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
	Thomas Molina <tmolina@cablespeed.com>, rmk@arm.linux.org.uk
References: <Pine.LNX.4.44.0309121603280.1579-800000@localhost.localdomain> <20030913212719.A23169@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
In-Reply-To: <20030913212719.A23169@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2003 at 09:27:19PM +0100, Russell King wrote:
> > # CONFIG_ISA is not set
>=20
> Turn this on.

How about requiring CONFIG_ISA for CONFIG_PCMCIA_HERMES? This problem is
happening quite often...

--- linux/drivers/net//wireless/Kconfig~	2003-09-13 13:54:54.000000000 -0700
+++ linux/drivers/net//wireless/Kconfig	2003-09-13 13:55:21.000000000 -0700
@@ -241,7 +241,7 @@
=20
 config PCMCIA_HERMES
 	tristate "Hermes PCMCIA card support"
-	depends on NET_RADIO && PCMCIA && HERMES
+	depends on NET_RADIO && PCMCIA && HERMES && ISA
 	---help---
 	  A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
 	  as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/

--=20
Joshua Kwan

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP2OEbqOILr94RG8mAQIxMRAAjdlfchooL2pZ9S0kqU1Tx48HiDN2ruhz
C6b32238/gAuYAzysvhK1dqiavf28VpN7pv3qEXvcnEWlD4xwHeU9zrS+gbOvwCi
s288+7Eg6+tvajQenhbw/Ku1nH/FUkKZGHM0aBh/MXMqssMIVcYdVcWBh9T3mlMg
iyBSbXic/dTaobn1Zu2i05i5i1sL1jB20Qy1T191zdRLGYAx6zKYJUy6Bg7iPJ9A
hDZFfIkhsgyaabC3Vl2LJVpmUjuXK8/Uxva7KRqCG6DW3fEjb9KV56g8WvgmrnBh
sFze+G7+M2AuURtQ2chqAFiSzEdgAmyWZ5TcBgL9ermxOuCcRUF6gt85SCAyuu0F
Ay36EknMdVDDDKL5qX9DZ+FdwDlPWCR7N8strY1Erps+uxJDq9sSQM6nH0stXskc
TOEhJ3k3XRcoQiWBPi9AzlWI6Vx+XnhgdLZUQ5wspD4+qKcCoPAi7/2pzQKn9kxu
7SCc/Y2k/isGYzYq+nrBVWI+p4H5FaDn653G2bAdAR8J7ELKhoYoDuuBwCiZzJBl
/N7wcR6ouJqg28bqd5/xCkPz0pFGkebBGLUFqmDiBfNYr7KWLpbvxRydPL/pv9Si
hfa8rY+GbyoRauLvwlngWTy9cASSPHuQQ5+wSxba8B3pc4iju48F6C52DC7Clk3B
AjPIx+Qdth0=
=N8cH
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
