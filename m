Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWBBOqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWBBOqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBBOqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:46:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751100AbWBBOqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:46:51 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138842612.6632.30.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
	 <1138830694.18762.46.camel@localhost.localdomain>
	 <1138832179.6632.12.camel@localhost.localdomain>
	 <1138833380.18762.67.camel@localhost.localdomain>
	 <1138842612.6632.30.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TyUL/ERIg8LA0HMu4afN"
Date: Thu, 02 Feb 2006 08:46:24 -0600
Message-Id: <1138891584.3168.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TyUL/ERIg8LA0HMu4afN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-01 at 20:10 -0500, Steven Rostedt wrote:
> On Wed, 2006-02-01 at 16:36 -0600, Clark Williams wrote:
> >=20
> > Ok, I took the config file I sent you, globally substituted '=3Dy' for
> > '=3Dm' and rebuilt, then booted that kernel. Other than a message that =
it
> > was unable to open the console (udev wasn't started) I got the exact
> > same failure (same panic backtrace).
>=20
> Thanks for the clarification.

Just trying to make sure we're all on the same page.

> >=20
> > Hmmm, FC4 is based on 2.6.14.x. Did something change in the 2.6.15
> > series that needs a user-space change as well? (I'm running a current
> > FC4 rootfs).
>=20
> But, didn't you say that if you turn off LATENCY_TRACING that the -rt
> patched kernel boots?

Gah. I'm an idiot. I wrote that last night as I was about to leave, then
just before going to bed I realized that it couldn't be a user-space
issue, since other kernel's work just fine. Put it down to
frustration :)

>=20
> So, now it seems to be something hardware specific that is different
> between your machine and mine.

Yeah, I suspect so. I still have a nagging suspicion that something
about how memory has been setup is confusing ld.so while it tries to map
in the various sections of a dynamically linked executable.=20

Hmmm, it just occurred to me that it might be while ld.so is mapping in
dependent libraries, not while mapping file sections. Think I'll go poke
at that a little.

Clark

--=20
Clark Williams <williams@redhat.com>

--=-TyUL/ERIg8LA0HMu4afN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4htAHyuj/+TTEp0RAqviAKDHmBXmFhpzjO+CivsIilBAwC5T2ACfTQVz
lnqCYz57OKTa/5JKCAbT0bQ=
=ew76
-----END PGP SIGNATURE-----

--=-TyUL/ERIg8LA0HMu4afN--

