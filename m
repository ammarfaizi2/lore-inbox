Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTIGLqv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 07:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTIGLqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 07:46:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:39596 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263017AbTIGLqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 07:46:49 -0400
Date: Sun, 7 Sep 2003 13:46:47 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907114647.GR14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030907112813.GQ14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HIPflPGvV5kKjZ73"
Content-Disposition: inline
In-Reply-To: <20030907112813.GQ14436@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HIPflPGvV5kKjZ73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-09-07 13:28:13 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20030907112813.GQ14436@fs.tum.de>:
> There are two different needs:
> 1. the installation kernel of a distribution should support all CPUs=20
>    this distribution supports (perhaps starting with the 386)

So far, no major distribution does support an i386. Basically, this has
leaked in by some broken patch to libstdc++ which was not observed for a
long time. To support i386, an additional emulator for additional i486
needs to be compiled-in, too. I had a short try to port Debian's patch
into 2.6.x, but it oopsed :-> If I get some time, I'll finish that.
Before we have thie i486-emu-for-i386 in, i386 support in the kernel
doesn't make *any* sense on it's own...

> Changes:
> - changed the i386 CPU selection from a choice to single options for
>   every cpu
> - renamed the M* variables to CPU_*, this is needed to ask the users
>   upgrading from older kernels instead of silently changing the=20
>   semantics
> - AMD Elan is a different subarch, you can't configure a kernel that=20
>   runs on both the AMD Elan and other i386 CPUs

Oh well, the Elan is a beasty thing:) However, I like your overall
approach, though.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--HIPflPGvV5kKjZ73
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/WxqnHb1edYOZ4bsRAtv0AJ4+X1CuJ2WF2aj8ocqXp2zHF5T5XgCeOGaV
S45PGV/9O+eYLbK1obV/yDU=
=V1Dn
-----END PGP SIGNATURE-----

--HIPflPGvV5kKjZ73--
