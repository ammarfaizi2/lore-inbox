Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSCXOYL>; Sun, 24 Mar 2002 09:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCXOYB>; Sun, 24 Mar 2002 09:24:01 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:25314 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S291531AbSCXOXw>; Sun, 24 Mar 2002 09:23:52 -0500
Date: Sun, 24 Mar 2002 09:25:45 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020324142545.GC20703@ufies.org>
Mail-Followup-To: Greg KH <greg@kroah.com>, Robert Love <rml@tech9.net>,
	Andrew Morton <akpm@zip.com.au>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe.ml@online.fr>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org> <20020324080729.GD16785@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2002 at 12:07:29AM -0800, Greg KH wrote:
> On Sat, Mar 23, 2002 at 05:44:33PM -0500, christophe barb=E9 wrote:
> > With the 'everything is module' and 'everything is hotplug' approach in
> > mind (which is a appealing way and IMHO this is the way we are going),
> > I see two part for this problem:
> >=20
> > . Persistence after plug out/plug in=20
> >=20
> > . Persistence after suspend/resume
> >=20
> > The first one is a userland problem. The card identification could be
> > based on the MAC address (for NICs at least, in the case of cardbus the
> > bus position has no real signification). This should then be the
> > responsibility of the userspace tool (hotplug) to indicate the correct
> > option for this card. The problem is when the module is already loaded,
> > the userspace tool has no way to indicate this option.
>=20
> Untrue.  See
> 	http://www.kroah.com/linux/hotplug/ols_2001_hotplug_talk/html/mgp00014.h=
tml
> for a 6 line version of /sbin/hotplug that always assigns the same
> "ethX" value to the same MAC address.  I think the patch to nameif has
> gone in to support this, but I'm not sure.

Untrue what ? The persistence after plug out/in ?
The problem here is not to give the same interface to a given NIC. The
problem is to give the same options to a given NIC. But a solution can
simply be to set the option from hotplug using the proc interface. The
3c59x doesn't support that for wol but that can be changed.

> And why is there a limitation of only 8 devices?  Why not do what all
> USB drivers do, and just create the structure that you need to use at
> probe() time, and destroy it at remove() time?

This is an implementation issue which is not really important. It comes
from Donald Becker. Your dynamic structure doesn't solve the problem
'which options for which cards', does it ?=20

> Just my $0.02
>=20
> thanks,
>=20
> greg k-h

Thanks,
Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There's no sense in being precise when you don't even know what you're
talking about. -- John von Neumann

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8neHpj0UvHtcstB4RAirIAJ4yKOQImbsb8wizgHGFp1+qLrGoNgCgh7g6
5zf9uoj1j0ZHSIyRWt4yO/E=
=vjZF
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
