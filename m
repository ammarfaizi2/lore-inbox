Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWBAJRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWBAJRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWBAJNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:13:35 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:57836 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932339AbWBAJDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:32 -0500
Date: Wed, 1 Feb 2006 10:03:24 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Joachim Breitner <mail@joachim-breitner.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] [CM4000,CM4040] Add device class bits to enable udev device creation
Message-ID: <20060201090324.GA31060@sunbeam.de.gnumonks.org>
References: <1138536696.6509.9.camel@otto.ehbuehl.net> <1138541796.6395.8.camel@otto.ehbuehl.net> <20060131101046.GS4603@sunbeam.de.gnumonks.org> <200601312259.32863.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <200601312259.32863.dtor_core@ameritech.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2006 at 10:59:32PM -0500, Dmitry Torokhov wrote:
> On Tuesday 31 January 2006 05:10, Harald Welte wrote:
> > @@ -756,6 +762,10 @@ static struct pcmcia_driver reader_drive
> > =A0static int __init cm4040_init(void)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "%s\n", version);
> > +=A0=A0=A0=A0=A0=A0=A0cmx_class =3D class_create(THIS_MODULE, "cmx");
> > +=A0=A0=A0=A0=A0=A0=A0if (!cmx_class)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> > +
> >=20
>=20
>=20
> Hi,
>=20
> What is "cmx" exactly? Can we have more descriptive name for a class,
> please?

'cmx' is the prefix of the device names, how the original vendor drivers
named their devices.  'cmm' in the cm4000 case is 'card man mobile'.
'cmx' is its successor, cm4040.

I'll rename the classes, thanks for your suggestion.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4HlcXaXGVTD0i/8RAhnmAJ9d6rvZsU5SRprpRstJJLfqbDBefwCfZXd/
m1tjyXqeJ7Ws5XQ0W3v4LRw=
=1OSa
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
