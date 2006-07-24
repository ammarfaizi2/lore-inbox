Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWGXUhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWGXUhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWGXUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:37:39 -0400
Received: from www.timetrex.com ([69.93.244.106]:27075 "EHLO
	mail.academyoflearning.ca") by vger.kernel.org with ESMTP
	id S1751428AbWGXUhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:37:38 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Mike Benoit <ipso@snappymail.ca>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Matthias Andree <matthias.andree@gmx.de>, Hans Reiser <reiser@namesys.com>,
       lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
References: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vhGPuPo1eaME6S/qGcNi"
Date: Mon, 24 Jul 2006 13:37:13 -0700
Message-Id: <1153773433.5735.85.camel@ipso.snappymail.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4-2mdv2007.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vhGPuPo1eaME6S/qGcNi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-24 at 14:06 -0400, Horst H. von Brand wrote:
> > And EXT3 imposes practical limits that ReiserFS doesn't as well. The bi=
g
> > one being a fixed number of inodes that can't be adjusted on the fly,
>=20
> Right. Plan ahead.

That is great in theory. But back to reality, when your working for a
company that is growing by leaps and bounds that isn't always possible.
Why would I want to intentionally limit myself to a set number of inodes
when I can get a performance increase and not have to worry about it by
simply using ReiserFS?=20

It all boils down to using the right tool for the job, ReiserFS was the
right tool for this job.=20

> > I've been bitten by running out of inodes on several occasions,
>=20
> Me too. It was rather painful each time, but fixable (and in hindsight,
> dumb user (setup) error).
>=20
> >                                                                 and by
> > switching to ReiserFS it saved one company I worked for over $250,000
> > because they didn't need to buy a totally new piece of software.
>=20
> How can a filesystem (which by basic requirements and design is almost
> transparent to applications) make such a difference?!

Very easily, the backup software the company had spent ~$75,000 on
before I started working there used tiny little files as its "database".
Once the inodes ran out the entire system pretty much came to a
screeching halt. We basically had two options, use ReiserFS, or find
another piece of software that didn't use tiny little files as its
database. If I recall correctly the database went from about 2million
files to over 40 million in the span of just a few months. No one could
have predicted that. I believe this database was on an 18GB SCSI drive,
so even using 1K blocks wouldn't have worked. According to the mke2fs
man page:

"-i bytes-per-inode
This value generally shouldn't be smaller than the blocksize  of
the filesystem,  since  then  too many inodes will be made."

The only other option at that time was to purchase Veritas backup and
its not cheap. We ended up switching to ReiserFS, it increased our
backup/restore time immensely and also bought us about 1year before the
system finally outgrew itself for good. By that time the company could
afford to drop $250,000 on high end backup software so we could grow
past 10TB.

--=20
Mike Benoit <ipso@snappymail.ca>

--=-vhGPuPo1eaME6S/qGcNi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBExS95MhKjsejwBhgRAoNuAJwIX3bh1f83ayUThSRQUkI2cVb7uQCgnJ5b
kLJyoDBrN9oKs8wxDQgSLVo=
=GyVM
-----END PGP SIGNATURE-----

--=-vhGPuPo1eaME6S/qGcNi--

