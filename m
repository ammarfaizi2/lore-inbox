Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWJAXW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWJAXW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWJAXWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:22:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:146 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932478AbWJAXWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:22:54 -0400
X-Sasl-enc: qfS27RmMiHGBkpaOccbPlbb3Eb4KKp/USdyUMTY9PzeF 1159744975
Message-ID: <45204E34.3010307@imap.cc>
Date: Mon, 02 Oct 2006 01:24:36 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: kkeil@suse.de, kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: mark as 32-bit only
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0F3F145D339C804078F30D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0F3F145D339C804078F30D0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Oct 2006 11:21:16 -0400, Jeff Garzik wrote:
> Tons of ISDN drivers cast pointers to/from 32-bit values, which just
> won't work on 64-bit.
>=20
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
>=20
> diff --git a/drivers/isdn/Kconfig b/drivers/isdn/Kconfig
> index c90afee..608588f 100644
> --- a/drivers/isdn/Kconfig
> +++ b/drivers/isdn/Kconfig
> @@ -6,7 +6,7 @@ menu "ISDN subsystem"
> =20
>  config ISDN
>  	tristate "ISDN support"
> -	depends on NET
> +	depends on NET && 32BIT
>  	---help---
>  	  ISDN ("Integrated Services Digital Networks", called RNIS in France=
)
>  	  is a special type of fully digital telephone service; it's mostly

NAK. Just because many or even most of the ISDN drivers don't work
on 64 bit systems that's no reason to prevent using those that do.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigA0F3F145D339C804078F30D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFIE48MdB4Whm86/kRAoEPAJ9Fhf7rfY7Pb6oyO/VjN+ugzqmGgwCeICPE
99N5SxUOWrtWSraKdLUGxs0=
=qmnT
-----END PGP SIGNATURE-----

--------------enigA0F3F145D339C804078F30D0--
