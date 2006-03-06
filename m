Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752356AbWCFJeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbWCFJeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbWCFJeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:34:09 -0500
Received: from lug-owl.de ([195.71.106.12]:46014 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1752356AbWCFJeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:34:08 -0500
Date: Mon, 6 Mar 2006 10:34:02 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Message-ID: <20060306093402.GK19232@lug-owl.de>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org,
	Dave Jones <davej@redhat.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <1141590742.14714.102.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h7tFVRo9JdnMyCgj"
Content-Disposition: inline
In-Reply-To: <1141590742.14714.102.camel@mindpipe>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h7tFVRo9JdnMyCgj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-03-05 15:32:22 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2006-03-05 at 20:27 +0100, bjd wrote:
> > From: Bauke Jan Douma <bjdouma@xs4all.nl>
> > On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
> > and MC97 modem controller are deactivated when a second PCI soundcard
> > is present.  This patch enables them.
>=20
> Thanks for fixing this!  We get a ton of complaints about this "feature"
> on the ALSA lists.

On our LUG list (linux@lug-owl.de) we had such a case as well, about a
year ago.

> Do we have any idea why ASUS would have done such a thing?  Users hate
> it.  Are they working around a hardware or Windows bug?

The point is that most people either use the on-board stuff, _or_ they
buy a soundcard to use that one. Vendors seem to think they shouldn't
confuse users with always letting them choose between _two_ sound
cards.

There are two trick you can play. Either disable the card in the PCI
config space, or (in older mainboards of i486 class with ISA) they
used custom ASICs in between that were activated by some magic
sequence written to some magic ISA I/O ports.

In the first case, it's quite simple to figure out how to re-enable
the card. If this is an issue somewhere, please feel free to ask for
help. Maybe even a little helper program could be written to aid in
finding the appropriate bits.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--h7tFVRo9JdnMyCgj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEDAIKHb1edYOZ4bsRApjFAJ9rahydjJJd7NqmuY3a6H+VgT6fIwCeMrsd
TAtLrLdpNoobsOq3cWLyKxM=
=cSZw
-----END PGP SIGNATURE-----

--h7tFVRo9JdnMyCgj--
