Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbTHaKI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbTHaKI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:08:29 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:48043
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S262309AbTHaKI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:08:27 -0400
Subject: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Kumlien <pomac@vapor.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4lfxr6nPt3fggG0GijIk"
Message-Id: <1062324435.9959.56.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 12:07:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4lfxr6nPt3fggG0GijIk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I'll risk sounding like a moron again =3D)

I still wonder about the counter intuitive quantum value for
processes... (or timeslice if you will)

Why not use small quantum values for high pri processes and long for low
pri since the high pri processes will preempt the low pri processes
anyways. And for a server working under load with only a few processes
(assuming they are all low pri) would lessen the context switches.

And a system with "interactive load" as well would, as i said, preempt
the lower pris. But this could also cause a problem... Imho there should
be a "min quantum value" so that processes can't preempt a process that
was just scheduled (i dunno if this is implemented already though).=20

Imho this would also make it easy to get the right pri for highpri
processes since the quantum value is smaller and if you use it all up
you get demoted.

Anyways, I've been wondering about the inverted values in the scheduler
and for a mixed load/server load i don't see the benefit... =3DP

PS. Do not forget to CC me since i'm not on this list...
DS.

--=20
Ian Kumlien <pomac@vapor.com>

--=-4lfxr6nPt3fggG0GijIk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/UcjS7F3Euyc51N8RAie9AJ0T2f/KVoF+mZZTsJRBiAC3HfAL5ACeJzgT
7jtB/8s+w27ywGnXlvrfkDs=
=aUyv
-----END PGP SIGNATURE-----

--=-4lfxr6nPt3fggG0GijIk--

