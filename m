Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUDXIla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUDXIla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 04:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUDXIla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 04:41:30 -0400
Received: from legolas.restena.lu ([158.64.1.34]:59295 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S262063AbUDXIl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 04:41:27 -0400
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <408A16EB.30208@bigfoot.com>
References: <40853060.2060508@bigfoot.com>
	 <200404202326.24409.kim@holviala.com>  <408A16EB.30208@bigfoot.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wpNsNVkrBTPMnaAKQ48I"
Message-Id: <1082796078.16262.2.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Apr 2004 10:41:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wpNsNVkrBTPMnaAKQ48I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-04-24 at 09:27, Erik Steffl wrote:
> Kim Holviala wrote:
> > On Tuesday 20 April 2004 17:14, Erik Steffl wrote:
> >=20
> >=20
> >>   it looks that after update to 2.6.5 kernel (debian source package bu=
t
> >>I guess it would be the same with stock 2.6.5) the mouse wheel and side
> >>button on Logitech Cordless MouseMan Wheel mouse do not work.
> >=20
> >=20
> > Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10
> >=20
> > Build psmouse into a module (for easier testing) and insert it with the=
 proto=20
> > parameter. I'd say "modprobe psmouse proto=3Dexps" works for you, but y=
ou might=20
> > want to try imps and ps2pp too. The reason I wrote the patch in the fir=
st=20
> > place was that a lot of PS/2 Logitech mice refused to work (and yes, ex=
ps=20
> > works for me and others)....
>=20
>    didn't help, I still see (without X running):
>=20
> 8, 0, 0 any button down
> 9, 0, 0 left button up
> 12, 0, 0 wheel up, sidebutton up
> 10, 0, 0 right button up
>=20
> 8, 0, 0 wheel rotation (any direction)
>=20
> except of some protocols (IIRC ps2pp, bare, genps) ignore wheel=20
> completely. is there any way to verify which protocol the mouse is=20
> using? modprobe -v printed different messages for each protocol so I=20
> think that worked (it said Generic Explorer etc.)
>=20
>    I tried: exps, imps, ps2pp, bare, genps
>=20
>    any ideas?
>=20
>    the mouse says: Cordless MouseMan Wheel (Logitech), it has left/right=20
> buttonss, wheel that can be pushed or rotated and a side button, not=20
> sure how to better identify it. With 2.4 kernels it used to work with X=20
> using protocol MouseManPlusPS/2.

IMPS/2 here:
    Option "Protocol"    "IMPS/2"
    Option "Device"      "/dev/mouse"
    Option "ZAxisMapping" "4 5"

Craig



--=-wpNsNVkrBTPMnaAKQ48I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiigsi+pIEYrr7mQRAgo4AJ457p0QVohbf+1WqDLxr9reUnsXoACcD47M
q7ekvu09MBdRsqc2iaIddgs=
=0Ni3
-----END PGP SIGNATURE-----

--=-wpNsNVkrBTPMnaAKQ48I--

