Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277885AbRJKAlR>; Wed, 10 Oct 2001 20:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277909AbRJKAk6>; Wed, 10 Oct 2001 20:40:58 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:22035
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S277885AbRJKAkx>; Wed, 10 Oct 2001 20:40:53 -0400
Date: Wed, 10 Oct 2001 17:41:17 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jan Niehusmann <jan@gondor.com>
Cc: Harald Schreiber <harald@harald-schreiber.de>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB Support for recent Casio Digital Still Cameras, linux-2.4.11
Message-ID: <20011010174117.B10273@one-eyed-alien.net>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	Harald Schreiber <harald@harald-schreiber.de>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <m3elobqblf.fsf@harald-schreiber.de> <20011011023647.A14615@gondor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011011023647.A14615@gondor.com>; from jan@gondor.com on Thu, Oct 11, 2001 at 02:36:47AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In my experience, if you've tested the endpoints on these things, you've
covered the middle.  I'd rather have the single entry.

Matt

On Thu, Oct 11, 2001 at 02:36:47AM +0200, Jan Niehusmann wrote:
> On Thu, Oct 11, 2001 at 02:11:56AM +0200, Harald Schreiber wrote:
> > Recent Casio QV digital still cameras (for example the QV 4000)
> > show up as=20
> > VendorID: 0x07cf  ProductID: 0x1001  Revision: 10.00
> >=20
> > So the following patch is necessary to make these devices working
> > with the USB storage driver. The patch is against linux-2.4.11,
> > but it should work with any kernel since 2.4.8-pre3.
>=20
> Confirmed. I sent the same patch (without the comments) to linux-kernel
> three days ago.
>=20
> BTW, perhaps it would be better to patch the thing the following way,
> because I don't know what's in the revision number range between
> 1000 and 9009, perhaps there are other devices which don't like the
> workaround?
>=20
>=20
> --- linux-2.4.9-ac10/drivers/usb/storage/unusual_devs.h	Sat Sep  8 18:18:=
51 2001
> +++ linux-2.4.10-ac11/drivers/usb/storage/unusual_devs.h	Thu Oct 11 02:11=
:29 2001
> @@ -394,6 +394,12 @@
>   * - They don't like the INQUIRY command. So we must handle this command
>   *   of the SCSI layer ourselves.
>   */
> +UNUSUAL_DEV( 0x07cf, 0x1001, 0x1000, 0x1000,
> +                "Casio",
> +                "QV DigitalCamera",
> +                US_SC_8070, US_PR_CB, NULL,
> +                US_FL_FIX_INQUIRY ),
> +
>  UNUSUAL_DEV( 0x07cf, 0x1001, 0x9009, 0x9009,
>                  "Casio",
>                  "QV DigitalCamera",
>=20
> > --------------------------------------------------------------------
> > Dipl.-Math. Harald Schreiber, Nizzaallee 26, D-52072 Aachen, Germany
> > Phone/Fax: +49-241-9108015/6       mailto:harald@harald-schreiber.de
> > --------------------------------------------------------------------
>=20
> Interesting, twice the same patch, and then from nearly the same location
> in the world. (Roermonder Str. 112a - distance several 100m )
>=20
> Jan

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

God, root, what is difference?
					-- Pitr
User Friendly, 11/11/1999

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7xOqtz64nssGU+ykRAvVdAKCD8iKkO4nevaLW15iud0N57OpFuwCg1//x
lOYCHhzaMEgGZu45XcjVtxU=
=YC6+
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
