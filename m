Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272248AbTG3U2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272232AbTG3U2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:28:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25533 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272248AbTG3U2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:28:23 -0400
Date: Wed, 30 Jul 2003 22:28:22 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730202822.GG1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jch8HTrQBXCJArxs"
Content-Disposition: inline
In-Reply-To: <20030730184529.GE21734@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Jch8HTrQBXCJArxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-07-30 20:45:29 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20030730184529.GE21734@fs.tum.de>:
> On Wed, Jul 30, 2003 at 11:30:33AM -0700, Mike Fedyk wrote:
> > On Wed, Jul 30, 2003 at 08:10:06PM +0200, Adrian Bunk wrote:
> > > On Wed, Jul 30, 2003 at 03:56:23PM +0200, Jan-Benedict Glaw wrote:
> > > > Please apply. Worst to say, even Debian seems to start using i486+
> > > > features (ie. libstdc++5 is SIGILLed on Am386 because there's no
> > > > "lock" insn available)...
> > >=20
> > > Shouldn't the 486 emulation in the latest 386 kernel images in Debian
> > > unstable take care of this?
> >=20
> > What emulation?
>=20
> 486 emulation
> CONFIG_CPU_EMU486
>   When used on a 386, Linux can emulate 3 instructions from the 486 set.
>   This allows user space programs compiled for 486 to run on a 386
>   without crashing with a SIGILL. As any emulation, performance will be
>  very low, but since these instruction are not often used, this might
>   not hurt.  The emulated instructions are:
>      - bswap (does the same as htonl())
>      - cmpxchg (used in multi-threading, mutex locking)
>      - xadd (rarely used)

libstdc++ (and it's main user, apt-get) break at a LOCK insn.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--Jch8HTrQBXCJArxs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KCpmHb1edYOZ4bsRAvZrAJ902D003r4XaYnjqDm0+7ZMzhLSFACeLskI
/3kSR5dPFGqPoFvyzEVhWkw=
=qDbR
-----END PGP SIGNATURE-----

--Jch8HTrQBXCJArxs--
