Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTJFVu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJFVu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:50:27 -0400
Received: from D7190.pppool.de ([80.184.113.144]:48278 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261680AbTJFVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:50:25 -0400
Subject: Re: Extremely low disk performance on K7S5A Pro
From: Daniel Egger <degger@fhm.edu>
To: Andreas Schwarz <usenet@andreas-s.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrnbo3kmg.4af.usenet@home.andreas-s.net>
References: <slrnbnoi5i.3re.usenet@home.andreas-s.net>
	 <3F813E19.7020303@inet6.fr>  <slrnbo3kmg.4af.usenet@home.andreas-s.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Eqn8DwTOzv4rggUN3emk"
Message-Id: <1065476679.13868.2.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 06 Oct 2003 23:44:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Eqn8DwTOzv4rggUN3emk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, den 06.10.2003 schrieb Andreas Schwarz um 22:38:

> >># hdparm -tT /dev/hda                                                  =
        =20
> >>/dev/hda:                                                              =
        =20
> >> Timing buffer-cache reads:   824 MB in  2.00 seconds =3D 411.65 MB/sec=
          =20
> >> Timing buffered disk reads:   10 MB in  3.28 seconds =3D   3.05 MB/sec

Eek, thanks to you I just figured out that one of my fileserver
harddrives has degraded its connection settings. After reactivating DMA
though I have the usual speeds also on a K7S5A:

egger@karin:~$ sudo hdparm -tT /dev/hdc
=20
/dev/hdc:
 Timing buffer-cache reads:   800 MB in  2.00 seconds =3D 400.00 MB/sec
 Timing buffered disk reads:  120 MB in  3.01 seconds =3D  39.87 MB/sec

egger@karin:~$ sudo hdparm -tT /dev/hda
=20
/dev/hda:
 Timing buffer-cache reads:   800 MB in  2.00 seconds =3D 400.00 MB/sec
 Timing buffered disk reads:   82 MB in  3.00 seconds =3D  27.33 MB/sec

--=20
Servus,
       Daniel

--=-Eqn8DwTOzv4rggUN3emk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/geJHchlzsq9KoIYRAt9UAJ94hy1DJZTCVt7UhWR0UFbJ5DMPMQCfY46q
Djf9j9253p9P4Br52sVfaNY=
=20/1
-----END PGP SIGNATURE-----

--=-Eqn8DwTOzv4rggUN3emk--

