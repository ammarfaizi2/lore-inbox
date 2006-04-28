Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWD1H6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWD1H6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWD1H6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:58:34 -0400
Received: from lug-owl.de ([195.71.106.12]:1426 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030314AbWD1H6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:58:34 -0400
Date: Fri, 28 Apr 2006 09:58:32 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: make O="<dir>" install; output not relocated; 2.6.16.11(kbuild)
Message-ID: <20060428075832.GD25520@lug-owl.de>
Mail-Followup-To: Linda Walsh <lkml@tlinx.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <4451B77D.7070000@tlinx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="chE8DYtGH5bd9Y2b"
Content-Disposition: inline
In-Reply-To: <4451B77D.7070000@tlinx.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--chE8DYtGH5bd9Y2b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-27 23:34:37 -0700, Linda Walsh <lkml@tlinx.org> wrote:
> From "make help", the "O=3D" param to make is said to
>  'Locate all output files in "dir", including .config'
>=20
> I first did:
>    "make O=3D$PWD/root bzImage modules"   # (Note: PWD=3D/usr/src/ast-261=
611)
[...]
> Instead, it appears the "O=3D" parameter is _partially_ ignored.

> ishtar:/usr/src/ast-261611> make V=3D1 O=3D$PWD/root modules_install

The  modules_install  target uses O=3D for its _input_ files (that is,
for the readily compiled modules) and outputs to
$(INSTALL_MOD_PATH)/lib/modules/$VERSION/ .  So you may want to set
$(INSTALL_MOD_PATH) in the same way as you've set V=3D or O=3D before.

If you're trying to prepare something to be copied over to a target
system, the tar-pkg, targz-pkg and tarbz2-pkg targets may be exactly
what you're searching for.

>    Is this a bug or a feature?  I.e. is the "make help" misleading in

Feature. Modules won't ever be searched inside some kernel source
directory, modprobe expects them to be in /lib/modules/.

> saying "O=3D<dir>" can be used to specify the output directory of a
> make run?  Or should this be working?

It's maybe a bit misleading, but `modules_install' isn't a compilation
run, it's an installation run. O=3D was ment to hold all
compiled/generated objects, but to have a working installation, you
need to break out of that (or have INSTALL_MOD_PATH set.)

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

--chE8DYtGH5bd9Y2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEUcsoHb1edYOZ4bsRAjKnAJwKfRc/gNrBLAdnSc+ag+SQReJi+wCeJ8Xa
dXnoNqbXO+y+928IMfpUjUw=
=R6xU
-----END PGP SIGNATURE-----

--chE8DYtGH5bd9Y2b--
