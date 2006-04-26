Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWDZUZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWDZUZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWDZUZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:25:35 -0400
Received: from lug-owl.de ([195.71.106.12]:48797 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S964863AbWDZUZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:25:35 -0400
Date: Wed, 26 Apr 2006 22:25:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: C++ pushback
Message-ID: <20060426202533.GT25520@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z87VqPJ/HsYrR2WM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z87VqPJ/HsYrR2WM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-26 13:09:38 -0700, Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 26 Apr 2006, Jan-Benedict Glaw wrote:
> > There's one _practical_ thing you need to keep in mind: you'll either
> > need 'C++'-clean kernel headers (to interface low-level kernel
> > functions) or a separate set of headers.
>=20
> I suspect it would be easier to just do
>=20
> 	extern "C" {
> 	#include <linux/xyz.h>
> 	...
> 	}
>=20
> instead of having anything really C++'aware in the headers.

=2E..but you need to admit that your left hand tried to make your right
hand not typing this, didn't it?

>  - the language just sucks. Sorry, but it does.
>  - some of the C features we use may or may not be usable from C++=20
>    (statement expressions?)

In the constructor pathes, I expect higher stack usage than we now
have.

>  - a lot of the C++ features just won't be supported sanely (ie the kerne=
l=20
>    infrastructure just doesn't do exceptions for C++, nor will it run any=
=20
>    static constructors etc).

So what actually can be made useable (and what actually makes sense):

  * Classes with public and private funct^Wmembers, constructors.
  * Namespaces? Don't think they're all _that_ useful for us.
  * Static constructors probably won't fly.

> Anyway, it should all be doable. Not necessarily even very hard. But I=20
> doubt it's worth it.

I guess if somebody has a large portion of well-separated C++ code
(eg. a complete and complex filesystem), it would be easier to write
some glue code to "run" the C++ code with the kernel.

Though it would be even easier to use FUSE's bindings:-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--z87VqPJ/HsYrR2WM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFET9c9Hb1edYOZ4bsRAvHuAJ44AxiCv0C4VcwHkJIAOxutJUDsvgCePFdh
7K2vmk+h6O3hj0AVQ9+yNe4=
=JzTk
-----END PGP SIGNATURE-----

--z87VqPJ/HsYrR2WM--
