Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVGKRWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVGKRWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGKRTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:19:53 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:60112 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S261759AbVGKRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:19:40 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: dtor_core@ameritech.net
Subject: Re: kernel guide to space
Date: Mon, 11 Jul 2005 19:19:23 +0200
User-Agent: KMail/1.7.2
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
References: <20050711145616.GA22936@mellanox.co.il> <d120d50005071108442866ffcd@mail.gmail.com>
In-Reply-To: <d120d50005071108442866ffcd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1450852.WEkaF46Ymz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507111919.29350.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1450852.WEkaF46Ymz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 July 2005 17:44, Dmitry Torokhov wrote:
> >        Descendant must be indented at least to the level of the innermo=
st
> >        compound expression in the parent. All descendants at the same l=
evel
> >        are indented the same.
> >        if (foobar(.................................) + barbar * foobar(=
bar +
> >                                                                        =
foo *
> >                                                                        =
oof)) {
> >        }
>=20
> Ugh, that's as ugly as it can get... Something like below is much
> easier to read...
>=20
>         if (foobar(.................................) +
>             barbar * foobar(bar + foo * oof)) {
>         }
=20
Even easier is
         if (foobar(.................................)
             + barbar * foobar(bar + foo * oof)) {
         }

since a statement cannot start with binary operators
and as such we are SURE that there must have been something before.
And this matches with old shop owner calculations like:

   1
+  2
+  3
=2D---
   6

which we all know since early math classes.


Regards

Ingo Oeser



--nextPart1450852.WEkaF46Ymz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0qohU56oYWuOrkARAm9xAJ9lfh0/kajpt9DyRPj+MLsU7J5SfwCg3dxb
+QqaDF153ntrxywxlP9cnT8=
=vIyN
-----END PGP SIGNATURE-----

--nextPart1450852.WEkaF46Ymz--
