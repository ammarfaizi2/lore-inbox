Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTDQPGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDQPGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:06:22 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:12040 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261675AbTDQPGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:06:20 -0400
Date: Thu, 17 Apr 2003 08:18:00 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More USB fixes for 2.5.67
Message-ID: <20030417081759.A19615@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1050559505786@kroah.com> <10505595052196@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10505595052196@kroah.com>; from greg@kroah.com on Wed, Apr 16, 2003 at 11:05:05PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Umm... this patch is only needed on 2.4.x -- 2.5.x doesn't send START_STOP
on it's own anymore, and limiting that command is the only thing this entry
seems to do.

I don't think this should be applied.

Matt

On Wed, Apr 16, 2003 at 11:05:05PM -0700, Greg KH wrote:
> ChangeSet 1.1064, 2003/04/14 10:28:01-07:00, arndt@lin02384n012.mc.schoen=
ewald.de
>=20
> [PATCH] USB: Patch against unusual_devs.h to enable Pontis SP600
>=20
>=20
> diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unus=
ual_devs.h
> --- a/drivers/usb/storage/unusual_devs.h	Wed Apr 16 10:48:42 2003
> +++ b/drivers/usb/storage/unusual_devs.h	Wed Apr 16 10:48:42 2003
> @@ -299,6 +299,15 @@
>                  US_SC_8070, US_PR_CBI, NULL,
>                  US_FL_FIX_INQUIRY ),
> =20
> +/* Enable USB storage access to the MMC/SD and CompactFlash cards inside=
 the
> + * Pontis SP600 MP3 player (entry found on http://www.pontis.de/).
> + */
> +UNUSUAL_DEV(  0x09bc, 0x0003, 0x0000, 0x9999,
> +		"PONTIS",
> +		"SP600",
> +		US_SC_SCSI, US_PR_BULK, NULL,
> +		US_FL_START_STOP ),
> +
>  #ifdef CONFIG_USB_STORAGE_ISD200
>  UNUSUAL_DEV(  0x05ab, 0x0031, 0x0100, 0x0110,
>  		"In-System",
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You should try to see the techs say "three piece suit".
					-- The Chief
User Friendly, 11/23/1997

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+nsWnIjReC7bSPZARAg7JAJ9Y/dyXD643PfczmTChkv5FFWvpZQCguAJX
ovsomCQOXeHIK9pFjsb2bMQ=
=X3xc
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
