Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVAaNCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVAaNCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVAaNCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:02:35 -0500
Received: from dea.vocord.ru ([217.67.177.50]:13003 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261183AbVAaNCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:02:01 -0500
Subject: Re: [-mm patch] connector.c: make notify_lock static
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050131124119.GE18316@stusta.de>
References: <20050131124119.GE18316@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h9NUABwple7IE9oLJj9z"
Organization: MIPT
Date: Mon, 31 Jan 2005 16:06:30 +0300
Message-Id: <1107176790.568.1.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 31 Jan 2005 16:00:42 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h9NUABwple7IE9oLJj9z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-31 at 13:41 +0100, Adrian Bunk wrote:
> notify_lock isn't a good name for a global lock.
> But since it's not used outside of the file, it can be made static.

You are right, Adrian, thank you.
Greg, please push it upstream.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

> --- linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c.old	2005-01-3=
1 13:09:14.000000000 +0100
> +++ linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c	2005-01-31 13=
:09:28.000000000 +0100
> @@ -41,7 +41,7 @@
>  module_param(cn_idx, uint, 0);
>  module_param(cn_val, uint, 0);
> =20
> -spinlock_t notify_lock =3D SPIN_LOCK_UNLOCKED;
> +static spinlock_t notify_lock =3D SPIN_LOCK_UNLOCKED;
>  static LIST_HEAD(notify_list);
> =20
>  static struct cn_dev cdev;
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-h9NUABwple7IE9oLJj9z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB/i1WIKTPhE+8wY0RArGVAJ9yy60oRnv1ye8X+POIDRMDl2K1WACgiZ/i
+FRJfLa7it1JTetvOfTiRKo=
=2S4n
-----END PGP SIGNATURE-----

--=-h9NUABwple7IE9oLJj9z--

