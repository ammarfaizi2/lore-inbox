Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTJOTsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTJOTsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:48:07 -0400
Received: from 62-43-29-55.user.ono.com ([62.43.29.55]:5303 "HELO mitago.net")
	by vger.kernel.org with SMTP id S264238AbTJOTsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:48:03 -0400
Date: Wed, 15 Oct 2003 21:47:54 +0200
From: Celso =?iso-8859-1?Q?Gonz=E1lez?= <celso@mitago.net>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Javier Achirica <achirica@telefonica.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: airo regression with Linux 2.4.23-pre2
Message-ID: <20031015194754.GA14859@viac3>
Reply-To: celso@mitago.net
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva> <20031015193202.54b5bb36.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20031015193202.54b5bb36.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2003 at 07:32:02PM +0200, Udo A. Steinberg wrote:
>=20
> Hi,
>=20
> My Cisco Aironet 350 Series PCMCIA network card does no longer work with =
the
> latest 2.4 and 2.6 kernels. For 2.4.23 I have been able to identify the p=
oint
> in time at which things broke. 2.4.23-pre1 still works and -pre2 does not.
> The card is unable to acquire an IP address via DHCP and also doesn't see=
m to
> receive any networking traffic at all with -pre2 and later.
>=20
> Looking at the 2.4 changelog it seems that the following patch introduced
> the problem.
>=20
> MT> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> MT> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> MT> <javier:tudela.mad.ttd.net>:
> MT>   o [wireless airo] add support for MIC and latest firmwares
>=20
> Do you have any idea what is going wrong here? If you need more informati=
on
> to narrow down the problem, just ask.

Same simptoms as me
Try removing this line on airo.c
Line 2948
ai->config._reserved1a[0] =3D 2 /* ??? */

It works for me

--=20
Celso



--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jaRpW7HC4i2jZ7cRAtHCAJ9m07PzhvWWWup0XHLtkzBefL0prQCfehPQ
O7XnwiSEoF9An2N/n0Y1bwg=
=o5M3
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
