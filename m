Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbTGLJzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbTGLJzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 05:55:00 -0400
Received: from mx.laposte.net ([213.30.181.11]:26780 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S267274AbTGLJy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 05:54:58 -0400
Subject: MCE exception advice
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-88UIjt2TGOzUB9Pq0ntt"
Organization: Adresse personnelle
Message-Id: <1058004581.6808.10.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jul 2003 12:09:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-88UIjt2TGOzUB9Pq0ntt
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[ Please CC me on answers since I'm not on the list ]

Hi,

	I've been getting MCE's repeatedly today when trying to compile
2.5.75-bk1 on 2.5.75-bk1 (obviously I didn't have them yesterday when I
build my first 2.5.75-bk1 kernel on a 2.4 kernel).

	The MCE is always the same (I think) and reads like this :

CPU 0: Machine Check Exception: 0000000000000004
Bank 0: b600000000000135 at 000000000b99b9f0
Kernel panic: CPU context corrupt

	Which when decoded with parsemce gives :

[nim@rousalka parse]$ ./parse -i < mce
CPU 0
Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(0): b600000000000135 @ b99b9f0
        External tag parity error
        CPU state corrupt. Restart not possible
        Address in addr register valid
        Error enabled in control register
        Error not corrected.
        Memory heirarchy error
        Request: Generic error
        Transaction type : Data
        Memory/IO : Reserved

	I'd like to have some advice on what to do next. Is this a 2.5 bug ? An
hardware problem only triggered in 2.5 because it exercises the harware
in a different way ? Should I change something in the system ? If so,
should I change memory, cpu, psu, something else ?

	I don't usually build 2.5 on 2.5, but again yesterday was very hot and
hardware might have suffered (the best case cooling can not do much with
room temperature =3D 30+ =B0C)

	Any hint will be welcome - this is my first mce encounter.

Regards,

--=20
Nicolas Mailhot

--=-88UIjt2TGOzUB9Pq0ntt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/D95kI2bVKDsp8g0RAgJkAKCO9LhVaqnZ4FFi1dWbSMTnwmVppgCgqs22
6CUh4iJSYwXUQEpIEG7GEhQ=
=jQVv
-----END PGP SIGNATURE-----

--=-88UIjt2TGOzUB9Pq0ntt--

