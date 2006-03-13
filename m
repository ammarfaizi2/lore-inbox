Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWCMIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWCMIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWCMIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:14:09 -0500
Received: from lug-owl.de ([195.71.106.12]:54236 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932355AbWCMIOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:14:08 -0500
Date: Mon, 13 Mar 2006 09:14:06 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Johannes Goecke <goecke@upb.de>
Subject: Re: Patch: MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard
Message-ID: <20060313081406.GX4297@lug-owl.de>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>,
	Johannes Goecke <goecke@upb.de>
References: <20060311192840.GA19313@uni-paderborn.de> <1142134890.25358.43.camel@mindpipe> <20060313075741.GA31459@uni-paderborn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhxWStFQ84VXWhXs"
Content-Disposition: inline
In-Reply-To: <20060313075741.GA31459@uni-paderborn.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FhxWStFQ84VXWhXs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-13 08:57:42 +0100, Johannes Goecke <goecke@upb.de> wrote:
> On Sat, Mar 11, 2006 at 10:41:29PM -0500, Lee Revell wrote:
> > On Sat, 2006-03-11 at 20:28 +0100, Johannes Goecke wrote:
> > This has been discussed on LKML recently, it's not 2.6.16 material
> > because it might break working setups when the previously disabled
> > device becomes the default sound card.  Of course the same setup would
> > have broken if we added a driver for a previously unsupported soundcard,
> > so I'm not sure how this fits in with the "don't break userspace" rule.
>=20
> would it be useful to add a compile-time-option and additionally
> a kernel-command-line option for some bogus-code like
>=20
> if ( commandline-enable || compiletime-enable )=20
> {
> 	/* Enable all Soundcards- Found */
> }

Well, the whole collection of Quirks isn't based on a device-type
model, but purely on IDs. So either there's a workaround for some
oddity, or there isn't.

Though it may make sense to re-submit if right after 2.6.16 is out.

> can someone give me a (kernel-programming-beginner-level) hint, for the f=
irst=20
> question how to ensure to only execute if running on the right Mother-boa=
rd?
> Af far as I believe the quirk so-far only checks the cipset, so it might
> behave wrong on other Mainborads!=20

That depends on wether the soundchip is inside the chipset. If it is,
you can just ignore that and run the quirk if the proper device was
found (as you do it right now.)  If you really need to verify the
mainboard (as per name/vendor), have a look at
=2E/arch/i386/kernel/{reboot,apm}.c .  They both are DMI users.

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

--FhxWStFQ84VXWhXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEFSnOHb1edYOZ4bsRAmGEAJ9ao8YzoYlCCtW4yUJv1aL5g8aOEQCfQAgp
Riqa+YYJskthkkA8nPXttuI=
=rBYP
-----END PGP SIGNATURE-----

--FhxWStFQ84VXWhXs--
