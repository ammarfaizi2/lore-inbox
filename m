Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTLLWuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLLWux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:50:53 -0500
Received: from smtp3.USherbrooke.ca ([132.210.244.19]:9961 "EHLO
	smtp3.usherbrooke.ca") by vger.kernel.org with ESMTP
	id S262129AbTLLWuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:50:52 -0500
Subject: Re: Increasing HZ (patch for HZ > 1000)
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031212221045.GB314@elf.ucw.cz>
References: <1071122742.5149.12.camel@idefix.homelinux.org>
	 <1288980000.1071126438@[10.10.2.4]>
	 <1071216053.4187.22.camel@idefix.homelinux.org>
	 <20031212221045.GB314@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-diOFsEaosL31U33Fo9kO"
Organization: Universite de Sherbrooke
Message-Id: <1071269429.4182.6.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 12 Dec 2003 17:50:30 -0500
X-UdeS-MailScanner-Information: Veuillez consulter le http://www.usherbrooke.ca/vers/virus-courriel
X-UdeS-MailScanner: Aucun code suspect =?ISO-8859-1?Q?d=E9tect=E9?=
X-MailScanner-SpamCheck: n'est pas un polluriel, SpamAssassin (score=-4.9,
	requis 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-diOFsEaosL31U33Fo9kO
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> Well, on i386 we only run with HZ=3D100 and HZ=3D1000, so bug is latent,
> but if you can find nice way to rewrite it without the bug, it would
> probably be worth fixing.

Actually, the way I rewrote it in the patch is immune to that kind of
problem:

seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
           HZ*(c->loops_per_jiffy>>3)/62500,
           (HZ*(c->loops_per_jiffy>>3)/625)%100);

It will work correctly for any HZ up to ~34000 bogomips (using 32-bit
arithmetic).

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-diOFsEaosL31U33Fo9kO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2kY0dXwABdFiRMQRAuteAJ9pg2wOqq5bLNHaJw+OiV1BvaOgDgCfQ4nc
DO+3j+UaIaqJQYuSmPlm+rs=
=yd3h
-----END PGP SIGNATURE-----

--=-diOFsEaosL31U33Fo9kO--

