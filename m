Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSJ3P0j>; Wed, 30 Oct 2002 10:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264708AbSJ3P0j>; Wed, 30 Oct 2002 10:26:39 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:25608 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S264699AbSJ3P0i>;
	Wed, 30 Oct 2002 10:26:38 -0500
Date: Wed, 30 Oct 2002 10:32:57 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021030153257.GA27585@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
References: <20021027010538.GA1690@babylon.d2dc.net> <20021028184008.B32183@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20021028184008.B32183@ucw.cz>
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2002 at 06:40:08PM +0100, Vojtech Pavlik wrote:
> On Sat, Oct 26, 2002 at 09:05:38PM -0400, Zephaniah E. Hull wrote:
> > To make a long story short, mousedev.c does not properly implement the
> > EXPS/2 protocol, specificly dealing with the wheel.
> >=20
> > The lower 8 bits of the 4th byte are supposed to be 0x1 or 0xf to
> > indicate movement of the first wheel, and 0x2 or 0xe for the second
> > wheel.
>=20
> No, see microsoft documentation. They're expected to be a 4-bit signed
> binary complement value that indicates the amount of movement.

After some poking, two questions.

The first is the URL for the documentation in question? This seems
inconsistent with what I remember reading in the past, but can't seem to
find anymore.

The second is if you have actually seen hardware which /actually/
generates the wheel data described while speaking exps2?
>=20
> > Attached is a patch to correct this.
> >=20
> > This does not get my two wheel mouse working perfectly yet, sadly that
> > will take a bit of a hack, and I'm not sure where the best place to put
> > it is yet, but this gets it back to generating correct data.
>=20
> PS/2 A4-Tech mouse do the ugly trick you describe above to stuff two
> wheel information into a single-wheel oriented ImExPS/2 protocol. USB
> A4-Tech mouse do another ugly trick (additional button which specifies
> which wheel is rotating). I'm not interested in supporting these ugly
> tricks.

Sadly, if PS/2 mice are any indication, mouse makers /will/ manage to
fuck things up on enough popular mice under USB as well, and there needs
to be a place to shove the dirty hacks needed to make things Just Work
for users..

At least with USB stuff we can /identify/ the damn things, which means
that we are leaps and bounds ahead of where we are for PS2 stuff.
>=20
> If you want to support the H-Wheel in GPM, then please add
> /dev/input/event support into GPM. (simple patch attached, you may need
> to do more changes, namely for h-wheel).

Thanks, my next gpm upload should include it, now to get support for the
same for X.. (Arrgh, X hacking is even lower on my list of things to do
then kernel hacking is. Probably because I've done more of it.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Has anyone got a reference cynic? I think I need to recalibrate myself.
  -- James Riden in the SDM.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9v/upRFMAi+ZaeAERAiG/AKDwJSHi0yM8NYbbm1KUUycNXWq2VwCdHFdU
99MiE/tBDLUJIdgS4kSSuVc=
=fmm1
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
