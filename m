Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVJ1Gzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVJ1Gzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVJ1Gzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:55:41 -0400
Received: from lug-owl.de ([195.71.106.12]:9666 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S965119AbVJ1Gz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:55:26 -0400
Date: Fri, 28 Oct 2005 08:55:22 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Message-ID: <20051028065522.GJ27184@lug-owl.de>
Mail-Followup-To: Greg K-H <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1130481024363@kroah.com> <11304810242953@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <11304810242953@kroah.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-10-27 23:30:24 -0700, Greg KH <gregkh@suse.de> wrote:
> diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkb=
d.c
> index 098963c..7f06780 100644
> @@ -435,14 +434,14 @@ lkkbd_interrupt (struct serio *serio, un
> =20
>  	switch (data) {
>  		case LK_ALL_KEYS_UP:
> -			input_regs (&lk->dev, regs);
> +			input_regs (lk->dev, regs);
>  			for (i =3D 0; i < ARRAY_SIZE (lkkbd_keycode); i++)
>  				if (lk->keycode[i] !=3D KEY_RESERVED)
> -					input_report_key (&lk->dev, lk->keycode[i], 0);
> -			input_sync (&lk->dev);
> +					input_report_key (lk->dev, lk->keycode[i], 0);
> +			input_sync (lk->dev);
>  			break;
>  		case LK_METRONOME:
> -			DBG (KERN_INFO "Got LK_METRONOME and don't "
> +			DBG (KERN_INFO "Got %#d and don't "
>  					"know how to handle...\n");
>  			break;
>  		case LK_OUTPUT_ERROR:

The format change (%#d) should take an argument on stack, shouldn't
it? But there's nothing pushed? ...or is it just a typo?

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

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDYctaHb1edYOZ4bsRAv8AAJ9MjBgRWHumPe50XgJlIUeWxJbZwwCbBZZZ
5IdfZbLpVlI8wA84M/HaO3c=
=mfWF
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
