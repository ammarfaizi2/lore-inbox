Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWAaPBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWAaPBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWAaPBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:01:04 -0500
Received: from lug-owl.de ([195.71.106.12]:35252 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750916AbWAaPBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:01:03 -0500
Date: Tue, 31 Jan 2006 16:01:01 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/11] LED: Add LED Timer Trigger
Message-ID: <20060131150101.GX18336@lug-owl.de>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1138714882.6869.123.camel@localhost.localdomain> <1138714898.6869.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjhoOuBBO3tcW+yP"
Content-Disposition: inline
In-Reply-To: <1138714898.6869.129.camel@localhost.localdomain>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjhoOuBBO3tcW+yP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-31 13:41:37 +0000, Richard Purdie <rpurdie@rpsys.net> wrote:
> Index: linux-2.6.15/drivers/leds/ledtrig-timer.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.15/drivers/leds/ledtrig-timer.c	2006-01-29 17:40:11.0000000=
00 +0000
> @@ -0,0 +1,204 @@
> +/* led_dev write lock needs to be held */
> +static void led_timer_setdata(struct led_device *led_dev, unsigned long =
duty, unsigned long frequency)
> +{
> +	struct timer_trig_data *timer_data =3D led_dev->trigger_data;
> +	signed long duty1;
> +
> +	if (frequency > 500)
> +		frequency =3D 500;

Why? ...and especially: why, without complaining?

> +	if (duty > 100)
> +		duty =3D 100;

Dito.

> +	duty1 =3D duty - 50;
> +
> +	timer_data->duty =3D duty;
> +	timer_data->frequency =3D frequency;
> +	if (frequency !=3D 0) {
> +		timer_data->delay_on =3D (50 - duty1) * 1000 / 50 / frequency;
> +		timer_data->delay_off =3D (50 + duty1) * 1000 / 50 / frequency;
> +	}

Nice math :-)

> +	mod_timer(&timer_data->timer, jiffies);
> +}
> +

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

--tjhoOuBBO3tcW+yP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD33utHb1edYOZ4bsRAt2MAJ4x0VVYF7Hjyg41S4XvmJsAin3/PACcC60b
cmfDTrYBHcuhDr0JfEEJKb4=
=fbbS
-----END PGP SIGNATURE-----

--tjhoOuBBO3tcW+yP--
