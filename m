Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263211AbVGOF6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbVGOF6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbVGOF6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:58:12 -0400
Received: from mfep8.odn.ne.jp ([143.90.131.186]:11861 "EHLO t-mta8.odn.ne.jp")
	by vger.kernel.org with ESMTP id S263211AbVGOF5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:57:43 -0400
Date: Fri, 15 Jul 2005 14:57:43 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: Christian Kroll <christian.kroll@bglug.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_sil 3112 activity LED patch
Message-ID: <20050715055743.GA8041@alumni.uwaterloo.ca>
References: <1121393712.4770.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <1121393712.4770.6.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2005 at 04:15:12AM +0200, Christian Kroll wrote:
> I have tested the patch against my DawiControl DC-150 RAID controller
> which is basically an add-on card with a SiI 3112 ASIC and a flash ROM.
> The activity LED of my case is directly connected to the add-on card.
>=20
> Unfortunately your patch doesn't have any effect on the LED. The
> activity LED gets turned on by the card's BIOS at boot time and
> continues to shine until I shut down the computer.
> On the other hand it did not erase my Flash ROM and I haven't spotted
> any data loss so far.

No data loss is a good thing!  That was my biggest worry, as I have no
documentation for the addon card case.  Out of curiosity, did the LED
usage change at all before and after the patch, or was it totally
unaffected.  I would guess the latter.

Unfortunately, what documentation I do have shows (briefly) that add
on cards implement their LED via a different mechanism.  If I knew the
addresses for the flash read and write strobes (FL_RDN and FL_WRN), I
might be able to work something out.  So as it stands, there is not
much hope for the people with addon cards.

> If you require more information, don't hesitate to contact me.

Thanks, I will.  I have emailed Silicon Image in the (slim) chance
that they will provide me with the information I require.  If they
come through then I might be able to whip something up and have you
test it.

If anyone has any data on the 3112a (or 3512 as I believe they are
register compatible) and isn't bound by an NDA, I'd like to hear from
you.

--=20
Aric Cyr <acyr at alumni dot uwaterloo dot ca>    (http://acyr.net)
gpg fingerprint: 943A 1549 47AC D766 B7F8  D551 6703 7142 C282 D542

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC11BXZwNxQsKC1UIRApRoAKCYZZkkUMdqSUiWipkqTe1yPb3S0wCeJwQS
WnaEd+CwudnOllNmUchapHI=
=XsrV
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
