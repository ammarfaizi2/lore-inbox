Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUHZQIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUHZQIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUHZQFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:05:52 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:39324 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269144AbUHZQFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:05:06 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Rik van Riel <riel@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KEDbg+OWlcQIW+DZ1Yjv"
Date: Thu, 26 Aug 2004 18:04:42 +0200
Message-Id: <1093536282.5482.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KEDbg+OWlcQIW+DZ1Yjv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 11:54 -0400 schrieb Rik van Riel:

> > > And if you read test.compound (the main stream) you get a special for=
mat
> > > that contains all the components. You can copy that single stream of
> > > bytes to another (reiser4) fs and then access test.compound/test.txt
> > > again.
> >=20
> > (To Rik especially), this is the design which more or less satisfies
> > lots of different goals at once.
>=20
> And if an unaware application reads the compound file
> and then writes it out again, does the filesystem
> interpret the contents and create the other streams ?
>=20
> Unless I overlook something (please tell me what), the
> scheme just proposed requires filesystems to look at
> the content of files that is being written out, in
> order to make the streams work.

Yes, the main compound stream unaware applications would see would just
be a writable view of its contents. Probably not trivial to implement
but doable.

It should be a simple format. Something simliar to tar. The worst thing
that can happen is people start writing plugins for every existing
compound format out there. It should be the other way around, agree on a
simple compound format and encourage applications to use this one if the
want to use this advantage.


--=-KEDbg+OWlcQIW+DZ1Yjv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLgoaZCYBcts5dM0RAn9iAJ9pzNxBRNRfOhSCNNFEnaHNqWCxgwCgjSHr
BZY66cGAMVHi5+ZRNCdVYo0=
=YXoN
-----END PGP SIGNATURE-----

--=-KEDbg+OWlcQIW+DZ1Yjv--

