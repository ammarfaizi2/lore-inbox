Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTL3BfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTL3BfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:35:24 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:29889 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264319AbTL3BfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:35:17 -0500
Subject: Re: 2.6.0 performance problems
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Dave Jones <davej@redhat.com>
Cc: Thomas Molina <tmolina@cablespeed.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031230012715.GA30369@redhat.com>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
	 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
	 <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
	 <1072741422.25741.67.camel@nosferatu.lan>
	 <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain>
	 <20031230012715.GA30369@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-flRWkNAKKHZYQIDHT+z7"
Message-Id: <1072748264.25741.79.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 03:37:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-flRWkNAKKHZYQIDHT+z7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-30 at 03:27, Dave Jones wrote:
> On Mon, Dec 29, 2003 at 07:17:23PM -0500, Thomas Molina wrote:
>=20
>  > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4
>  > > >  AdvancedPM=3Dyes: mode=3D0x80 (128) WriteCache=3Denabled
>  > > >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
>  > > Any reason it is currently set to udma2 where it support udma4 ?
>  >=20
>  > Not really.  The question was what mode the disk was running in.  This=
 is=20
>  > what it defaults to.  This is a laptop drive that only runs at 5400RPM=
. =20
>  > Would changing the mode to udma4 make a dramatic difference? =20
>=20
> It's not uncommon for a laptop to have a hard disk which supports
> higher DMA modes than what the IDE chipset supports.
> My aging Intel 440BX based VAIO has a disk in the same configuration
> as yours, supports udma4, but chipset only goes up to udma2.
>=20

Right, or as somebody else pointed out, it might not be a 80-pin cable.

Lets rephrase - does it also run in udma2 mode with 2.4 ?  And did
you check readahead?  In 2.6 it seems that a bigger value is better -
I for instance have to set it to 8192 to have the same performance as
in 2.4 ...


--=20
Martin Schlemmer

--=-flRWkNAKKHZYQIDHT+z7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/8NboqburzKaJYLYRAkepAJ9rUypdcD03let3nZk8dCnq0ByK1gCeOx/o
G6TZ5OwKzWBHkCgPNI9LGfQ=
=bhw0
-----END PGP SIGNATURE-----

--=-flRWkNAKKHZYQIDHT+z7--

