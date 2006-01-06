Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWAFL1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWAFL1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAFL1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:27:20 -0500
Received: from mout1.freenet.de ([194.97.50.132]:20661 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932172AbWAFL1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:27:19 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 5/7]  uninline capable()
Date: Fri, 6 Jan 2006 12:26:42 +0100
User-Agent: KMail/1.8.3
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <200601061218.17369.mbuesch@freenet.de> <1136546539.2940.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1136546539.2940.28.camel@laptopd505.fenrus.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1529441.hi6Q4h91rG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601061226.42416.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1529441.hi6Q4h91rG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 06 January 2006 12:22, you wrote:
> On Fri, 2006-01-06 at 12:18 +0100, Michael Buesch wrote:
> > On Friday 06 January 2006 11:42, you wrote:
> > > Index: linux-2.6.15/include/linux/sched.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-2.6.15.orig/include/linux/sched.h
> > > +++ linux-2.6.15/include/linux/sched.h
> > > @@ -1102,19 +1102,8 @@ static inline int sas_ss_flags(unsigned=20
> > >  }
> > > =20
> > > =20
> > > -#ifdef CONFIG_SECURITY
> > > -/* code is in security.c */
> > > +/* code is in security.c or kernel/sys.c if !SECURITY */
> > >  extern int capable(int cap);
> >=20
> > BTW, is there a special reason why this is declared in sched.h
> > instead of capability.h?
>=20
> probably a lot of historic bagage... anyway not something that should be
> cleaned up as part of this series, could maybe be done in another patch
> if you feel so inclined :)

Oh, well I have more important work to do now. :)
I am sure there are enough people around on this mailing list
waiting for such work... hint hint :)

=2D-=20
Greetings Michael.

--nextPart1529441.hi6Q4h91rG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDvlPylb09HEdWDKgRAvw5AJoDbTsJtqqI2Eisbj4ZJxMxB4Fm1wCbBEVz
XUFJkP4xAU6xjHZV5yOj0OU=
=PTRS
-----END PGP SIGNATURE-----

--nextPart1529441.hi6Q4h91rG--
