Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbULQRVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbULQRVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbULQRVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:21:40 -0500
Received: from ctb-mesg5.saix.net ([196.25.240.77]:5866 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S262079AbULQRVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:21:18 -0500
Subject: Re: debugfs in the namespace [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041216221843.GA10172@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
	 <20041216190835.GE5654@kroah.com> <41C20356.4010900@sun.com>
	 <20041216221843.GA10172@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nTZAPUFm6gmZiWF+EF7U"
Date: Fri, 17 Dec 2004 19:22:02 +0200
Message-Id: <1103304122.12935.6.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nTZAPUFm6gmZiWF+EF7U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-12-16 at 14:18 -0800, Greg KH wrote:
> On Thu, Dec 16, 2004 at 04:51:18PM -0500, Mike Waychison wrote:
> > I thought debugfs was meant for just debugging.  As there is no plans
> > for standardizing its namespace, why are we allowing ourselves to rely
> > on it being mounted at all?
> >=20
> > AFAICT, there should be no excuse for userspace to actually rely on any
> > of the data within debugfs.  Otherwise we end up with yet another
> > filesystem whose role is: Chaotic hodgepodge of magic files created by
> > drivers that couldn't bother to be well-organized.
> >=20
> > Please, let's not make debugfs part of userspace.  Keep it for what it
> > is, debugging purposes only.
>=20
> I'm not saying we will ever make it "required" at all.  It's just that
> people are going to want to mount the thing, and are already asking me
> where we should mount it at.  If you pick a different place than me,
> fine, I don't mind.  It's the user who is asked to report some info that
> happens to be in debugfs that is going to want to know where to put it,
> as they have no idea even what it is.  Distros are going to ask what to
> put in their fstabs for where to mount the thing too.
>=20
> So, let's pick a place and be done with it.
>=20
> I like /dbg (3 characters total to get to, which is shorter than /debug
> which takes at least 4, 3 chars and a tab).  Pete likes /debug.  Jan
> Engelhardt want to hide the thing from people at /.debugfs.
>=20
> Hm, what about /.debug ?  That's a compromise that I can live with (even
> less key strokes to get to...)
>=20
> Or is their some restriction on putting hidden directories in the root
> filesystem as specified by the LSB?
>=20
> So, /.debug sound acceptable?
>=20

Prob silly, but what about /sys/dbg ?  Out of sight ...


--=20
Martin Schlemmer


--=-nTZAPUFm6gmZiWF+EF7U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBwxW6qburzKaJYLYRAroyAJ4hM3w40nXUvLe2prAZ0o18+vV8mgCfYQEY
wOSVaBWDfbbr0ryUU1KtUo8=
=owaZ
-----END PGP SIGNATURE-----

--=-nTZAPUFm6gmZiWF+EF7U--

