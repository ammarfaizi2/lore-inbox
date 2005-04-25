Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVDYHXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVDYHXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVDYHXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:23:01 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:35232 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262549AbVDYHWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:22:50 -0400
Date: Mon, 25 Apr 2005 09:22:10 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, viro@parcelfarce.linux.theplanet.co.uk,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425072210.GC13975@vagabond>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2005 at 08:00:20 +0200, Miklos Szeredi wrote:
> > Much better is the proposal to make namespaces first-class objects,
> > that can be switched to.  Then users can choose to have themselves a
> > namespace containing their private mounts, if they want it, with
> > login/libpam or even a program run from .profile switching into it.
>=20
> It would be good if it could be done just in libpam.  But that would
> require every libpam user to call into it after the fork() or
> whatever, so unshare() and join_namespace() don't mess up the server
> running environment.

They do. The *HAVE* to do! The 'session' stage modifies the environment,
so it must be done after the fork. So if it, in addition to environment,
modifies namespace, it won't make a difference.

> If not, then it would mean modifying numerous programs, having these
> modifications integrated, then having distributions pick up the
> changes, etc.  I would imagine quite a long cycle for this to be
> acutally useful.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbJqiRel1vVwhjGURAqouAJ4x/LYvTHIuIDVK7q/FUieWpxD0MgCff5oO
2DPyxtUGk5/xfKDkJp+iYG4=
=nOPf
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
