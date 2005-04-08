Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVDHEtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVDHEtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVDHEt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:49:28 -0400
Received: from dea.vocord.ru ([217.67.177.50]:14781 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262650AbVDHEtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:49:18 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050408041724.GA32243@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
	 <1112931238.28858.180.camel@uganda>
	 <20050408033246.GA31344@gondor.apana.org.au>
	 <1112932354.28858.192.camel@uganda>
	 <20050408035052.GA31451@gondor.apana.org.au>
	 <1112932969.28858.194.camel@uganda>
	 <20050408040237.GA31761@gondor.apana.org.au>
	 <1112934088.28858.199.camel@uganda>
	 <20050408041724.GA32243@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tnXnEIWZLyP9KSBgmkNZ"
Organization: MIPT
Date: Fri, 08 Apr 2005 08:55:27 +0400
Message-Id: <1112936127.28858.206.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 08:48:35 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tnXnEIWZLyP9KSBgmkNZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 14:17 +1000, Herbert Xu wrote:
> On Fri, Apr 08, 2005 at 08:21:28AM +0400, Evgeniy Polyakov wrote:
> >
> > > > On UP do not.
> > >=20
> > > Shouldn't we should be fixing the MIPS implementation of
> > > atomic_sub_return to not do the sync on UP then?
> >=20
> > Unfortunately not, that sync is required exactly for return value store=
.
>=20
> On UP?

Yes, some quotes:

The memory access type of a location affects the behavior of I-fetch,
load, store,
and prefetch operations to the location. In addition, memory access
types affect
some instruction descriptions. Load linked (LL, LLD) and store
conditional (SC,
SCD) have defined operation only for locations with cached memory access
type.
SYNC affects only load and stores made to locations with uncached or
cached
coherent memory access types.

3. The SC [comment: store conditional]=20
stores a new value into the memory word, unless the new value has
been modified. If the word has not been modified, the store succeeds and
a 1
is stored in the destination register. Otherwise the Store Conditional
fails,
memory is not modified, and a 0 is loaded into the destination register.
Since
the instruction format has only a single field to select a data register
(rt), this
destination register is the same as the register which was stored.
Load Linked and Store Conditional instructions (LL, LLD, SC, and SCD) do
not
implicitly perform SYNC operations in the R10000 processor.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-tnXnEIWZLyP9KSBgmkNZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVg6/IKTPhE+8wY0RAp+iAJ41uyCDgUfSYxa9wcIF5y27tLVDVACfW+B/
pss4cbBZepla8/v4EoscaVM=
=v9Bl
-----END PGP SIGNATURE-----

--=-tnXnEIWZLyP9KSBgmkNZ--

