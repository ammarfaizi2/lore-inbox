Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290551AbSAYEm6>; Thu, 24 Jan 2002 23:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290552AbSAYEmq>; Thu, 24 Jan 2002 23:42:46 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:62606 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S290551AbSAYEme>; Thu, 24 Jan 2002 23:42:34 -0500
Date: Thu, 24 Jan 2002 23:42:27 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb or video4linux problem
Message-ID: <20020125044227.GD671@online.fr>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020125032857.GA671@online.fr> <20020125041226.GA22366@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20020125041226.GA22366@kroah.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2002 at 08:12:26PM -0800, Greg KH wrote:
> On Thu, Jan 24, 2002 at 10:28:57PM -0500, christophe barb=E9 wrote:
> >=20
> > I'm convinced that it's a problem with OHCI.
> > I think it's a soft problem because I can trigger it with cpu/io
> > activity.
>=20
> Does the kernel log show any USB errors, or any USB messages at all?
> What kernel version are you using?

But I see ov511 output (with debug=3D4 option) until the freeze and then
nothing :

Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4291] Frame end, c=
urframe =3D 0, packnum=3D159, hw=3D352, vw=3D288, recvd=3D152631
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4338] Frame start,=
 framenum =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5470] CMCAPTU=
RE
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5472] frame: =
0, size: 352x288, format: 7
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5530] VIDIOCM=
CAPTURE: renewing frame 0
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_new_frame:4836] ov511->curfr=
ame =3D 1, framenum =3D 0
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5550] syncing=
 to frame 1, grabstate =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4291] Frame end, c=
urframe =3D 1, packnum=3D159, hw=3D352, vw=3D288, recvd=3D152631
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4338] Frame start,=
 framenum =3D 0
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5470] CMCAPTU=
RE
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5472] frame: =
1, size: 352x288, format: 7
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5530] VIDIOCM=
CAPTURE: renewing frame 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_new_frame:4836] ov511->curfr=
ame =3D 0, framenum =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5550] syncing=
 to frame 0, grabstate =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4291] Frame end, c=
urframe =3D 0, packnum=3D159, hw=3D352, vw=3D288, recvd=3D152631
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5470] CMCAPTU=
RE
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5472] frame: =
0, size: 352x288, format: 7
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5530] VIDIOCM=
CAPTURE: renewing frame 0
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_new_frame:4836] ov511->curfr=
ame =3D 1, framenum =3D 0
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5550] syncing=
 to frame 1, grabstate =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4338] Frame start,=
 framenum =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4291] Frame end, c=
urframe =3D 1, packnum=3D159, hw=3D352, vw=3D288, recvd=3D152631
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_move_data:4338] Frame start,=
 framenum =3D 0
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5470] CMCAPTU=
RE
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5472] frame: =
1, size: 352x288, format: 7
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5530] VIDIOCM=
CAPTURE: renewing frame 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_new_frame:4836] ov511->curfr=
ame =3D 0, framenum =3D 1
Jan 24 23:23:53 turing kernel: ov511.c: [ov511_ioctl_internal:5550] syncing=
 to frame 0, grabstate =3D 1

Then the video freeze and I get no more output.


>=20
> thanks,
>=20
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats are rather delicate creatures and they are subject to a good
many ailments, but I never heard of one who suffered from insomnia.
--Joseph Wood Krutch

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8UOIzj0UvHtcstB4RAp+rAJ9bgZSgAB9J7oXTfOZbZYZt/zIr3gCeLFrK
2m2gsvFySk98pv/93PjyHSQ=
=izo4
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
