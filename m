Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUFGNIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUFGNIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbUFGNIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:08:32 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:63970 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264680AbUFGNHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:07:41 -0400
Date: Mon, 7 Jun 2004 15:07:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/39] input: Create input_set_abs_params()
Message-ID: <20040607130740.GV20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <10866093532639@twilight.ucw.cz> <10866093531704@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YyXJyCU6zaKvJ1kw"
Content-Disposition: inline
In-Reply-To: <10866093531704@twilight.ucw.cz>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YyXJyCU6zaKvJ1kw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-07 13:55:53 +0200, Vojtech Pavlik <vojtech@suse.cz>
wrote in message <10866093531704@twilight.ucw.cz>:
>          - make use of set_abs_params in touchscreen drivers

> @@ -125,11 +125,9 @@
> =20
>  	init_input_dev(&gunze->dev);
>  	gunze->dev.evbit[0] =3D BIT(EV_KEY) | BIT(EV_ABS);
> -	gunze->dev.absbit[0] =3D BIT(ABS_X) | BIT(ABS_Y);
>  	gunze->dev.keybit[LONG(BTN_TOUCH)] =3D BIT(BTN_TOUCH);
> -
> -	gunze->dev.absmin[ABS_X] =3D 96;   gunze->dev.absmin[ABS_Y] =3D 72;
> -	gunze->dev.absmax[ABS_X] =3D 4000; gunze->dev.absmax[ABS_Y] =3D 3000;
> +	input_set_abs_params(&gunze->dev, ABS_X, 96, 4000, 0, 0);
> +	input_set_abs_params(&gunze->dev, ABS_Y, 72, 3000, 0, 0);
> =20
>  	gunze->serio =3D serio;
>  	serio->private =3D gunze;

I guess ./drivers/input/mouse/vsxxxaa.c could use a patch like this,
too. It can also drive a graphic tablet. I'll prepare a patch this
night...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--YyXJyCU6zaKvJ1kw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxGicHb1edYOZ4bsRAm86AKCFkZwF8YQsX34N9wJqflKF2BfWXgCeOFI/
ZaQgSxk0e+Vlja1Ghc5jYRQ=
=i3b+
-----END PGP SIGNATURE-----

--YyXJyCU6zaKvJ1kw--
