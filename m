Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264547AbUDULeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUDULeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 07:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbUDULeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 07:34:09 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:36741 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264547AbUDULeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 07:34:04 -0400
Date: Wed, 21 Apr 2004 13:34:02 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 5/15] New set of input patches: lkkbd simplify checks
Message-ID: <20040421113402.GZ12700@lug-owl.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210053.09166.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+bne1ZFwxW5PfJO"
Content-Disposition: inline
In-Reply-To: <200404210053.09166.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+bne1ZFwxW5PfJO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-21 00:53:07 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <200404210053.09166.dtor_core@ameritech.net>:
> --- a/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:01:41 2004
> +++ b/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:01:41 2004
> @@ -527,9 +527,7 @@
> =20
>  	if ((serio->type & SERIO_TYPE) !=3D SERIO_RS232)
>  		return;
> -	if (!(serio->type & SERIO_PROTO))
> -		return;
> -	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) !=3D SER=
IO_LKKBD)
> +	if ((serio->type & SERIO_PROTO) !=3D SERIO_LKKBD)
>  		return;
> =20
>  	if (!(lk =3D kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))

Looks good. I'll take this patch inty my "master" version.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--x+bne1ZFwxW5PfJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhlwqHb1edYOZ4bsRAnGBAJ99xV3dBaw7S5ZL1n9qevxx3EFHWwCfYvjA
iZIWFG0nlGYBXe7mC1v90Mg=
=ZjSP
-----END PGP SIGNATURE-----

--x+bne1ZFwxW5PfJO--
