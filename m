Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVIILZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVIILZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVIILZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:25:39 -0400
Received: from lug-owl.de ([195.71.106.12]:8105 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030247AbVIILZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:25:38 -0400
Date: Fri, 9 Sep 2005 13:25:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-ID: <20050909112534.GF3539@lug-owl.de>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050908211539.GA24714@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
In-Reply-To: <20050908211539.GA24714@mars.ravnborg.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-09-08 23:15:39 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> I suggest moving all the logic required to build the asm-offsets.h file
> to a common places and do proper search&replace in architectures to make
> the naming consitent. For frv, m32r and sparc64 we will need to create a
> dummy file until they start using asm-offsets.h

Yay! Another rule we can kill from arch-specific Makefile :-)

> --- a/Makefile
> +++ b/Makefile
> @@ -776,14 +776,14 @@ $(vmlinux-dirs): prepare-all scripts
>  # A multi level approach is used. prepare1 is updated first, then prepar=
e0.
>  # prepare-all is the collection point for the prepare targets.
> =20
> -.PHONY: prepare-all prepare prepare0 prepare1 prepare2
> +.PHONY: prepare-all prepare prepare0 prepare1 prepare2 prepare3
> =20
> -# prepare2 is used to check if we are building in a separate output dire=
ctory,
> +# preparei3 is used to check if we are building in a separate output dir=
ectory,
           ^^^
Typo?

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

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDIXEuHb1edYOZ4bsRAgXRAJ93pTuxSOvGHxEmoXpIgkB167ZcBACffDAr
/cO28KmQZSO/uwVCoQaxMhw=
=JUBz
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
