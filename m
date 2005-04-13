Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVDMNCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVDMNCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVDMNCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:02:21 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:20626 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261333AbVDMNAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:00:37 -0400
Date: Wed, 13 Apr 2005 14:59:27 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, aia21@cam.ac.uk, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413125927.GB9571@vagabond>
References: <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk> <20050412215220.GA23321@mail.shareable.org> <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2005 at 11:14:10 +0200, Miklos Szeredi wrote:
> > > There are uses for both.  For example today I was updating the tar ba=
ll=20
> > > which is used to create the var file system for a new chroot.  I cert=
ainly=20
> > > want to see corretly setup owner/permissions when I look into that ta=
r=20
> > > ball using a FUSE fs...
> >=20
> > If I'm updating a var filesystem for a new chroot, I'd need the
> > ability to chmod and chown things in that filesystem.  Does that work
> > as an ordinary user?
>=20
> Yes, within UML for example.=20

That's a bad example. UML does in fact *NOT* invoke host kernel's chmod,
because it has all the filesystem in a file.

But the answer is yes anyway. It's up to the filesystem to check whether
it is allowed. FUSE does not block it and if the actual userland driver
does not protest either, it is possible.

>[...]

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCXRevRel1vVwhjGURAivlAJ9ztjXm6w7r1Z7pbzZQxFcSWB+3TACfdOdh
V8rTjcH99LsQjVyfFqnD4VY=
=vEtJ
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
