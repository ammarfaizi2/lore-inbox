Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVAKVO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVAKVO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVAKVNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:13:24 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:23237 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262819AbVAKVMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:12:43 -0500
Subject: Re: [PATCH] Trusted Path Execution LSM 0.2 (20050108)
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Steve G <linux_4ever@yahoo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111123320.S469@build.pdx.osdl.net>
References: <20050111195542.76809.qmail@web50605.mail.yahoo.com>
	 <20050111123320.S469@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gd+kAf4/0Eo6d8fmroDW"
Date: Tue, 11 Jan 2005 22:11:36 +0100
Message-Id: <1105477896.24610.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gd+kAf4/0Eo6d8fmroDW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

El mar, 11-01-2005 a las 12:33 -0800, Chris Wright escribi=F3:
> * Steve G (linux_4ever@yahoo.com) wrote:
> > This patch leaks memory in the error paths. For example:=20
> >=20
> > +static ssize_t trustedlistadd_read_file(struct tpe_list *list, char *b=
uf)
> > +{
> > <snip>
> > + char *buffer =3D kmalloc(400, GFP_KERNEL);
> > +
> > + user =3D (char *)__get_free_page(GFP_KERNEL);
> > + if (!user)
> > + return -ENOMEM;
>=20
> Helps to inform the author ;-)

It's fixed now and i will update the patches ASAP.

Next time it would be better to CC me directly, but anyway, thanks for
reporting this, as much as you mess it up, it's as much as i will work
to make it better ;).

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-gd+kAf4/0Eo6d8fmroDW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB5EEHDcEopW8rLewRAs9HAJ4lCStPu8mGcd3P3PwHUCb7ANwHAgCgtzbo
947XNHPlwOLmO1g9IzK7dLE=
=runt
-----END PGP SIGNATURE-----

--=-gd+kAf4/0Eo6d8fmroDW--

