Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbVBCQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbVBCQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbVBCQda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:33:30 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:62939 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S262788AbVBCQdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:33:08 -0500
Date: Thu, 3 Feb 2005 17:33:05 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Pankaj Agarwal" <pankaj@toughguy.net>
Cc: "S Iremonger" <exxsi@bath.ac.uk>, <linux-os@analogic.com>,
       <linux-kernel@vger.kernel.org>, "Linux Net" <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
Message-ID: <20050203173305.65503be7@phoebee>
In-Reply-To: <019501c50a0b$fcf8a9c0$8d00150a@dreammac>
References: <001501c509ff$d4be02e0$8d00150a@dreammac>
	<Pine.LNX.4.61.0502031017430.9404@chaos.analogic.com>
	<015901c50a07$721f2620$8d00150a@dreammac>
	<Pine.GSO.4.53.0502031602400.21155@amos.bath.ac.uk>
	<019501c50a0b$fcf8a9c0$8d00150a@dreammac>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Thu__3_Feb_2005_17_33_05_+0100_hVNcF9T1ubZ6V8DF;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Thu__3_Feb_2005_17_33_05_+0100_hVNcF9T1ubZ6V8DF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Feb 2005 21:48:12 +0530
"Pankaj Agarwal" <pankaj@toughguy.net> bubbled:

> my fault...i'm able to copy it using -rf with CP. So, solution given
> by Dick  Johnson (Linux-OS) can be used, if all are unable to find
> what's the  problem...
>=20
> here's the output of the two commands you've asked for..
>=20
> [root@test usr]# ls -ld /usr/bin
> drwxr-xr-x    2 root     root        61440 Nov 21 20:30 /usr/bin
>=20
> [root@test usr]# lsattr -d /usr/bin
> su--ia------- /usr/bin

i =3D IMMUTABLE, so you are unable to modify it.
a =3D only append mode for writing
u =3D allow undelete
s =3D zero the file if deleted

but s and u should currently not work on ext2/3.

Try "chattr -iusa /usr/bin" as root.

--=20
MyExcuse:
bad ether in the cables

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Thu__3_Feb_2005_17_33_05_+0100_hVNcF9T1ubZ6V8DF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCAlJBmjLYGS7fcG0RAka5AKCGJF4gJKtrOveV2kPVYjCTcrqokgCghfxN
rW8ZoQOPwB/9F0XgnLZYDKw=
=ccKg
-----END PGP SIGNATURE-----

--Signature_Thu__3_Feb_2005_17_33_05_+0100_hVNcF9T1ubZ6V8DF--
