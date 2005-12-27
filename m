Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVL0BVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVL0BVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVL0BVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:21:22 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:57752 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932181AbVL0BVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:21:22 -0500
Date: Tue, 27 Dec 2005 02:19:32 +0100
From: Jules Villard <jvillard@ens-lyon.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@linux.ie>,
       Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051227011932.GA9771@blatterie>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le lun, 26 d=E9c 2005 15:55:21 -0800, Linus Torvalds a =E9crit :
>=20
>=20
> On Mon, 26 Dec 2005, Jules Villard wrote:
> >=20
> > Please find my .config and the lspci output attached (my graphic card
> > is a AGP plugged ATI Radeon Mobility 7500 and I use the "radeon"
> > driver from xorg).
>=20
> Ok, from the sysrq-T stuff it _looks_ like X is just busy-looping in user=
=20
> space. So it's probably some disagreement between radeonfb and X.org
>=20
> The fact that everything was ok in -rc5 would imply that it's likely one=
=20
> of the radeon aperture size issue patches.
>=20
> > Investigating a bit further, I found out that resume is quite innocent
> > about all this: what hangs X is switching from a vt to X.
>=20
> I'm cc'ing BenH and DaveA, but in the meantime, while waiting for the=20
> professionals, can you try to revert the two attachments (revert "diff-1"=
=20
> first, try that, and revert "diff-2" after that if it didn't start=20
> working after the first revert).

First revert wasn't enough, but the second one made it! Everything is
working now.

Thanks,

Jules

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDsJakpBRla5yeL58RAsH1AJ9/kaWgGD10ki8L8COBMY9FFR87/wCgle1h
22jibucRHPidrTJRhT7Cbok=
=NPtJ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
