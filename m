Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbUL3Jsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUL3Jsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUL3Jsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:48:43 -0500
Received: from lug-owl.de ([195.71.106.12]:7845 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261573AbUL3Jsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 04:48:40 -0500
Date: Thu, 30 Dec 2004 10:48:39 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: David Dillow <dave@thedillows.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.10 1/22] xfrm: Add direction information to xfrm_state
Message-ID: <20041230094839.GX2460@lug-owl.de>
Mail-Followup-To: David Dillow <dave@thedillows.org>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20041230035000.01@ori.thedillows.org> <20041230035000.10@ori.thedillows.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="urKaCNvFwQ8jDQOg"
Content-Disposition: inline
In-Reply-To: <20041230035000.10@ori.thedillows.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--urKaCNvFwQ8jDQOg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-12-30 03:48:34 -0500, David Dillow <dave@thedillows.org>
wrote in message <20041230035000.10@ori.thedillows.org>:
> diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
> --- a/include/net/xfrm.h	2004-12-30 01:12:08 -05:00
> +++ b/include/net/xfrm.h	2004-12-30 01:12:08 -05:00
> @@ -146,6 +146,9 @@
>  	/* Private data of this transformer, format is opaque,
>  	 * interpreted by xfrm_type methods. */
>  	void			*data;
> +
> +	/* Intended direction of this state, used for offloading */
> +	int			dir;
>  };
> =20
>  enum {
> @@ -157,6 +160,12 @@
>  	XFRM_STATE_DEAD
>  };
> =20
> +enum {
> +	XFRM_STATE_DIR_UNKNOWN,
> +	XFRM_STATE_DIR_IN,
> +	XFRM_STATE_DIR_OUT,
> +};

Any specific reason to first define such a nice enum and then using int
in the struct?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--urKaCNvFwQ8jDQOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB0873Hb1edYOZ4bsRAtCuAJ9evP8DkQ142XphAFaMDulpbbu15gCgieXS
cBCw52xCYS6wmYrHlrMGijM=
=44jp
-----END PGP SIGNATURE-----

--urKaCNvFwQ8jDQOg--
