Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUFUW3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUFUW3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFUW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:29:48 -0400
Received: from wblv-246-169.telkomadsl.co.za ([165.165.246.169]:13241 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266491AbUFUW3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:29:45 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040621223344.GD2903@mars.ravnborg.org>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <20040620220319.GA10407@mars.ravnborg.org>
	 <1087769761.14794.69.camel@nosferatu.lan>
	 <200406202326.54354.s0348365@sms.ed.ac.uk>
	 <20040621223344.GD2903@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AjCx12Mboqm+qE0TtlUK"
Message-Id: <1087856948.9639.33.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 00:29:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AjCx12Mboqm+qE0TtlUK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-22 at 00:33, Sam Ravnborg wrote:
> On Sun, Jun 20, 2004 at 11:26:54PM +0100, Alistair John Strachan wrote:

> > Sam's point is that unless you ask KBUILD to put the kernel build in a=20
> > separate directory to its sources (this is not the default=20
> > behaviour), /lib/modules/`uname -r`/build will still point to the mixtu=
re of=20
> > source and build data, therefore no breakage will occur.
>=20
> Correct!
>=20

> > Sam, maybe if there was a way to easily detect whether a kernel had bee=
n build=20
> > with or without a different output directory, it would be easier to hav=
e=20
> > vendors take this change on board. For example, I imagine in the typica=
l case=20
> > whereby no change in build directory is made, you will have something l=
ike=20
> > this:
> >=20
> > /lib/modules/2.6.7/build -> /home/alistair/linux-2.6
> > /lib/modules/2.6.7/source -> /home/alistair/linux-2.6
> >=20
> > Whereas when O is given, it will instead be like this:
> >=20
> > /lib/modules/2.6.7/build -> /home/alistair/my-dir
> > /lib/modules/2.6.7/source -> /home/alistair/linux-2.6
> >=20
> > I presume that checking for the existence of /lib/modules/`uname -r`/so=
urce=20
> > will be enough.
> >=20
> > #
> > # where's the kernel source?
> > #
> >=20
> > if [ -d /lib/modules/`uname -r`/source ]; then
> > 	# 2.6.8 and newer
> > 	KERNDIR=3D"/lib/modules/`uname -r`/source"
> > else
> > 	# pre 2.6.8 kernels
> > 	KERNDIR=3D"/lib/modules/`uname -r`/build"
> > fi
>=20
> Look ok.
>=20

Yeah, understood, and already seen as the solution.

I guess I just wanted to try and prevent breakage to _existing_
projects, and the need for another hack to try and figure out
how to build for 2.6 (2.6 has been a bumpy ride in external
module building regards =3D).

But I guess it will not happen, so rather now then much later
when 2.6 is in much wider use ... :-)


Thanks,

--=20
Martin Schlemmer

--=-AjCx12Mboqm+qE0TtlUK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA12E0qburzKaJYLYRAgrEAJwKUN9K2yxJoZX4xVFvCCj39ocTdgCeJbJj
jfkCFwOrlJrwRC/7p3AJ6y4=
=yQYS
-----END PGP SIGNATURE-----

--=-AjCx12Mboqm+qE0TtlUK--

