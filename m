Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291193AbSBZQ7V>; Tue, 26 Feb 2002 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291269AbSBZQ7O>; Tue, 26 Feb 2002 11:59:14 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:41098 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S291193AbSBZQ7A>; Tue, 26 Feb 2002 11:59:00 -0500
Date: Tue, 26 Feb 2002 11:58:50 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: suspend/resume and 3c59x
Message-ID: <20020226165850.GC803@ufies.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020225200056.GW12719@ufies.org> <3C7A9C75.F6A4BA05@zip.com.au> <3C7A9C75.F6A4BA05@zip.com.au> <20020225233242.GA5370@ufies.org> <3C7AD0AC.13A554DA@zip.com.au> <20020227001144.328c210c.sfr@canb.auug.org.au> <20020226151304.GA803@ufies.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <20020226151304.GA803@ufies.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I am trying to understand where is the problem.
One thing I'm sure right now is that the 3c59x as a problem.
After a card remove/insert cycle the option enable_wol is no more
enabled.

Christophe

On Tue, Feb 26, 2002 at 10:13:04AM -0500, christophe barb=E9 wrote:
> On Wed, Feb 27, 2002 at 12:11:44AM +1100, Stephen Rothwell wrote:
> > On Mon, 25 Feb 2002 16:02:52 -0800 Andrew Morton <akpm@zip.com.au> wrot=
e:
> > >
> > > Just for the record: Both Christophe's 3c<mumble> and my 3c556B
> > > mini-PCI NIC failed to survive APM resumes in 2.4.17.  But something
> > > outside the 3c59x driver got fixed somewhere in the 2.4.18-pre series,
> > > and resume works OK in 2.4.18.
> >=20
> > We now notify (and wait for a response from) user mode processes about
> > the pending suspend BEFORE we notify the drivers.  We used to do this t=
he
> > other way around (which was never correct - mea culpa).
> >=20
> > This MAY have changed the behaviour of the drivers ...
>=20
> Unfortunately after a few experiments my 3c59x does not resume correctly
> with 2.4.18. I don't understand why but sometimes it takes a few seconds
> to return in a good state after a suspend/resume cycle and sometimes (at
> least one time) the card stay in a bad state.
>=20
> Would it be possible that the driver is never notified that the machine
> is going in a suspend mode ?=20
> When you said 'we now notify ...' the 'we' stand for apm ?
>=20
> Looking in the driver, the enable_wol (now I know that wol means Wake up
> on Lan, and I would prefer let this option disabled but it also turn on
> pm stuff as Andrew told me) enables few acpi call.
>=20
> Andrew : Is your card back immediately after resuming ?
>=20
> Christophe
>=20
>=20
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell                    sfr@canb.auug.org.au
> > http://www.canb.auug.org.au/~sfr/
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
> --=20
> Christophe Barb=E9 <christophe.barbe@ufies.org>
> GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
>=20
> Thousands of years ago, cats were worshipped as gods.
> Cats have never forgotten this. --Anonymous



--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Thousands of years ago, cats were worshipped as gods.
Cats have never forgotten this. --Anonymous

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8e77Kj0UvHtcstB4RAj0UAJ9mHBY0ZA7w53I/6JlFbBIZTq/JeACeI3IZ
z0wBvADd8wSCb5BfTaW5KYA=
=ZGvM
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
