Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVA1OKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVA1OKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVA1OK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:10:26 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:16009 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261408AbVA1OH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:07:57 -0500
Date: Fri, 28 Jan 2005 15:07:56 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, hugang@soulinfo.com,
       Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order memory allocations
 on suspend
Message-ID: <20050128150756.1d6976cb@phoebee>
In-Reply-To: <200501281454.23167.rjw@sisk.pl>
References: <200501281454.23167.rjw@sisk.pl>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Fri__28_Jan_2005_15_07_56_+0100_ew0MOUA3tasO8Bo/";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__28_Jan_2005_15_07_56_+0100_ew0MOUA3tasO8Bo/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

> @@ -373,15 +377,22 @@
> =20
>  static int write_pagedir(void)
>  {
> -	unsigned long addr =3D (unsigned long)pagedir_nosave;
>  	int error =3D 0;
> -	int n =3D SUSPEND_PD_PAGES(nr_copy_pages);
> -	int i;
> +	unsigned n =3D 0;
> +	struct pbe * pbe;
> +
> +	printk( "Writing pagedir ...");
>=20
> +
> +	pr_debug("\b\b\bdone (%u pages)\n", n);

Just cosmetic:
Why do you use pr_debug here instead of printk like you did above?

--=20
MyExcuse:
the printer thinks its a router.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Fri__28_Jan_2005_15_07_56_+0100_ew0MOUA3tasO8Bo/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB+kc8mjLYGS7fcG0RAjpNAKCriTipFXLNUg6bWy1oSA8LyDRHqACeOHsP
9wp4NjBN4vnhiPpzBOCJN9o=
=5Tq/
-----END PGP SIGNATURE-----

--Signature_Fri__28_Jan_2005_15_07_56_+0100_ew0MOUA3tasO8Bo/--
