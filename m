Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUFTVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUFTVyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFTVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:54:53 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:17591 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265962AbUFTVxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:53:21 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: arjanv@redhat.com
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <1087767752.2805.18.camel@laptop.fenrus.com>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <1087767034.14794.42.camel@nosferatu.lan>
	 <1087767752.2805.18.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6iW1hG5Y3zZA/1sIwg5J"
Message-Id: <1087768362.14794.53.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 20 Jun 2004 23:52:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6iW1hG5Y3zZA/1sIwg5J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 at 23:42, Arjan van de Ven wrote:
> > Given, but to 'use' the kbuild infrastructure, you must still call it
> > via:
> >=20
> >   make -C _path_to_sources M=3D`pwd`
>=20
> I see no problem with requiring this though; requiring a correct
> makefile is perfectly fine with me, and this is the only and documented
> way for 2.6 already.
> (And it's also the only way to build modules against Fedora Core 2
> kernels by the way)
>=20

I did not mean I have a problem with that.  Say you take svgalib, and
you want the build system to automatically compile the kernel module,
you might do something like:

---
build_2_6_module:
	@make -C /lib/modules/`uname -r`/build M=3D`PWD`
---

will break with proposed patch ...

And the point I wanted to make was that AFIAK
'/lib/modules/`uname -r`/build' is an interface to figure
out where the _sources_ for the current running kernel are
located.  And apparently I am not the only one, as most if
not all external projects use this as the way (or one of
them at least) to determine this ...=20


Thanks,

--=20
Martin Schlemmer

--=-6iW1hG5Y3zZA/1sIwg5J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gcqqburzKaJYLYRArrmAJ9volYlE8WC2h4MdRzft5iR/1LIuACgjvPG
NeozoGICsrT9mcnSovrTCFI=
=GVo1
-----END PGP SIGNATURE-----

--=-6iW1hG5Y3zZA/1sIwg5J--

