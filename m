Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268795AbUHZN17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268795AbUHZN17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUHZN1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:27:45 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:48276 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268794AbUHZN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:27:13 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826130718.GB820@lst.de>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
	 <20040826014542.4bfe7cc3.akpm@osdl.org>
	 <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de>
	 <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GF3yaRKueIaxVkCW+tfp"
Date: Thu, 26 Aug 2004 15:27:01 +0200
Message-Id: <1093526821.11694.15.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GF3yaRKueIaxVkCW+tfp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 15:07 +0200 schrieb Christoph Hellwig:

> > The reiser4 core doesn't know about inodes, directories or files. It's
> > the glue code between the VFS and the storage layer that does. It's
> > implemented as a plugin. This has nothing to do with semantic
> > enhancements yet. These should be removed for now and made a 2.7 topic.
>=20
> Oh yes, it is.  As soon as you use different access methods on an
> overlapping set of objects you see exactly the problems I described.

Right. That shouldn't happen. Since an object is usally tied to exactly
one plugin this can't happen I think. At least as long the programmer
doesn't mess anything up.

> If they don't overlap there's no point for the plugins to start with,
> you'll better turn the core into a library that can be used by different
> projects then.

I think that's what Hans is trying to suggest. The core is theoretically
usable for anything. He made a filesystem of it.

You can see reiser4 as a library and the UNIX directory and file plugins
as the filesystem. That's why they are linked in uncoditionally because
it doesn't make sense otherwise. It's mainly the naming that seems to
confuse people.


--=-GF3yaRKueIaxVkCW+tfp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLeUlZCYBcts5dM0RAgtMAJ9Ioh6ZzeKEDC54OzV2AbcEGthyqACfX9kV
/LMOtx7w/Zks1bTQkLPP9pY=
=hb0O
-----END PGP SIGNATURE-----

--=-GF3yaRKueIaxVkCW+tfp--

