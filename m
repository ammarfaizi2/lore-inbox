Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUFJT0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUFJT0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUFJT0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:26:36 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:1982 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262459AbUFJTYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:24:31 -0400
Date: Thu, 10 Jun 2004 21:24:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Spinlock-timeout
Message-ID: <20040610192430.GJ20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com> <20040605205117.GD20632@lug-owl.de> <1086893091.3476.37.camel@dyn95394175.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ppjeYEm66epECm6Y"
Content-Disposition: inline
In-Reply-To: <1086893091.3476.37.camel@dyn95394175.austin.ibm.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ppjeYEm66epECm6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-10 13:44:52 -0500, Jake Moilanen <moilanen@austin.ibm.com>
wrote in message <1086893091.3476.37.camel@dyn95394175.austin.ibm.com>:
> On Sat, 2004-06-05 at 15:51, Jan-Benedict Glaw wrote:
> > On Sat, 2004-06-05 15:31:26 -0500, Jake Moilanen <moilanen@austin.ibm.c=
om>
> > wrote in message <1086467486.20906.59.camel@dhcp-client215.upt.austin.i=
bm.com>:
> > > Here's a patch that will BUG() when a spinlock is held for longer the=
n X
> > > seconds.  It is useful for catching deadlocks since not all archs hav=
e a
> > > NMI watchdog. =20
> > I like the idea. However, I don't like touching all arch's Kconfig
> > files. I think it's better to either put this into ./lib/Kconfig (well,
> > doesn't really fit there), ot (even better:) put it into the Debug
> > Kconfig file.
>=20
> I think you're right that lib/Kconfig would not be the right place, but
> I don't think there is a debug Kconfig.  I tried keeping the Kconfig

Not yet:) Somebody is working towards getting all the different debug
options into a central Kconfig file. This was on LKML some four weeks
ago...

> additions w/ CONFIG_DEBUG_SPINLOCK.  The other option is to make a debug
> Kconfig, but every arch seems pretty different in what they have for
> their debug section.

As I said, it's been worked on:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--ppjeYEm66epECm6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyLVuHb1edYOZ4bsRAkz+AJ9D8JclZmrt5LoZV+21iFIUPymZlQCfUEJR
FtoIG9gDRjMfG8dAtR7kCko=
=YKir
-----END PGP SIGNATURE-----

--ppjeYEm66epECm6Y--
