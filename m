Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSFYRhs>; Tue, 25 Jun 2002 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSFYRhr>; Tue, 25 Jun 2002 13:37:47 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:65034 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S315472AbSFYRhq>; Tue, 25 Jun 2002 13:37:46 -0400
Date: Tue, 25 Jun 2002 10:37:43 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS2 -> USB magic
Message-ID: <20020625103743.B21980@one-eyed-alien.net>
Mail-Followup-To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>,
	linux-kernel@vger.kernel.org
References: <200206251727.g5PHRKY16997@atlas.inria.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206251727.g5PHRKY16997@atlas.inria.fr>; from Nicolas.Turro@sophia.inria.fr on Tue, Jun 25, 2002 at 07:27:20PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

BIOS emulation for your USB mouse as a PS/2 device.  It's pretty common on
many mainboards.

Matt

On Tue, Jun 25, 2002 at 07:27:20PM +0200, Nicolas Turro wrote:
>=20
> Hello,
>=20
> on my laptop (compaq armada m300), i used to plug an usb mouse,
> and it was 'seen' as a ps2 mouse by Xfree, without any usb module loading=
=20
> (kernel 2.2.18, with custom configure options)
>=20
> root@polaire# ls -l /dev/mouse /dev/psmouse
> lrwxrwxrwx   1 root     root           12 Jun 25 15:27 /dev/mouse ->=20
> /dev/psmouse
> crw-rw-rw-   1 root     sys       10,   1 Jun 25 15:27 /dev/psmouse
>=20
> and :
> Section "InputDevice"
>     Identifier  "Mouse1"
>     Driver      "mouse"
>     Option      "Device"        "/dev/mouse"
>     Option      "Protocol"      "PS/2"
>     Option      "Emulate3Buttons"
> EndSection
>=20
> In my XF86Config ...
> It was kinda magic....=20
>=20
> Anyway, i compiled a 2.4.17 kernel (with more or less the same configure=
=20
> options, but it was a pain for usb), and now the same 'magic' doesn't wor=
k....
> I must use usbcore, hid, mousedev, uhci modules in order to use my usb=20
> mouse...
>=20
> Can someone explain me how it worked in 2.2.18 without those modules,
> and is it possible to make the same magic work in 2.4.17 ?
>=20
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Why am I talking to a toilet brush?
					-- CEO
User Friendly, 4/30/1998

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9GKpnIjReC7bSPZARAuL9AJkBXRLTVvZ317Pq4RSaLVYdNBGGYwCfZXRB
kJ0BN/qJOz8tFvqbFnA5RmY=
=/sPo
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
