Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758340AbWLBTg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758340AbWLBTg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758385AbWLBTg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:36:27 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:13213 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S1758340AbWLBTg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:36:26 -0500
Date: Sat, 2 Dec 2006 14:36:24 -0500
From: Bart Trojanowski <bart@jukie.net>
To: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: nforce chipset + dualcore x86-64: Oops, NMI, Null pointer deref, etc
Message-ID: <20061202193624.GD20337@jukie.net>
References: <fa.EzYK0cTOJOhsylgT7NpDZwIOqx8@ifi.uio.no> <4571BBFE.9000707@shaw.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <4571BBFE.9000707@shaw.ca>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Robert Hancock <hancockr@shaw.ca> [061202 13:33]:
> >[   27.337641] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >[   27.344035] ide: Assuming 33MHz system bus speed for PIO modes;=20
> >override with idebus=3Dxx
> >[   27.352191] Probing IDE interface ide0...
> >[   28.145997] hda: PLEXTOR DVDR PX-716AL, ATAPI CD/DVD-ROM drive
> >[   28.457643] Probing IDE interface ide1...
> >[   28.970267] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>=20
> Hmm. Something seems missing here. Chipset-specific driver not enabled?=
=20
> I don't see any references to DMA mode or the controller type. It seems=
=20
> like in this case something in drivers/ide is blowing up later on (which=
=20
> shouldn't happen in any case but that code is not the greatest).
>=20
> Myself, I would try disabling CONFIG_IDE entirely and enabling the=20
> corresponding new libata PATA driver for this chipset's PATA ports (for=
=20
> nForce4 it will be pata_amd). Even if it still doesn't work it may allow=
=20
> the real problem to be diagnosed more easily.

Robert, thanks for taking time to look at the output.

I am not using anything on the PATA chain, other then the DVD drive --
which has sat idle during all of this.

BTW, I did have this in my config already...

CONFIG_ATA=3Dy
CONFIG_SATA_NV=3Dy

Thanks for the suggestion.  I can certainly disable CONFIG_IDE and try
again.

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcdW4/zRZ1SKJaI8RAq2yAKC5iigpuPmiAV0JMkY/TzA496W2qQCdHe9Q
Oj/60mUjUiP8Te00KlQVqNA=
=5Pb9
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
