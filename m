Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265600AbSJXSPt>; Thu, 24 Oct 2002 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbSJXSPt>; Thu, 24 Oct 2002 14:15:49 -0400
Received: from D0528.pppool.de ([80.184.5.40]:9942 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265600AbSJXSPr>; Thu, 24 Oct 2002 14:15:47 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Daniel Egger <degger@fhm.edu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-CykNSeDlEQ5mgrYmSslu"
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 20:10:03 +0200
Message-Id: <1035483003.5680.13.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CykNSeDlEQ5mgrYmSslu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2002-10-24 um 19.15 schrieb Manfred Spraul:

> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,=20
> chipset and memory type?

SiS 735, Duron 1200, 512 MB PC133 (running at 100Mhz).

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 19860 cycles per page
copy_page function '2.4 non MMX'         took 21205 cycles per page
copy_page function '2.4 MMX fallback'    took 21262 cycles per page
copy_page function '2.4 MMX version'     took 19893 cycles per page
copy_page function 'faster_copy'         took 12746 cycles per page
copy_page function 'even_faster'         took 13112 cycles per page
copy_page function 'no_prefetch'         took 10217 cycles per page

Being interested in seeing how the Via Ezra system here performs I also
ran it there but experienced three segfaults in the last three tests;=20
two of which I can explain, but no_prefetch is a stranger right now.
Anyway:

PLE133, Via Ezra 667 Mhz, 128 MB PC100 (probably at 66Mhz)
egger@tanja:~$ ./athlon=20
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 23213 cycles per page
copy_page function '2.4 non MMX'         took 34971 cycles per page
copy_page function '2.4 MMX fallback'    took 34958 cycles per page
copy_page function '2.4 MMX version'     took 22774 cycles per page

--=20
Servus,
       Daniel

--=-CykNSeDlEQ5mgrYmSslu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQA9uDd7chlzsq9KoIYRAhFwAJ9SLQ4bvvd+UXRUPoVtRxrFoRxnfACdEe1x
/Nho94qBEinlX2K5HrDcBac=
=RAzA
-----END PGP SIGNATURE-----

--=-CykNSeDlEQ5mgrYmSslu--

