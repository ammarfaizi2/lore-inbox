Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTHGQFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTHGQCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:02:32 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:8887 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S270416AbTHGQBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:01:39 -0400
Date: Thu, 7 Aug 2003 09:01:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Pool <mbp@sourcefrog.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] [Kconfig] disable GEN_RTC on ia-64
Message-ID: <20030807160136.GC579@ip68-0-152-218.tc.ph.cox.net>
References: <20030806074312.GT22302@vexed.ozlabs.hp.com> <20030806163753.GB579@ip68-0-152-218.tc.ph.cox.net> <pan.2003.08.07.01.18.20.270606@sourcefrog.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <pan.2003.08.07.01.18.20.270606@sourcefrog.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2003 at 11:18:25AM +1000, Martin Pool wrote:
> On Wed, 06 Aug 2003 09:37:53 -0700, Tom Rini wrote:
>=20
> > I think that this is the wrong approach.  genrtc allows the platform to
> > specify how the rtc is to be accessed.  Therefore, efirtc.c could quite
> > probably be removed in favor of genrtc.c, if the proper read/write
> > functions are provided, and if genrtc gets alarm code, which is somethi=
ng
> > others (rmk at least) have asked for.
>=20
> Yes, since EFI is the only method for this platform it should probably
> be the platform's only implementation of genrtc.
>=20
> At the moment it is a bit confusing because "generic RTC" sounds like
> something that ought to work on any platform, when of course it does
> not.  So if the changes to genrtc would be large, perhaps it would be
> better to just fix Kconfig for now...

Well, it's a "generic RTC" driver because it lets the arch decide the
arch-specific things, like how to access an RTC.  It really should be
able to work on any arch that has an RTC.

> Do you think a patch to refactor efirtc into genrtc would be accepted?

I don't know the EFI code as well as you do, but after skimming it I'm
lost as to what would need to be added to the genrtc driver, other than
alarm support (which is greatly wanted!).

--=20
Tom Rini
http://gate.crashing.org/~trini/

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MnfgdZngf2G4WwMRAuqBAJ41I6EjztsPzE3xnJo7E7mL+RqSjgCeMJdL
Zeud4NfhNUOZHxI+fKGo4yM=
=a28U
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
