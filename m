Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWDYSxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWDYSxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWDYSxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:53:43 -0400
Received: from lug-owl.de ([195.71.106.12]:36327 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751353AbWDYSxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:53:42 -0400
Date: Tue, 25 Apr 2006 20:53:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Brian Uhrain <buhrain@rosettastone.com>
Cc: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.6 ( - 2.6.16.11 ) compile failure on an alpha
Message-ID: <20060425185340.GH25520@lug-owl.de>
Mail-Followup-To: Brian Uhrain <buhrain@rosettastone.com>,
	Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, gregkh@suse.de,
	linux-kernel@vger.kernel.org
References: <20060425101647.GH4349@vega.lnet.lut.fi> <444DFA05.2060508@rosettastone.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline
In-Reply-To: <444DFA05.2060508@rosettastone.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-25 11:29:25 +0100, Brian Uhrain <buhrain@rosettastone.com> =
wrote:
> ---
>  arch/alpha/kernel/setup.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> --- linux-2.6.16.11.orig/arch/alpha/kernel/setup.c	2006-04-25 11:21:03.00=
0000000 +0100
> +++ linux-2.6.16.11/arch/alpha/kernel/setup.c	2006-04-25 11:22:56.5572666=
08 +0100
> @@ -483,11 +483,13 @@ register_cpus(void)
>  {
>  	int i;
> =20
> -	for_each_possible_cpu(i) {
> -		struct cpu *p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> -		if (!p)
> -			return -ENOMEM;
> -		register_cpu(p, i, NULL);
> +	for (i =3D 0; i < NR_CPUS; i++) {

Nope.  Please implement for_each_possible_cpu(). A patch for that flew
along right today.

> +		if (cpu_possible(i)) {
> +			struct cpu *p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> +			if (!p)
> +				return -ENOMEM;
> +			register_cpu(p, i, NULL);
> +		}
>  	}
>  	return 0;
>  }

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

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFETnA0Hb1edYOZ4bsRAjSPAKCHs39GgjKwjJ/BTS+uJc/Sq6XlzACfQc19
O+4FQ3GAvl85uYE4C6G7rJM=
=cSBB
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--
