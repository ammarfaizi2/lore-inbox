Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSKWKPh>; Sat, 23 Nov 2002 05:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSKWKPh>; Sat, 23 Nov 2002 05:15:37 -0500
Received: from p508EBFB1.dip.t-dialin.net ([80.142.191.177]:23291 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S261847AbSKWKPf>; Sat, 23 Nov 2002 05:15:35 -0500
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Sat, 23 Nov 2002 11:19:48 +0100
To: Loic Jaquemet <jal@les3stagiaires.freeserve.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.49: make bttv compiling again
Message-ID: <20021123101948.GA623@minerva.local.lan>
References: <20021123041250.10af38e3.jal@les3stagiaires.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20021123041250.10af38e3.jal@les3stagiaires.freeserve.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,=20

in order to make bttv compiling in 2.5.49, the following patch was necessary
for me.

### BEGIN PATCH ###

diff -ruN linux-2.5.49-old/drivers/media/video/audiochip.h linux-2.5.49/dri=
vers/media/video/audiochip.h
--- linux-2.5.49-old/drivers/media/video/audiochip.h	2002-11-22 22:40:23.00=
0000000 +0100
+++ linux-2.5.49/drivers/media/video/audiochip.h	2002-11-23 10:24:19.000000=
000 +0100
@@ -67,4 +67,7 @@
 #define AUDC_SWITCH_MUTE      _IO('m',16)      /* turn on mute */
 #endif
=20
+/* misc stuff to pass around config info to i2c chips */
+#define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
+
 #endif /* AUDIOCHIP_H */
diff -ruN linux-2.5.49-old/drivers/media/video/bttv-cards.c linux-2.5.49/dr=
ivers/media/video/bttv-cards.c
--- linux-2.5.49-old/drivers/media/video/bttv-cards.c	2002-11-22 22:40:42.0=
00000000 +0100
+++ linux-2.5.49/drivers/media/video/bttv-cards.c	2002-11-23 10:24:38.00000=
0000 +0100
@@ -2990,7 +2990,7 @@
=20
 	/* print which chipset we have */
 	while ((dev =3D pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
-		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);
+		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->dev.name);
=20
 	/* print warnings about any quirks found */
 	if (triton1)

### END PATCH ###

--=20
  .''`.   Name: Martin Loschwitz
 : :'  :  E-Mail: madkiss@madkiss.org
 `. `'`   www: http://www.madkiss.org/=20
   `-     Use Debian GNU/Linux - http://www.debian.org   =20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE931ZEHPo+jNcUXjARAkEGAKChWVDyzEhekygMJqpucpitUsZ58wCfdA32
8A0mluHLpsPdiQTVVuw1WKw=
=KC7o
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
