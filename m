Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUHZNfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUHZNfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUHZNfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:35:43 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:11413 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265410AbUHZNfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:35:20 -0400
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826132439.GA1188@lst.de>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
	 <20040826014542.4bfe7cc3.akpm@osdl.org>
	 <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de>
	 <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>
	 <1093526273.11694.8.camel@leto.cs.pocnet.net>
	 <20040826132439.GA1188@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3qh73zW5Pcc7NeueNqK0"
Date: Thu, 26 Aug 2004 15:35:07 +0200
Message-Id: <1093527307.11694.23.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3qh73zW5Pcc7NeueNqK0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 15:24 +0200 schrieb Christoph Hellwig:

> > First you say that that file-as-a-directory is crap then you say that i=
t
> > does belong into the filesystem?
>=20
> I think you're talking about something different then me, I'm not
> talking about the magic meta files but the VFS interface in general.
>=20
> This VFS interface is an integral part of very filesystem, and it
> doesn't make a whole lot to put it into a plugin.

Right. That's why these plugins are linked in uncoditionally. It doesn't
work without them. Hence "plugins" is not a very good name.

> If you want your
> filesystem core portable it does to a certain extent make sense to
> abstract them out, but as someone who's worked on a few such 'portable'
> filesystems I can tell you that it doesn't work out as expected.

That's your opinion. reiser4 seems to work very well.

> Now kill the whole plugin mess and let them talk directly to another.

This is how reiserfs v3 did it. And Hans says that it actually
complicated things.

> My first mail explained to you why it doesn't make sense to have
> multiple such plugins to work on a common subset of data.

What I understood is that you can select exactly one plugin that e.g.
handles the file data. The default plugin is optimized for normal files,
another one could implement transparent compression or encryption. Some
of these plugins also give the storage layer hints how to group files
together to optimized performance. Neither of these things mess with the
VFS.

> > The latter doesn't necessarily have anything to do with plugins.
> > The plugins are plugins for the storage layer, not for some semantic
> > enhancement.
>=20
> Again plugins below the pagecache (if that's what you call the "storage
> layer") _do_ make sense.  plugins at the semantic layer don't.

Yes, that's what I was trying to say.


--=-3qh73zW5Pcc7NeueNqK0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLecLZCYBcts5dM0RAlaXAJ9m2ibhP+bOoKUCq87YCqS+I8jLOwCfVyx9
v3D6AxGovKD53spD93b0FRw=
=n2s/
-----END PGP SIGNATURE-----

--=-3qh73zW5Pcc7NeueNqK0--

