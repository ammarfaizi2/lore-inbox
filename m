Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQK0WVm>; Mon, 27 Nov 2000 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129821AbQK0WVc>; Mon, 27 Nov 2000 17:21:32 -0500
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:39953 "EHLO
        ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
        id <S129514AbQK0WVW>; Mon, 27 Nov 2000 17:21:22 -0500
Date: Mon, 27 Nov 2000 13:50:16 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kurt Garloff <kurt@garloff.de>, David Brown <usb-storage@davidb.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB-Storage drivers
Message-ID: <20001127135016.A25846@one-eyed-alien.net>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
        David Brown <usb-storage@davidb.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001127221623.D24187@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001127221623.D24187@garloff.etpnet.phys.tue.nl>; from kurt@garloff.de on Mon, Nov 27, 2000 at 10:16:23PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of these sub-drivers are immature, even for the CONFIG_EXPERIMENTAL
label.  AFAIK, a patch is pending to make Freecom support appear -- it's
definately ready for prime-time, having been extensively tested by several
people.

Matt

On Mon, Nov 27, 2000 at 10:16:23PM +0100, Kurt Garloff wrote:
> Hi Matthew, David, Linus,
>=20
> any particular reason why the support for special dongles in the usb-stor=
age
> driver can not be selected during kernel configuration? (See attached pat=
ch).
>=20
> I can only tell about the Freecom support in the usb-storage driver: It
> works flawlessly for me driving some OnStream USB30 tape drive (with the
> osst driver). So, I think it should be offered to people who want to try.
>=20
> Of course, it's up to you. Maybe you want to put some ifdef CONFIG_EXPERI=
MENTAL
> around it or a little help text. But I'd definitely appreciate the
> possibility to compile the drivers without patching the Config file.
>=20
> Regards,
> --=20
> Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
> Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
> Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
>  (See mail header or public key servers for PGP2 and GPG public keys.)

> diff -uNr linux-2.4.0-t11.ac2.reiser.ide.osst/drivers/usb/Config.in linux=
-2.4.0-t11.ac2.reiser.ide.osst.usb/drivers/usb/Config.in
> --- linux-2.4.0-t11.ac2.reiser.ide.osst/drivers/usb/Config.in	Sun Nov 12 =
04:04:30 2000
> +++ linux-2.4.0-t11.ac2.reiser.ide.osst.usb/drivers/usb/Config.in	Wed Nov=
 22 22:00:40 2000
> @@ -64,6 +64,10 @@
>     dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_=
USB $CONFIG_SCSI
>     if [ "$CONFIG_USB_STORAGE" !=3D "n" ]; then
>        bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
> +      bool '    USB Mass Storage HP8200e support' CONFIG_USB_STORAGE_HP8=
200e
> +      bool '    USB Mass Storage SDDR09  support' CONFIG_USB_STORAGE_SDD=
R09
> +      bool '    USB Mass Storage DPCM    support' CONFIG_USB_STORAGE_DPCM
> +      bool '    USB Mass Storage FreeCom support' CONFIG_USB_STORAGE_FRE=
ECOM
>     fi
>     dep_tristate '  USS720 parport driver' CONFIG_USB_USS720 $CONFIG_USB =
$CONFIG_PARPORT
>     dep_tristate '  DABUSB driver' CONFIG_USB_DABUSB $CONFIG_USB




--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Stef, you just got beaten by a ball of DIRT.
					-- Greg
User Friendly, 12/7/1997

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ItcYz64nssGU+ykRArLmAJ9BMYdWg8e4Tn9nZHlCG1eFCIj0ygCgzA6F
S4971fNoGskD6Fphpkjf8Sw=
=W9Vu
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
