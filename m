Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUKMWWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUKMWWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUKMWWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:22:11 -0500
Received: from ctb-mesg5.saix.net ([196.25.240.77]:41690 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261189AbUKMWWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:22:07 -0500
Subject: Re: 2.6.10-rc1-mm5 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041113132232.5c201000.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <1100368553.12239.3.camel@nosferatu.lan>
	 <1100380593.12663.1.camel@nosferatu.lan>
	 <20041113132232.5c201000.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3/f9JdZ4hHG9afBGn5bX"
Date: Sun, 14 Nov 2004 00:22:13 +0200
Message-Id: <1100384533.12195.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3/f9JdZ4hHG9afBGn5bX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-11-13 at 13:22 -0800, Andrew Morton wrote:
> "Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
> >
> > > I want to imagine there is some reason why some threading apps will h=
ave
> >  > issues?  I have since rc1-mm4 issues with evolution - some threads d=
o
> >  > not seem to come out of sleep or get running time for some reason.
> >  > Unfortunately I cannot find the thread again.  Is there a patch I ca=
n
> >  > apply/revert to get it to work for now?
> >  >=20
> >=20
> >  I should note that if I killall -STOP and then killall -CONT all
> >  evolution processes (evolution-data-server-1.0, evolution-alarm-notify
> >  and evolution-2.0) it works again for a while.  The issue happens pret=
ty
> >  quick after I start evo ...
>=20
> Could you please try:
>=20
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10=
-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
> patch -R -p1 < futex_wait-fix.patch
>=20
> the retest?

Yep, this seems to fix it (usually one thread at least have already hung
at start for evo, now fine after a few mail fetches).

Is this a regression, or as in the other thread an issue with evolution
that should be fixed ?  (Note:  gnome-btdownload also seemed to hang
overnight with -mm[45], but I do not know if its related)


Thanks,

--=20
Martin Schlemmer


--=-3/f9JdZ4hHG9afBGn5bX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBlokVqburzKaJYLYRApocAJ9VtmByBYG6jt5uQZTzsVCDV6vZeACdFbm6
f6SaLtxgCw6EH0vdivDoR7g=
=bzmc
-----END PGP SIGNATURE-----

--=-3/f9JdZ4hHG9afBGn5bX--

