Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUI3KqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUI3KqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 06:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUI3KqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 06:46:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:37298 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268695AbUI3KqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 06:46:12 -0400
Date: Thu, 30 Sep 2004 12:46:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux@horizon.com,
       linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz,
       jmorris@redhat.com
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
Message-ID: <20040930104610.GZ847@lug-owl.de>
Mail-Followup-To: Jean-Luc Cooke <jlcooke@certainkey.com>,
	Theodore Ts'o <tytso@mit.edu>, linux@horizon.com,
	linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz,
	jmorris@redhat.com
References: <20040924005938.19732.qmail@science.horizon.com> <20040929171027.GJ16057@certainkey.com> <20040929193117.GB6862@thunk.org> <20040929202707.GO16057@certainkey.com> <20040929215315.GB6769@thunk.org> <20040930002100.GQ16057@certainkey.com> <20040930042303.GS16057@certainkey.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QxSStYAgvEtE+iQJ"
Content-Disposition: inline
In-Reply-To: <20040930042303.GS16057@certainkey.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QxSStYAgvEtE+iQJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-30 00:23:03 -0400, Jean-Luc Cooke <jlcooke@certainkey.com>
wrote in message <20040930042303.GS16057@certainkey.com>:
> --- linux-2.6.8.1/crypto/Kconfig	2004-08-14 06:56:22.000000000 -0400
> +++ linux-2.6.8.1-rand2/crypto/Kconfig	2004-09-28 23:30:04.000000000 -0400
> @@ -9,6 +9,15 @@
>  	help
>  	  This option provides the core Cryptographic API.
> =20
> +config CRYPTO_RANDOM_FORTUNA
> +	bool "The Fortuna RNG"
> +	help
> +	  Replaces the legacy Linux RNG with one using the crypto API
> +	  and Fortuna by Ferguson and Schneier.  Entropy estimation, and
> +	  a throttled /dev/random remain.  Improvements include faster
> +	  /dev/urandom output and event input mixing.
> +	  Note: Requires AES and SHA256 to be built-in.
> +
>  config CRYPTO_HMAC
>  	bool "HMAC support"

Instead of mentioning AES and SHA256 being required built-in, why not
just "select" them?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--QxSStYAgvEtE+iQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBW+PyHb1edYOZ4bsRAjsrAJ9rQPH1ryzHJfZYk8loG0/m+0rYowCgj6YC
FOaBBeU2FSiSpKKVns90AP4=
=SzL/
-----END PGP SIGNATURE-----

--QxSStYAgvEtE+iQJ--
