Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUETUPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUETUPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 16:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUETUPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 16:15:46 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:35257 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265148AbUETUPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 16:15:43 -0400
Date: Thu, 20 May 2004 22:15:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: No forces rebuild while changing GCC?
Message-ID: <20040520201541.GH1912@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040520181617.GE1912@lug-owl.de> <20040520185635.GA4256@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5+9Hky6ESl43ooZB"
Content-Disposition: inline
In-Reply-To: <20040520185635.GA4256@mars.ravnborg.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5+9Hky6ESl43ooZB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-20 20:56:35 +0200, Sam Ravnborg <sam@ravnborg.org>
wrote in message <20040520185635.GA4256@mars.ravnborg.org>:
> On Thu, May 20, 2004 at 08:16:17PM +0200, Jan-Benedict Glaw wrote:
[While changing gcc, ...]
> > How can I force to keep my old .o files?
>=20
> This is not easy. kbuild uses a number of measures to check dependencies:
> 1) Changes in commandline, including name of binary
> - Order is not relevant, only content

So I'll compare old gcc's command line with new gcc's.

> 2) Compiler version used for version.h
> - To avoid this remove the FORCE in init/Makefile

Done.

> 3) Usual dependencies, including stdarg.h which is part of the compiler
>    include files

Argh...

> 4) Change in configuration relevant for that specific file

Argh, too:)

> I think you are hit by 1) in your case.
> Do you use same name for both gcc versions?

Both are just "vax-linux-gcc". I choose between them by altering $PATH
before I call "make mopboot".

> Otherwise it will fail as you describe (actually work as expected).

Right... It works as expectes and tried hard to build a consistent
kernel (actually, you did a great job at that!).

> Try to compare to commandlines when using "make V=3D1", to check what gcc
> kbuild uses.

Will do. Ah.

"-Wdeclaration-after-statement" is added to command line iff gcc accepts
it. The new one does, the old one didn't. Now commented out:) Works.

Thanks, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--5+9Hky6ESl43ooZB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArRHtHb1edYOZ4bsRAvFZAJwNDF/bXUmVI+SBr4bsQ1zAsKN1IgCfXMZA
lge35yNUEcBMbrz32ZM+iWc=
=wtsw
-----END PGP SIGNATURE-----

--5+9Hky6ESl43ooZB--
