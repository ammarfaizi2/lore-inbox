Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVDHEAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVDHEAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDHD7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:59:38 -0400
Received: from dea.vocord.ru ([217.67.177.50]:52405 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262665AbVDHD4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:56:40 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050408035052.GA31451@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
	 <1112931238.28858.180.camel@uganda>
	 <20050408033246.GA31344@gondor.apana.org.au>
	 <1112932354.28858.192.camel@uganda>
	 <20050408035052.GA31451@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KYRHvAVnH0WfW2x58Tpv"
Organization: MIPT
Date: Fri, 08 Apr 2005 08:02:49 +0400
Message-Id: <1112932969.28858.194.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 07:55:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KYRHvAVnH0WfW2x58Tpv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 13:50 +1000, Herbert Xu wrote:
> On Fri, Apr 08, 2005 at 07:52:34AM +0400, Evgeniy Polyakov wrote:
> > On Fri, 2005-04-08 at 13:32 +1000, Herbert Xu wrote:
> > > On Fri, Apr 08, 2005 at 07:33:58AM +0400, Evgeniy Polyakov wrote:
> > > > On Fri, 2005-04-08 at 12:59 +1000, Herbert Xu wrote:
> > > > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > > >
> > > > > > atomic_dec_and_test() is more expensive than 2 barriers + atomi=
c_dec(),
> > > > > > but in case of connector I think the price is not so high.
> > > > >=20
> > > > > Can you list the platforms on which this is true?
> > > >=20
> > > > sparc64, some mips [at least in UP].
> > >=20
> > > Are you sure? The implementations of atomic_sub and atomic_sub_return
> > > (which correspond to atomic_dec and atomic_dec_and_test) seem to be
> > > comparable in cost on those two architectures.
> >=20
> > mips has additional sync.
>=20
> But atomic_dec + 2 barries is going to do the sync as well, no?

On UP do not.

> Cheers,
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-KYRHvAVnH0WfW2x58Tpv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVgJpIKTPhE+8wY0RAhHlAJ0TTCls5sCgLLg9UYgFz2dF1XnNVQCfUxl3
NBm17hhhluqi3SxIHceL8B4=
=DJHW
-----END PGP SIGNATURE-----

--=-KYRHvAVnH0WfW2x58Tpv--

