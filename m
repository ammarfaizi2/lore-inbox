Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUH2DXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUH2DXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 23:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUH2DXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 23:23:17 -0400
Received: from trantor.org.uk ([213.146.130.142]:52428 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S266648AbUH2DXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 23:23:13 -0400
Subject: Re: Linux Incompatibility List
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: public@mikl.as
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408282143.05304.public@mikl.as>
References: <87r7q0th2n.fsf@dedasys.com> <200408250159.20606.public@mikl.as>
	 <1093418493.18600.10.camel@sherbert>  <200408282143.05304.public@mikl.as>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-l33fz+eaMGJn79csQqIx"
Date: Sun, 29 Aug 2004 04:21:41 +0100
Message-Id: <1093749701.7064.37.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l33fz+eaMGJn79csQqIx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-08-28 at 21:42 -0400, Andrew Miklas wrote:
> (Sorry for the long delay...)

Thats OK.

> Yeah, we tried that at first too (actually, we were using Frank Cornelis'=
 =20
> patches to Bochs).  The problem with dumping all the PCI activity (even w=
hile=20
> the interface isn't sending/receiving) is that there is a huge amount of =
data=20
> to sift through.  Even capturing for just a for a few seconds generates=20
> megabytes of data.  You also have to deal with various events (like the=20
> watchdog timer) going off at random times and getting mixed in with the=20
> send/receive data.  We also found DMA a little tricky too (ie. you need t=
o=20
> dump out any data that the chip will bus-master to itself to see how it i=
s=20
> structured).

OK, exactly which drivers were you using to do this? When I had the
interface brought up in win2k-server with the bcmwl5.sys driver I was
seeing every few hundred milliseconds a batch of say 12 2-byte reads on
the register space to check status...

> Also, we figured it would cause problems for supporting the whole range o=
f=20
> devices that can be handled by the wl.o drivers.  For example, from looki=
ng=20
> at the module, we can see that the driver will have somewhat different=20
> behaviour according to exactly what MAC and radio chips are present, the=20
> interface being used (ie. PCI, cardbus, etc.), the vendor, model number, =
and=20
> revision of the board itself, the contents of the ROM, etc.  We decided t=
hat=20
> there was simply too many combinations to make the data capture approach=20
> useful over the entire range of Broadcom hardware, unless you repeat the=20
> process on every variation.

Hrm, you're sure those variations aren't trivial? Although theres lots
of checks, I would have thought they would just be stuff like "card A
supports X, Y and Z features"?

The approach that makes the most sense to me is get 1 card working to
the point where it sends/receives packets, then look at the binaries to
see what the variations are, and how they apply to what cards and just
go fill in the blanks...

> > Anyway, perhaps once I've had some time to make a little more progress
> > we would be able to compare some notes?
>=20
> Sure, let me know when you're ready.

I just need to improve logging support in my pciproxy patch and setup a
2nd machine with a working wireless card, then I can start in earnest.

Also, you mention DMA and sending/receiving packets, exactly how much
progress have you made so far?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-l33fz+eaMGJn79csQqIx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMUvDkbV2aYZGvn0RApt3AJ9YLFIORadBc/Kni8Dmx26QR5FNOQCeLGQc
boagE2AvlDFXHj1vM2dsktE=
=rrza
-----END PGP SIGNATURE-----

--=-l33fz+eaMGJn79csQqIx--

