Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWKMV0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWKMV0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933065AbWKMV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:26:05 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:45245 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932306AbWKMV0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:26:02 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Stelian Pop <stelian@popies.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Jean Delvare <khali@linux-fr.org>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1163451174.23807.18.camel@localhost.localdomain>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
	 <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
	 <1163434455.23444.14.camel@localhost.localdomain>
	 <d120d5000611131020y69bdada1hfe694583312f9b61@mail.gmail.com>
	 <1163451174.23807.18.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9sH/b6fd1c5GAsM1ooWc"
Date: Mon, 13 Nov 2006 22:23:59 +0100
Message-Id: <1163453039.5399.19.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9sH/b6fd1c5GAsM1ooWc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> The fact that the accelerometer offers a (low res) joystick emulation is
> only a nice hack and I'm not even sure somebody (except Johannes) will
> find an use for it.

Heh. Well I think it's fun once a while :)

On Mon, 2006-11-13 at 21:52 +0100, Stelian Pop wrote:
>=20
> +               x -=3D ams_info.xcalib;
> +               y -=3D ams_info.ycalib;
> +               z -=3D ams_info.zcalib;
> +
> +               input_report_abs(ams_info.idev, ABS_X, invert ? -x : x);
> +               input_report_abs(ams_info.idev, ABS_Y, invert ? -y : y);
> +               input_report_abs(ams_info.idev, ABS_Z, z - ams_info.zcali=
b);=20

You're double-calibrating z now, which is surely not what was intended.

johannes

--=-9sH/b6fd1c5GAsM1ooWc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARVjibqVg1VMiehFYAQKegw/9Fxtdli5rBOmgaLWNzfLsElkdJvCeyxq0
0l5fEBBtNegCBAOXwxltqc5CwM6MYhPG3X8L0rYbNOxStbzwoeMcddllLmF8n12i
kWaP9vDHYS+5VB6yRudG0v5Qc7KjYzoLoa/5OqHcgRjJxST0h1MeGksUxGaEuNBN
ulMNqqwNLjfaCqaFU8PAluPjNMD2AxvhSOrAVYUeI1M0UJ8IX5zRpvgCztoQ5G/I
Oml9gmAy0vUm/b56DJI/igDRqgwg/cSNl+q0+D8txgz+6arnYgulDrDkvQVnhAi2
QLmxX31n6M9hw/EdR5p+SZ7uG6MhEqxx6p9rrAMazW7M+Z1W4ikEM7B9qUcLqdwT
lCTmlV9L1lLcPrD8kLNed0uGB1c2K2PWJRTWtSKbXAJyr0f7o1yek+h5KDbb4bbg
Q5gfqWwGunAg1WtohxxZIZPklqIc8uHW6y+tbQe5m5vqQgthLsGJhqxaO93dZ88g
2gaiOx1HylCN4EJh94dEDoZzEOobtBVAxeg1PvIB6JZqfa7eD3Hwgx4CHUUKIcJd
sWFeCiyULMKZsVHQPdbCWqZUNFYekx2VJRBLsA+Rp/MU4T1ywVjFZ2FxZrRZ2OWL
N3ZO6eYqNErJsIi2lAbTCdo/ODu+Jvfm/moGD8fST9O9Tt20Y0mJNVncPyjVIGjj
iqCTYfwF+bc=
=Ll25
-----END PGP SIGNATURE-----

--=-9sH/b6fd1c5GAsM1ooWc--

