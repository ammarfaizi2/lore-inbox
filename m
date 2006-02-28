Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWB1KU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWB1KU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWB1KU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:20:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:49825 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751046AbWB1KU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:20:56 -0500
X-Authenticated: #2308221
Date: Tue, 28 Feb 2006 11:20:52 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add =?iso-8859-1?Q?pata=5Fpdc=5F2?=
	=?iso-8859-1?Q?=DF27x_to_Kconfi?=
	=?iso-8859-1?Q?g?= and Makefile (was: Re: libata PATA patch for 2.6.16-rc5)
Message-ID: <20060228102052.GB19574@zeus.uziel.local>
References: <1141054370.3089.0.camel@localhost.localdomain> <20060228003039.GA13335@zeus.uziel.local> <1141120189.3089.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <1141120189.3089.47.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2006 at 09:49:49AM +0000, Alan Cox wrote:

> Thanks for the report. The PDC20268 and 2027x are driven by Albert Lee's
> Promise driver which should end up in the main tree soon, probably
> before my PATA bits.=20
>=20

And this patch activates the thing in Kconfig. Build tested already,
boot test is yet to come. Will report back in a few minutes - if I did
not entirely mess up my boot environment, that is.

Regards,
Chris


--- a/drivers/scsi/Kconfig	2006-02-28 04:01:31.000000000 +0100
+++ b/drivers/scsi/Kconfig	2006-02-28 11:10:18.959828288 +0100
@@ -823,6 +823,15 @@
=20
 	  If unsure, say N.
=20
+config SCSI_PATA_PDC
+	tristate "Newer Promise PATA controller support (Raving Lunatic)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for the Promise 20268 through 20277
+	  adapters.
+
+	  If unsure, say N.
+
 config SCSI_PATA_QDI
 	tristate "QDI VLB PATA support"
 	depends on SCSI_SATA
--- a/drivers/scsi/Makefile	2006-02-28 04:01:31.000000000 +0100
+++ b/drivers/scsi/Makefile	2006-02-28 11:07:11.751066376 +0100
@@ -162,6 +162,7 @@
 obj-$(CONFIG_SCSI_PATA_OPTI)	+=3D libata.o pata_opti.o
 obj-$(CONFIG_SCSI_PATA_PCMCIA)	+=3D libata.o pata_pcmcia.o
 obj-$(CONFIG_SCSI_PATA_PDC_OLD)	+=3D libata.o pata_pdc202xx_old.o
+obj-$(CONFIG_SCSI_PATA_PDC)	+=3D libata.o pata_pdc2027x.o
 obj-$(CONFIG_SCSI_PATA_QDI)	+=3D libata.o pata_qdi.o
 obj-$(CONFIG_SCSI_PATA_RADISYS)	+=3D libata.o pata_radisys.o
 obj-$(CONFIG_SCSI_PATA_RZ1000)	+=3D libata.o pata_rz1000.o

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iQIVAwUBRAQkBF2m8MprmeOlAQJfEA/+LocMb5j4P8mhQtWJd+/AQ+Gl0BhIAqvL
uDy4FQX1/fCKGfoMrHEZfsNIsAabq7GDg62NM5UNOTvF7GRtIL0IQds14AJbZTFO
TQuPAJT8B5Z97KbsR+FPHI5DhrjuI6qp4xx8p20GcJW+yRmlHTOeiTS7nQvJDmwy
SXgdahvwUVg6LJyfCkUVi0WGvGZzEEJfSo5Uo5GWFTBrY+gE1Pt/K3Oc3WDwUWET
540y5qj/y8rm+vVtUVDG6FYWP9ML3UsjSYOrbkq4v1fGeYlNDDEPKREtkQoruGdb
MCT51OQvBM98KoYDM4BwnCepC2AmNtC9x2KkdK/M0bbCO5NHQzz69KoK0TwAjIPc
p+p4774UchTvVu9e8DwXMyi7BPaZS+CkHaycrYRBy7YAGH1oFtK7D9YR75+M23L1
JvQbf0p2pDEo7jw5rJIyQjejr7lbY6s4rwlbbF6f2o3VzKWaZDKCl69GHqBf964Z
qpiDCP2nj6Ia3k6A3gWVxXUHCdjpN91odI1DQDUBHBbuVV2lva7pkUiOhrcm52zn
8zefxGAK3PQYYIVtn2lxvlKyLZe67KmGLQmINwnHvAxr8uljWvhQnlzAXJ3KDjOy
p9JGU99NPn7QG31cGrSn126EPMkmNuaLiWKQeiba6ldCy2Jq+sHexFpKqrI63crV
l5a5zM3Tc6I=
=fhAn
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

