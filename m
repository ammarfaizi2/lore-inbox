Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUFTW0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUFTW0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUFTW0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:26:21 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:23479 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265971AbUFTWZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:25:58 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <20040620221824.GA10586@mars.ravnborg.org>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <1087767034.14794.42.camel@nosferatu.lan>
	 <20040620220319.GA10407@mars.ravnborg.org>
	 <20040620221824.GA10586@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h/t8mXIf+kgMMRRAFCfJ"
Message-Id: <1087770318.14794.76.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 00:25:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h/t8mXIf+kgMMRRAFCfJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-21 at 00:18, Sam Ravnborg wrote:
> On Mon, Jun 21, 2004 at 12:03:19AM +0200, Sam Ravnborg wrote:
> > If I get just one good example I will go for the object directory, but
> > what I have seen so far is whining - no examples.
>=20
> Now I recall why I did not like the object directory.
> I will break all modules using the kbuild infrastructure!
>=20

Below do not really explain this - care to be more detailed?

> Why, because there is no way the to find the output directory except
> specifying both directories.
> One could do:
> make -C /lib/modules/`uname -r`/source O=3D/lib/modules/`uname -r`/build =
M=3D`pwd`
>=20

Huh?  Explain to me how else you would do builds that have separate
output directory?  And what is the difference from above to:

make -C /lib/modules/`uname -r`/build O=3D/lib/modules/`uname -r`/object M=
=3D`pwd`

except that you will _not_ cause existing stuff to break?

> So the currect choice is:
> 1) Break modules that actually dive into the src, grepping, including or =
whatever
> 2) Break all modules using kbuild infrastructure, including the above one=
s
>=20
> I go for 1), introducing minimal breakage.
>=20
> And please keep in mind. The breakage wil _only_ be visible when kernels =
are
> shipped with separate output directory.

How is that?  In both cases the 'build' symlink do not point to the
source anymore.

> If kernels are shipped with no output files at all then one can just
> compile the kernel. Seems to be the Fedora way. No breakage happens.
>=20
> If kernels are shipped with mixed source and output then no breakage happ=
ens.
>=20
> If kernels are shipped with separate source and output then we better bre=
ak
> as few modules as possible. And the introduced change actually minimize b=
reakage.
>=20
> So the patch will not change.
>=20
> 	Sam
--=20
Martin Schlemmer

--=-h/t8mXIf+kgMMRRAFCfJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1g7OqburzKaJYLYRAtWOAJ4nkcOkGw/gtnUfUgkQ7mZsuSi+rACfW2nw
DtRZZrU9gJheWMePzXheh0o=
=oY+p
-----END PGP SIGNATURE-----

--=-h/t8mXIf+kgMMRRAFCfJ--

