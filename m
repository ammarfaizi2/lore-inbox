Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbRGaFvR>; Tue, 31 Jul 2001 01:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268658AbRGaFvH>; Tue, 31 Jul 2001 01:51:07 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:26118
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S268063AbRGaFuy>; Tue, 31 Jul 2001 01:50:54 -0400
Date: Mon, 30 Jul 2001 22:50:51 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.8-pre3 drivers/usb/storage/scsiglue.c
Message-ID: <20010730225051.B14078@one-eyed-alien.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <32655.996545481@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <32655.996545481@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 31, 2001 at 12:11:21PM +1000
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm... there was a good reason at one point why this shouldn't be const....

Oh yeah... it's not const.  id gets assigned a few lines down.

Or does the const keywork refer only to the struct, not to the pointer?  If
that's the case, then the keyword should be there....

Matt Dharm

On Tue, Jul 31, 2001 at 12:11:21PM +1000, Keith Owens wrote:
> Trivial patch to remove warning message.
>=20
> Index: 8-pre3.1/drivers/usb/storage/scsiglue.c
> --- 8-pre3.1/drivers/usb/storage/scsiglue.c Tue, 31 Jul 2001 11:09:45 +10=
00 kaos (linux-2.4/y/b/2_scsiglue.c 1.4.2.1 644)
> +++ 8-pre3.1(w)/drivers/usb/storage/scsiglue.c Tue, 31 Jul 2001 12:07:28 =
+1000 kaos (linux-2.4/y/b/2_scsiglue.c 1.4.2.1 644)
> @@ -249,7 +249,7 @@ static int bus_reset( Scsi_Cmnd *srb )
>          for (i =3D 0; i < us->pusb_dev->actconfig->bNumInterfaces; i++) {
>   		struct usb_interface *intf =3D
>  			&us->pusb_dev->actconfig->interface[i];
> -		struct usb_device_id *id;
> +		const struct usb_device_id *id;
> =20
>  		/* if this is an unclaimed interface, skip it */
>  		if (!intf->driver) {

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm a pink gumdrop! How can anything be worse?!!
					-- Erwin
User Friendly, 10/4/1998

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Zkc7z64nssGU+ykRAmEEAKD4vo4RQpOLEyGmDVnRZrIQ4c8+5QCdGdEs
Jv638X5OdTCCbi2DojkGHj4=
=OOrn
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
