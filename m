Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312555AbSCYURI>; Mon, 25 Mar 2002 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312547AbSCYURF>; Mon, 25 Mar 2002 15:17:05 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:38286 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312543AbSCYUQy>; Mon, 25 Mar 2002 15:16:54 -0500
Date: Mon, 25 Mar 2002 15:16:48 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020325201648.GH1853@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1016914030.949.20.camel@phantasy> <Pine.LNX.3.96.1020325143511.4219B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 02:44:31PM -0500, Bill Davidsen wrote:
> On 23 Mar 2002, Robert Love wrote:
>=20
> > Ideally we'd have a dynamically created array for the cards and hash
> > into that, but, ugh, this is getting gross especially since 99% of us
> > have one card and never remove it.
>=20
>   To address the problem of running out of id's, a bitmap of "id's in use"
> could be used, and number recycled. This is done infrequently and overhead
> is hardly a problem, although getting things released at suspect may be.

I agree but I believe this is not the real issue.

>   Getting the right options on the right card and the right card on the
> expected number is another problem. I fight that all the time on my
> laptop, with one NIC in the laptop and one in the dock. In spite of clear
> information in modules.conf giving which driver goes with each NIC (via
> alias), I don't get eth1 with no eth0 as I want, the first one is always
> eth0, loads the wrong driver when not docked, and then doesn't get
> initialized right by the startup scripts.
>=20
>   I also have another NIC I put in a pcmcia slot to become a router on
> occasion, that also gets a random NIC number. Unfortunately it doesn't
> look like a trivial job to use the info in modules.conf to fix the general
> random numbering. The modules.conf interface seems to work in the wrong
> direction, what I think we want is "when you load this driver use this
> name", so eth2 could be the only NIC in the system under some conditions.

This is a subset of the problem I try to explain.=20
In this case Greg has posted a nice solution a few mails ago (using a
userland tool called ifname IIRC).

Christophe

>=20
> --=20
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
>=20
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

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8n4Wvj0UvHtcstB4RAs38AJwL1Ie8gIQj0lXxf+CSwlukGfVnDQCfWprn
xXcUe5qAYxl6Jglpw1Ve8rI=
=DHYf
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
