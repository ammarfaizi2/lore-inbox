Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVDHD1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVDHD1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVDHD1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:27:52 -0400
Received: from dea.vocord.ru ([217.67.177.50]:435 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261443AbVDHD1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:27:49 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c4nlVr4ept+CFZjbaklP"
Organization: MIPT
Date: Fri, 08 Apr 2005 07:33:58 +0400
Message-Id: <1112931238.28858.180.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 07:27:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c4nlVr4ept+CFZjbaklP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 12:59 +1000, Herbert Xu wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > atomic_dec_and_test() is more expensive than 2 barriers + atomic_dec(),
> > but in case of connector I think the price is not so high.
>=20
> Can you list the platforms on which this is true?

sparc64, some mips [at least in UP].
I do not know about others, but I think that any
arch, where atomic operations are serialized,
has sync/isync in atomic_dec_and_test()
and does not for atomic_dec().

> Thanks,
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-c4nlVr4ept+CFZjbaklP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVfumIKTPhE+8wY0RAj2iAJwJanPWfSgsEM2PaIxLu4wV0M8xugCfRMT3
pCJdIi+I0/Iw+qZ97+vtg3M=
=uDsv
-----END PGP SIGNATURE-----

--=-c4nlVr4ept+CFZjbaklP--

