Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbSJRFlL>; Fri, 18 Oct 2002 01:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSJRFlL>; Fri, 18 Oct 2002 01:41:11 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:7180 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262885AbSJRFlK>;
	Fri, 18 Oct 2002 01:41:10 -0400
Date: Fri, 18 Oct 2002 09:46:06 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] de2104x.c missing __devexit_p in 2.5.43
Message-ID: <20021018054606.GA3953@pazke.ipt>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20021017070332.GB304@pazke.ipt> <3DAEC758.5040209@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <3DAEC758.5040209@pobox.com>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2002 at 10:21:12AM -0400, Jeff Garzik wrote:
> Andrey Panin wrote:
> >diff -urN -X /usr/share/dontdiff linux-vanilla/drivers/net/tulip/de2104x=
c=20
> >linux/drivers/net/tulip/de2104x.c
> >--- linux-vanilla/drivers/net/tulip/de2104x.c	Sun Sep  1 02:04:53 2002
> >+++ linux/drivers/net/tulip/de2104x.c	Thu Oct 17 04:10:19 2002
> >@@ -2216,7 +2216,7 @@
> > 	.name		=3D DRV_NAME,
> > 	.id_table	=3D de_pci_tbl,
> > 	.probe		=3D de_init_one,
> >-	.remove		=3D de_remove_one,
> >+	.remove		=3D __devexit_p(de_remove_one),
> > #ifdef CONFIG_PM
> > 	.suspend	=3D de_suspend,
> > 	.resume		=3D de_resume,
>=20
>=20
> alas, it is incorrect, as no one hotplugs this hardware.

This patch is not about hotplugging, absence of __devexi_p() makes impossib=
le
to link this driver in kernel.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9r6AeBm4rlNOo3YgRAvUrAJ99y6tKjdGkt2mVJ3uaPCulnoiNcQCfa9P/
EPjWSaTgYS/EHcgg9U2S11A=
=5naq
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
