Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265306AbUFTVbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUFTVbS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUFTVbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:31:18 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:8631 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265306AbUFTVbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:31:15 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <20040620211905.GA10189@mars.ravnborg.org>
References: <20040620211905.GA10189@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h01NS+3yzyDpc7a+QaU6"
Message-Id: <1087767034.14794.42.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 20 Jun 2004 23:30:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h01NS+3yzyDpc7a+QaU6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 at 23:19, Sam Ravnborg wrote:

Hiya,

> 2) Improved support for external modules.
>    It has been debated what to name the symlink in /lib/modules/`uname -r=
`
>    and where it should point.
>    Now that there is a possibility to build the kernel with a separate ou=
tput
>    directory, there is a need to utilise this in the install.
>    From now on build will point to the output directory, and source will =
point
>    to the kernel source.

I know Sam's mta blocks my mail at least (lame isp), but for the rest,
please reconsider using this.  Many external modules, libs, etc use
/lib/modules/`uname -r`/build to locate the _source_, and this will
break them all.

Once again I do not argue the logic behind this, but please then rather
do it in 2.7, or just keep 'build', and make the output one 'output' or
'object' or something.

>  No effort whatsoever will be done to keep external modules working if
>  they do not use the kbuild infrastructure. There is no reason not to
>  do so.

Given, but to 'use' the kbuild infrastructure, you must still call it
via:

  make -C _path_to_sources M=3D`pwd`

and any external project that at least tries to automate things a bit
(because some things are not always distributed with vendor distro,
 or updated regularly by vendor distro, and most users know at least
 how to do 'make && make install') will break.

Lastly, if the 'build'/whatever symlinks is not an 'kbuild'
infrastructure (as Sam want to make it, and thus base his reasoning why
it is Ok to build it) for finding the source of the current running
kernel, then what is, why have it in the first place?


Thanks,

--=20
Martin Schlemmer

--=-h01NS+3yzyDpc7a+QaU6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gH6qburzKaJYLYRAp0RAJ0UihCDFOhiZKSivhxrjmNh9fCjAACfdOtN
ePyGi/RmEc2Bj9kLIpHCa8I=
=IIHG
-----END PGP SIGNATURE-----

--=-h01NS+3yzyDpc7a+QaU6--

