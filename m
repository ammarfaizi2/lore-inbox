Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271842AbTGYA0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271845AbTGYA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:26:00 -0400
Received: from D7040.pppool.de ([80.184.112.64]:50328 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S271842AbTGYAZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:25:40 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Daniel Egger <degger@fhm.edu>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <16160.4704.102110.352311@laputa.namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WAGhnsVHvBZLC9drdu+e"
Message-Id: <1059093594.29239.314.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Jul 2003 02:39:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WAGhnsVHvBZLC9drdu+e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2003-07-24 um 19.07 schrieb Nikita Danilov:

> I don't know enough about jffs2, but you can read about reiser4's
> "wandering logs" and transaction manager design at the
> http://www.namesys.com/txn-doc.html.

I've read it by now, thanks for the reference.

> Briefly speaking, in usual WAL (write-ahead logging) transaction system,
> whenever block is modified, journal record, describing changes to this
> block is forced to the on-disk journal before modified block is allowed
> to be written. In the worst case this means that data are written twice.

Is there way to influence what is considered free space for the
wandering blocks or is it a fixed algorithm? If the latter, what is the
access pattern on the free space (like pseudorandom, cyclic linear,
hashed)?

> I should warn everybody that reiser4 is _highly_ _experimental_ at this
> moment. Don't use it for production.

That certainly doesn't stop me from trying... :)
Have you ran any tests to test the durabilty of your "transcrash" system
for instance against sudden power dropouts?
Is the filesystem selfhealing or does one need fsck.reiserfs for it? If
the latter: will it do the right thing (i.e. automatically bring the
system into consistent shape not like ext3) when invoked with "-y"?

--=20
Servus,
       Daniel

--=-WAGhnsVHvBZLC9drdu+e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/IHxachlzsq9KoIYRApIMAJ9JQWBKJSYBAcGqSQXkolLp5LpQfQCfQJtx
kkmPLHj75ix2WcAtSjgwZEM=
=4jgL
-----END PGP SIGNATURE-----

--=-WAGhnsVHvBZLC9drdu+e--

