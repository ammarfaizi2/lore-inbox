Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTICOwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTICOwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:52:22 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:12209 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263468AbTICOwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:52:18 -0400
Date: Wed, 3 Sep 2003 16:52:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Driver Model
Message-ID: <20030903145216.GG14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0309021620050.4709@chaos> <002301c37228$bbc89950$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHrxbAcqt/LxKPZN"
Content-Disposition: inline
In-Reply-To: <002301c37228$bbc89950$294b82ce@stuartm>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eHrxbAcqt/LxKPZN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 10:36:16 -0400, Stuart MacDonald <stuartm@connecttech.co=
m>
wrote in message <002301c37228$bbc89950$294b82ce@stuartm>:
> From: linux-kernel-owner@vger.kernel.org=20
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of=20
> > Richard B. Johnson
> > sources are available. If the driver does not contain the appropriate
> > MODULE_LICENSE() string, then several tools will show "tainted" so
>=20
> If the MODULE_LICENSE() macro is what determines taint, what's to
> prevent a company from compiling their driver in their own kernel tree
> with that macro and releasing it binary-only? Wouldn't that module
> then be taint-free?

To use it, you've to call it like

	MODULE_LICENSE("GPL");

The string (license name) you supply is stored into the module binary
and checked ad module load time. Either it's "GPL" (or a few others
IIRC) or it isn't. If it is, the module is GPL and (after you've shipped
the module) any user can legally ask for sources (and you've to ship
them). If it isn't GPL (or the other accepted variants), it'll taint the
kernel. That'll tell us to not look at oopses, though...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--eHrxbAcqt/LxKPZN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VgAgHb1edYOZ4bsRAjL/AKCLiyS/fGwHliSWpOyQloQ0xcew4gCfYIMJ
RhessnyD2v8aNFVL9y+iZ2E=
=xQ/4
-----END PGP SIGNATURE-----

--eHrxbAcqt/LxKPZN--
