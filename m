Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276444AbRJHGGj>; Mon, 8 Oct 2001 02:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276445AbRJHGGa>; Mon, 8 Oct 2001 02:06:30 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:42759 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S276444AbRJHGGR>;
	Mon, 8 Oct 2001 02:06:17 -0400
Date: Mon, 8 Oct 2001 10:06:49 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] buglet in arch/i386/setup.c (2.4.10-ac7)
Message-ID: <20011008100649.A17440@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 9:30am  up 31 days, 57 min,  1 user,  load average: 1.08, 1.04, 1.00
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

function ppro_with_ram_bug() really contains one bug :))
return 0 is missing at the end of it and IMHO its return value is=20
always nonzero because of this bug.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ppro_with_ram_bug
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff linux.vanilla/arch/i386/kernel/setup.c linux/arc=
h/i386/kernel/setup.c
--- linux.vanilla/arch/i386/kernel/setup.c	Tue Oct  2 21:06:54 2001
+++ linux/arch/i386/kernel/setup.c	Sat Oct  6 23:28:44 2001
@@ -2925,6 +2925,7 @@
 		return 1;
 	}
 	printk(KERN_INFO "Your Pentium Pro seems ok.\n");
+	return 0;
 }
 =09
 /*

--sm4nu43k4a2Rpi4c--

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7wUJ4Bm4rlNOo3YgRAhkAAJ92YeQGttDC+l/8gYTwG8Oyd6FkOQCfQ42F
FUb41nBKpeX3mHV/XO6kRiA=
=4QFS
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
