Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJYNMy>; Fri, 25 Oct 2002 09:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJYNMy>; Fri, 25 Oct 2002 09:12:54 -0400
Received: from B52cd.pppool.de ([213.7.82.205]:49118 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261395AbSJYNMx>; Fri, 25 Oct 2002 09:12:53 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Daniel Egger <degger@fhm.edu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <3DB849EF.1050904@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
	<1035483003.5680.13.camel@sonja.de.interearth.com> 
	<3DB849EF.1050904@colorfullife.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-JxhYQnIr9GwFIXINlAgP"
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Oct 2002 15:08:57 +0200
Message-Id: <1035551337.1360.6.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JxhYQnIr9GwFIXINlAgP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2002-10-24 um 21.28 schrieb Manfred Spraul:

> It seems the via cpu doesn't support prefetchnta. Could you try the=20
> attached version?

egger@tanja:~$ ./via=20
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 24318 cycles per page
copy_page function '2.4 non MMX'         took 35819 cycles per page
copy_page function '2.4 MMX fallback'    took 35921 cycles per page
copy_page function '2.4 MMX version'     took 24291 cycles per page
Illegal instruction

Unfortunately I have no space for gdb on it right now sow I cannot
easily debug where it crashes.=20

BTW: I did the same thing you did: Remove the calls to the obviously
offending calls to the "fast" versions. I've no idea why the no_prefetch
version doesn't, though...=20

--=20
Servus,
       Daniel

--=-JxhYQnIr9GwFIXINlAgP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQA9uUJpchlzsq9KoIYRAmVIAJ9h1Y48yKomb1a/Grv25i++WV2hHACfbh5W
vrDAO8REn+eq+jxwtwbPBOs=
=4p90
-----END PGP SIGNATURE-----

--=-JxhYQnIr9GwFIXINlAgP--

