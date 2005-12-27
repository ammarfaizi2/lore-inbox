Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVL0Bk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVL0Bk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVL0Bk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:40:28 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:40093 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932196AbVL0BkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:40:21 -0500
Date: Tue, 27 Dec 2005 02:20:53 +0100
From: Jules Villard <jvillard@ens-lyon.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051227012053.GB9771@blatterie>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org> <1135641618.4780.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <1135641618.4780.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le mar, 27 d=E9c 2005 11:00:18 +1100, Benjamin Herrenschmidt a =E9crit :
> On Mon, 2005-12-26 at 15:55 -0800, Linus Torvalds wrote:
> >=20
> > On Mon, 26 Dec 2005, Jules Villard wrote:
> > >=20
> > > Please find my .config and the lspci output attached (my graphic card
> > > is a AGP plugged ATI Radeon Mobility 7500 and I use the "radeon"
> > > driver from xorg).
> >=20
> > Ok, from the sysrq-T stuff it _looks_ like X is just busy-looping in us=
er=20
> > space. So it's probably some disagreement between radeonfb and X.org
> >=20
> > The fact that everything was ok in -rc5 would imply that it's likely on=
e=20
> > of the radeon aperture size issue patches.
> >=20
> > > Investigating a bit further, I found out that resume is quite innocent
> > > about all this: what hangs X is switching from a vt to X.
> >=20
> > I'm cc'ing BenH and DaveA, but in the meantime, while waiting for the=
=20
> > professionals, can you try to revert the two attachments (revert "diff-=
1"=20
> > first, try that, and revert "diff-2" after that if it didn't start=20
> > working after the first revert).
>=20
> Also, does it work if you don't use radeonfb ? radeonfb shouldn't touch
> MC_AGP_LOCATION and the DRM change only affects that, so I'm a bit
> surprised.
>=20
> Ben.
>=20

Do you still want me to try that now that reverting the two patches
made the job?


Jules

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDsJb0pBRla5yeL58RAtMKAKCbcmdEvmFlDcbxr9n6tTFDfNMthwCfWNwa
AW+pWPeJs0CGslMSjDqkxrg=
=j85A
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
