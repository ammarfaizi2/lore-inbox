Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVKDVgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVKDVgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVKDVgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:36:19 -0500
Received: from ctb-mesg9.saix.net ([196.25.240.89]:49604 "EHLO
	ctb-mesg9.saix.net") by vger.kernel.org with ESMTP id S1750930AbVKDVgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:36:18 -0500
Subject: Re: initramfs for /dev/console with udev?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Rob Landley <rob@landley.net>
Cc: Roland Dreier <rolandd@cisco.com>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511031529.59529.rob@landley.net>
References: <20051102222030.GP23316@pengutronix.de>
	 <200511031313.47820.rob@landley.net> <52mzkl4i8y.fsf@cisco.com>
	 <200511031529.59529.rob@landley.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Kj3d4vISLT3m2krov14C"
Date: Fri, 04 Nov 2005 23:39:10 +0200
Message-Id: <1131140350.9669.7.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kj3d4vISLT3m2krov14C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-11-03 at 15:29 -0600, Rob Landley wrote:
> On Thursday 03 November 2005 13:57, Roland Dreier wrote:
> >  > On Thursday 03 November 2005 12:51, Robert Schwebel wrote:
> >  > > [...] klibc didn't compile for ARCH=3Dum.
> >  >
> >  > I repeat my question: what is it that didn't compile, klibc or the
> >  > kernel?
> >
> > come on, dude -- how much clearer can he be?
>=20
> Ah, I see.  The linux kernel headers you feed it were from a kernel compi=
led=20
> with ARCH=3Dum.  Right.  It's been a while since I tried feeding any libc=
=20
> actual kernel headers.  (I build uClibc against the cleaned up userspace =
ones=20
> here: http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ .)
>=20
> It's also been a while since I played with klibc, and I notice that it do=
esn't=20
> work with Maszur's headers.  (It sort of works, with lots of warnings, un=
til=20
> about halfway through when it wants to touch "asm/signal.h", when Maszur'=
s=20
> just has linux/signal.h, and symlinking the two still isn't happy because=
=20
> sigset_t is never defined...  In klibc there's definitions for ia64, spar=
c,=20
> and parisc.  But nothing for x86...
>=20
> Ok, checking 2.6.14/include/asm-i386 it's an unsigned long, so typedef th=
at... =20
> Nope, still not happy, wants numerous other symbols now...  Okay, try=20
> grabbing asm-i386/signal.h from libc...  And asm-generic/signal.h which=20
> _that_ includes...  And now there's a "previous declaration of 'wait3"'=20
> conflicting.  Beautiful...)
>=20
> Ok, I remember why I stopped playing with klibc now.  It's still deep in=20
> alpha-test stage, requires way more incestuous knowledge of the kernel=20
> headers than anything not bundled with the kernel itself has any excuse f=
or,=20
> and I'm still not sure what advantage it claims to have over uClibc excep=
t=20
> for being BSD licensed.
>=20

Well, apparently the plan is to eventually bundle it with the kernel if
not mistaken.  Also, it have seen a stable release, and it works well
for what it was intended for, and still have a less footprint than
uClibc if space is really an issue.

> If you have to make it work, I'd suggest extracting a fresh kernel tarbal=
l, do=20
> "make allyesconfig" (without ARCH=3Dum), and use _those_ headers.  Or jus=
t=20
> accept that it doesn't work and try uClibc. :)
>=20

It does work, just need to be fixed up for ARCH=3Dum compiled kernel.  I
did a quick hack to do this, but HPA don't like it (and I do not blame
him).  Can be found here:

http://bugs.gentoo.org/attachment.cgi?id=3D67478


--=20
Martin Schlemmer


--=-Kj3d4vISLT3m2krov14C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDa9T+qburzKaJYLYRAqLOAJ9n6FJnDHau5keT8W55MCJHxAhJVgCfYojf
ugNiloeVZYjKEMuZvsdWfU0=
=EIeu
-----END PGP SIGNATURE-----

--=-Kj3d4vISLT3m2krov14C--

