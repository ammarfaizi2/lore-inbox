Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTKFUHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTKFUHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:07:44 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:38799 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263745AbTKFUHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:07:40 -0500
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3FAA9BD2.1060306@gmx.de>
References: <20031106130030.GC1145@suse.de>
	 <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de>
	 <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de>
	 <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de>
	 <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de>
	 <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de>
	 <3FAA5CCB.5030902@gmx.de> <1068144567.5499.96.camel@tux.rsn.bth.se>
	 <3FAA9BD2.1060306@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s8DGsnxzRzsCYPa5iKIw"
Message-Id: <1068149254.5501.119.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 21:07:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s8DGsnxzRzsCYPa5iKIw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 20:06, Prakash K. Cheemplavam wrote:

> > #/bin/bash
>=20
> A ! is missing there... Only 0 are appearing...what is expected? Do I=20
> have do do anything else?

Hmm how did I miss that... fixed now, thanks.

diskstat.sh hde

My output looks like this:

row     reads   rmerge  rsect   rms     writes  wmerge  wsect   wms     io =
     ms      ms2
241     3       2       40      0       123     33      296     62384   0  =
     146     12798
242     0       0       0       0       0       0       0       0       0  =
     0       0
243     0       0       0       0       3       0       24      3       0  =
     3       3
244     3       7       80      26      244     110     3984    23688   144=
     368     44683
245     1       0       8       20      325     8505    70600   118889  139=
     1015    143674
246     3       0       24      51      172     924     7656    115233  0  =
     851     69550
247     2       0       16      44      0       0       0       0       0  =
     44      44
248     2       0       16      24      0       0       0       0       0  =
     24      24
249     4       0       32      62      531     301     7800    61074   143=
     863     83732
250     5       0       40      80      553     125     5568    155622  161=
     1032    153844
251     8       0       64      222     486     147     4824    164073  131=
     1099    176655
252     2       7       72      36      526     160     5464    156330  128=
     1014    145540
253     0       0       0       0       599     74      5472    132976  139=
     1034    146270
254     1       0       8       13      551     163     5720    141778  140=
     1018    149876
255     4       0       32      100     642     248     7256    225351  157=
     1433    207807
256     0       0       0       0       716     254     7896    211376  173=
     1470    211602
257     2       0       16      37      502     74      4368    129258  143=
     1015    149133
258     1       0       8       20      537     147     5352    162866  128=
     1010    150900

This is during a sequential write, only one writer. File received via
network.

Everything's humming along fine at 11-12MB/s until row 249, there it
drops to 2-4MB/s and the machine freezes for 1-2 seconds every 3-10
seconds. Data taken from /proc/diskstats and is in the same order as
those fields (documented in Documentation/iostats.txt).

Don't know if it's related to your problems in any way.

--=20
/Martin

--=-s8DGsnxzRzsCYPa5iKIw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qqoFWm2vlfa207ERAswuAJ9nyzOjh6CeXZjXveHtzGbZx3TxBACeOuMw
UTXsmU+IHND9qtWuBcgd1+E=
=n37e
-----END PGP SIGNATURE-----

--=-s8DGsnxzRzsCYPa5iKIw--
