Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292398AbSBYXd7>; Mon, 25 Feb 2002 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSBYXdp>; Mon, 25 Feb 2002 18:33:45 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:16318 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S292398AbSBYXct>; Mon, 25 Feb 2002 18:32:49 -0500
Date: Mon, 25 Feb 2002 18:32:42 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume and 3c59x
Message-ID: <20020225233242.GA5370@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020225200056.GW12719@ufies.org> <3C7A9C75.F6A4BA05@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <3C7A9C75.F6A4BA05@zip.com.au>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank Andrew.
My problem is solved with 2.4.18 and 'options 3c59x enable_wol=3D1'.

Christophe

On Mon, Feb 25, 2002 at 12:20:05PM -0800, Andrew Morton wrote:
> christophe barb=E9 wrote:
> >=20
> > Hi,
> >=20
> > I use the kernel 2.4.17 and the hotplug facilities for my 3com cardbus
> > (driver 3c59x). It works well when I insert and remove the card.
> > But If I don't remove the card before suspending (apm -s) my laptop,
> > The card is in a bad state when I resume the laptop and I need to remove
> > and insert the card to get it back. I have tried to ifdown and rmmod
> > before suspending but the result is the same.
> >=20
>=20
> Did you provide the `enable_wol=3D1' module parameter?
>=20
> 	options 3c59x enable_wol=3D1
>=20
> Despite its name, this turns on some power management
> functionality.  Should have been a separate "enable_pm".
>=20
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats seem go on the principle that it never does any harm to ask for
what you want. --Joseph Wood Krutch

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8esmaj0UvHtcstB4RAprIAJ92wlVdbD+jS/7jZJXRckP9fxR5igCfRJXn
elNUDLhwIlgVwCYvwsPueXk=
=dNuK
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
