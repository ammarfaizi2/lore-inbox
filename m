Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270109AbTGaPgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274814AbTGaPes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:34:48 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48018 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S274822AbTGaPdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:33:38 -0400
Date: Thu, 31 Jul 2003 17:33:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
Message-ID: <20030731153337.GB1873@lug-owl.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local> <20030731113838.GU1873@lug-owl.de> <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk> <20030731121448.GW1873@lug-owl.de> <20030731130130.GY1873@lug-owl.de> <1059664158.5031.26.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XINLVIUB+MD9CVAm"
Content-Disposition: inline
In-Reply-To: <1059664158.5031.26.camel@workshop.saharacpt.lan>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XINLVIUB+MD9CVAm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 17:09:19 +0200, Martin Schlemmer <azarah@gentoo.org>
wrote in message <1059664158.5031.26.camel@workshop.saharacpt.lan>:
> On Thu, 2003-07-31 at 15:01, Jan-Benedict Glaw wrote:
> > On Thu, 2003-07-31 14:14:48 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
> > wrote in message <20030731121448.GW1873@lug-owl.de>:
> > > On Thu, 2003-07-31 12:51:09 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > wrote in message <1059652268.16608.8.camel@dhcp22.swansea.linux.org.u=
k>:
> > > > On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> > So there we are. Thanks to someone who pointed me to LD_DEBUG et al., I
> > see that my _init() is called too late:
> >=20
> > amtus:~/sigill_catcher# LD_DEBUG=3Dall LD_VERBOSE=3D1
> > LD_PRELOAD=3D./libsigill.so apt-get update 2> ld_infos                 =
               =20
> > Illegal instruction
> > amtus:~/sigill_catcher# grep 'calling init' ld_infos=20
> > 00691:  calling init: /lib/libc.so.6
> > 00691:  calling init: /lib/libdl.so.2
> > 00691:  calling init: /lib/libgcc_s.so.1
> > 00691:  calling init: /lib/libm.so.6
> > 00691:  calling init: /usr/lib/libstdc++.so.5
> >=20
> > As I guessed, libstdc++5's _init() is called before mine (LD_PRELOADed)
> > _init() function and thus, I cannot intercept this SIGILL, as it
> > seems...
> >=20
>=20
> You could do what we do with our path sandbox - basically you
> use a wrapper that setup the environment (prob not needed in
> your case), and then spawn bash with our sandbox lib preloaded,
> which then calls whatever should be 'path sandboxed'.

Care to send some URL? I haven't found it ad hoc by Google...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--XINLVIUB+MD9CVAm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KTbRHb1edYOZ4bsRAgrWAJ9n15FwmkMJQiKZ0jpTt7f+Vb0JAACcD+Nr
XYoWsq501cjDj0Ktli9xb20=
=RHKg
-----END PGP SIGNATURE-----

--XINLVIUB+MD9CVAm--
