Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSIWUrq>; Mon, 23 Sep 2002 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSIWUrq>; Mon, 23 Sep 2002 16:47:46 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:27404 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S261362AbSIWUro>; Mon, 23 Sep 2002 16:47:44 -0400
Date: Mon, 23 Sep 2002 13:52:47 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
Message-ID: <20020923135247.A19690@one-eyed-alien.net>
Mail-Followup-To: Marek Michalkiewicz <marekm@amelek.gda.pl>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20020923200554.GG18769@kroah.com> <E17tZl6-000164-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17tZl6-000164-00@alf.amelek.gda.pl>; from marekm@amelek.gda.pl on Mon, Sep 23, 2002 at 10:24:44PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, 2.5 tests would be good... we've re-worked the state machine, so
the behavior might be significantly different.

Not that I can get 2.5.x to boot for me right now, tho...

Matt

On Mon, Sep 23, 2002 at 10:24:44PM +0200, Marek Michalkiewicz wrote:
> Greg KH <greg@kroah.com> wrote:
> > That's Matt's call, not mine.  And generating a patch for 2.4.20-pre7
> > and 2.5.38 would help out in getting it accepted :)
>=20
> Below is the patch for 2.4.20-pre7.  I'm not brave enough to test 2.5.x
> kernels just yet...
>=20
> Thanks,
> Marek
>=20
> --- orig/linux-2.4.20-pre7/drivers/usb/storage/unusual_devs.h	2002-09-21 =
12:27:12.000000000 +0200
> +++ linux-2.4.20-pre7/drivers/usb/storage/unusual_devs.h	2002-09-23 22:09=
:18.000000000 +0200
> @@ -485,6 +485,17 @@
>  		US_FL_MODE_XLATE ),
>  #endif
> =20
> +/* Datafab KECF-USB / Sagatek DCS-CF (Datafab DF-UG-07 chip).
> + * Submitted by Marek Michalkiewicz <marekm@amelek.gda.pl>.
> + * Needed for FIX_INQUIRY.  Only revision 1.13 tested.
> + * See also http://martin.wilck.bei.t-online.de/#kecf .
> + */
> +UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
> +		"Datafab",
> +		"KECF-USB",
> +		US_SC_SCSI, US_PR_BULK, NULL,
> +		US_FL_FIX_INQUIRY ),
> +
>  /* Casio QV 2x00/3x00/4000/8000 digital still cameras are not conformant
>   * to the USB storage specification in two ways:
>   * - They tell us they are using transport protocol CBI. In reality they
>=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I say, what are all those naked people doing?
					-- Big client to Stef
User Friendly, 12/14/1997

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9j38fIjReC7bSPZARAhKNAKCPeO6tBsTUcSggCQdGkI/I20VhtgCeLRNj
dUORKYjjd6W5JyQi4QUFOBc=
=/Jfb
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
