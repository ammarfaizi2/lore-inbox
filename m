Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278389AbRJSNJM>; Fri, 19 Oct 2001 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278390AbRJSNJH>; Fri, 19 Oct 2001 09:09:07 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:23567 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S278389AbRJSNI4>;
	Fri, 19 Oct 2001 09:08:56 -0400
Date: Fri, 19 Oct 2001 17:09:26 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for Applicom fieldbus card driver
Message-ID: <20011019170926.D3170@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:51pm  up 7 days,  4:01,  4 users,  load average: 0.24, 0.12, 0.15
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--APlYHCtpeOhspHkB
Content-Type: multipart/mixed; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Last patch for this week ...

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-applicom
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/char/applicom.c /linux/dri=
vers/char/applicom.c
--- /linux.vanilla/drivers/char/applicom.c	Wed Oct 17 11:25:44 2001
+++ /linux/drivers/char/applicom.c	Thu Oct 18 12:12:58 2001
@@ -72,6 +72,17 @@
 	"PCI2000PFB"
 };
=20
+static struct pci_device_id applicom_pci_tbl[] =3D {
+	{ PCI_VENDOR_ID_APPLICOM, PCI_DEVICE_ID_APPLICOM_PCIGENERIC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_APPLICOM, PCI_DEVICE_ID_APPLICOM_PCI2000IBS_CAN,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_APPLICOM, PCI_DEVICE_ID_APPLICOM_PCI2000PFB,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, applicom_pci_tbl);
+
 MODULE_AUTHOR("David Woodhouse & Applicom International");
 MODULE_DESCRIPTION("Driver for Applicom Profibus card");
 MODULE_LICENSE("GPL");

--gneEPciiIl/aKvOT--

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70CYGBm4rlNOo3YgRAjy+AJ92r1odFXIyIYGDa0NuLSlZicFyxgCff3W1
p3Zs+R9s5tT0CZwP0QZ6Wlk=
=s3rA
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
