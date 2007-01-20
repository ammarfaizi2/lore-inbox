Return-Path: <linux-kernel-owner+w=401wt.eu-S965405AbXATWLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405AbXATWLt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 17:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965406AbXATWLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 17:11:49 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:34241 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965405AbXATWLs (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 17:11:48 -0500
Subject: Re: SATA exceptions with 2.6.20-rc5
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Robert Hancock <hancockr@shaw.ca>, Linux-kernel@vger.kernel.org,
       jeff@garzik.org, B.Steinbrink@gmx.de, chunkeey@web.de
In-Reply-To: <200701202143.31256.s0348365@sms.ed.ac.uk>
References: <1169305408.4199.3.camel@pi.pomac.com>
	 <45B2748B.4060106@shaw.ca>  <200701202143.31256.s0348365@sms.ed.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YHGbWoUDe0XxyTpia7OZ"
Date: Sat, 20 Jan 2007 23:11:40 +0100
Message-Id: <1169331103.4199.12.camel@pi.pomac.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YHGbWoUDe0XxyTpia7OZ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On l=C3=B6r, 2007-01-20 at 21:43 +0000, Alistair John Strachan wrote:
> On Saturday 20 January 2007 19:59, Robert Hancock wrote:
> > Ian Kumlien wrote:
> > > Hi,
> > >
> > > I went from 2.6.19+sata_nv-adma-ncq-v7.patch, with no problems and ad=
ama
> > > enabled, to 2.6.20-rc5, which gave me problems almost instantly.
> > >
> > > I just thought that it might be interesting to know that it DID work
> > > nicely.
> > >
> > > CC since i'm not on the ml
> >
> > (I'm ccing more of the people who reported this)
> >
> > Well that's interesting.. The only significant change that went into
> > 2.6.20-rc5 in that driver that wasn't in that version you mentioned was
> > this one:
> >
> > http://www2.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git=
;a=3Dcom
> >mit;h=3D2dec7555e6bf2772749113ea0ad454fcdb8cf861
> >
> > Could you (or anyone else) test what happens if you take the 2.6.20-rc5
> > version of sata_nv.c and try it on 2.6.19? That would tell us whether
> > it's this change or whether it's something else (i.e. in libata core).
>=20
> I'm still running an -rc5 kernel with ADMA switched off entirely and I ca=
n't=20
> reproduce the problem. How is everybody else reproducing this?
>=20
> I've been successful installing bonnie++, then going to a large XFS parti=
tion=20
> and running "bonnie++ -u 1000:1000" and letting it run through, all defau=
lts.
>=20
> It doesn't cause the problem I was seeing in -rc5 with ADMA on, when I sw=
itch=20
> ADMA off, so I think this is sufficient to fix it.

Eh? The whole point with that patch was to ADD ADMA support to sata_nv,
imho that is something we want to have and i have been running with ADMA
on on two computers since sata_nv-adma-ncq-v4 or 5 or so without
problems.

So, something has been introduced or been broken to cause this error,
wouldn't it be better to find the error introduced than to just totally
negate the patch in the first place?

I haven't had the energy to go trough the patch that was found as
causing the problem yet... I don't know if i even have all the info
needed to make any form of educated guess but i'll give it a try when i
have the energy.

I really home someone finds it before then =3D)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-YHGbWoUDe0XxyTpia7OZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBFspOc7F3Euyc51N8RAs9KAJ4qCHv+o4LF2rhpAu9hkZC2tTyz4QCfQF1P
9aQ/sNCccGLfOGqlSbOI9zI=
=DZ1M
-----END PGP SIGNATURE-----

--=-YHGbWoUDe0XxyTpia7OZ--
