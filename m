Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUETSQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUETSQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUETSQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 14:16:20 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53685 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265170AbUETSQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 14:16:18 -0400
Date: Thu, 20 May 2004 20:16:17 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: No forces rebuild while changing GCC?
Message-ID: <20040520181617.GE1912@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YP2B4AbOrhUAD2Gr"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YP2B4AbOrhUAD2Gr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently playing with patches for gcc HEAD to build a vax-linux
cross-compiler. For testing it, I first want to build parts of the
kernel with my HEAD toolchain, Ctrl-C, and continue/finish building with
my old compiler (2.95.2).

I do changing gcc by putting one or the other gcc into $PATH. However,
whenever I change GCC, kbuild decides to rebuild everything.

I tried to not overwrite compile.h (my commenting out the mv command in
scripts/mkcompile_h), but that didn't help either. I even tried
recompiling my HEAD gcc with exactly the same version string that my old
gcc had, but that didn't work either:(

How can I force to keep my old .o files?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--YP2B4AbOrhUAD2Gr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArPXxHb1edYOZ4bsRAsNBAJwKOIXeLp9FQbsGb5hyMSDJGlLAQgCgklmm
uiZlQ8MaOCZLMRpI3QOsrWA=
=IQix
-----END PGP SIGNATURE-----

--YP2B4AbOrhUAD2Gr--
