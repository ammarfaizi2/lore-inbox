Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJ3Mu1>; Tue, 30 Oct 2001 07:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJ3MuQ>; Tue, 30 Oct 2001 07:50:16 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:7693 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S273870AbRJ3MuG>;
	Tue, 30 Oct 2001 07:50:06 -0500
Date: Tue, 30 Oct 2001 15:50:46 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for C-Media PCI audio driver
Message-ID: <20011030155046.A18980@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:47pm  up 18 days,  4:58,  4 users,  load average: 0.08, 0.17, 0.23
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Yet another driver lacking MODULE_DEVICE_TABLE.
Please consider applying.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-cmpci
Content-Transfer-Encoding: quoted-printable

diff -u -X /usr/dontdiff /linux.vanilla/drivers/sound/cmpci.c /linux/driver=
s/sound/cmpci.c
--- /linux.vanilla/drivers/sound/cmpci.c	Wed Oct 17 11:25:58 2001
+++ /linux/drivers/sound/cmpci.c	Sat Oct 20 09:37:05 2001
@@ -2847,6 +2847,17 @@
 MODULE_PARM_DESC(use_line_as_bass, "(1/0) Use line-in jack as bass/center"=
);
 MODULE_PARM_DESC(joystick, "(1/0) Enable joystick interface, still need jo=
ystick driver");
=20
+static struct pci_device_id cmpci_pci_tbl[] =3D {
+	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+ 	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338A,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338B,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, cmpci_pci_tbl);
+
 void initialize_chip(struct pci_dev *pcidev)
 {
 	struct cm_state *s;

--ZPt4rx8FFjLCG7dd--

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE73qImBm4rlNOo3YgRAjbFAJ45cvJj3QaQtArclUe2e5EaUQosoACcDP7Y
F2QCcpQovhi8qGVcXnjmAU8=
=3bz/
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
