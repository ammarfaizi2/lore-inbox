Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130756AbRCEXO2>; Mon, 5 Mar 2001 18:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130757AbRCEXOT>; Mon, 5 Mar 2001 18:14:19 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:61174 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S130756AbRCEXOK>; Mon, 5 Mar 2001 18:14:10 -0500
Date: Mon, 5 Mar 2001 18:14:08 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: 3c509 2.4.2-ac12 compilation fails
Message-ID: <20010305181408.A1075@athame.dynamicro.on.ca>
Reply-To: glouis@dynamicro.on.ca
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

gcc -D__KERNEL__ -I/usr/src/linux-2.4.2ac12/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-march=3Di686    -c -o 3c509.o 3c509.c
3c509.c: In function 'el3_probe':
3c509.c:330: structure has no member named 'name'
make[3]: *** [3c509.o] Error 1
make[3]: Leaving directory /usr/src/linux-2.4.2ac12/drivers/net'

This works, though it's not as informative as what was intended:

--- drivers/net/3c509.c~	Mon Mar  5 17:41:37 2001
+++ drivers/net/3c509.c	Mon Mar  5 17:52:57 2001
@@ -326,8 +326,8 @@
 				return -EBUSY;
 			irq =3D idev->irq_resource[0].start;
 			if (el3_debug > 3)
-				printk ("ISAPnP reports %s at i/o 0x%x, irq %d\n",
-					el3_isapnp_adapters[i].name, ioaddr, irq);
+				printk ("ISAPnP reports %d at i/o 0x%x, irq %d\n",
+					el3_isapnp_adapters[i].card_device, ioaddr, irq);
 			EL3WINDOW(0);
 			for (j =3D 0; j < 3; j++)
 				el3_isapnp_phys_addr[pnp_cards][j] =3D


--=20
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Comment: finger greg@bgl.nu for public key

iEYEARECAAYFAjqkHcAACgkQDlwut6d6Rj0PmQCggLRmZe9STm7mK+6J+TqjepXx
JrgAnRPcCJHqC/tdzw2WCM25akplxf2r
=UvU/
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
