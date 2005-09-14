Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVIMUpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVIMUpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIMUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:45:23 -0400
Received: from sls-ce5p321.hostitnow.com ([72.9.236.50]:53896 "EHLO
	sls-ce5p321.hostitnow.com") by vger.kernel.org with ESMTP
	id S1750820AbVIMUpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:45:22 -0400
From: Chris White <chriswhite@gentoo.org>
Reply-To: chriswhite@gentoo.org
Organization: Gentoo
To: Margit Schubert-While <margitsw@t-online.de>
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
Date: Wed, 14 Sep 2005 14:14:02 +0900
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de>
In-Reply-To: <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2245454.KkMLN6mbIZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509141414.08343.chriswhite@gentoo.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p321.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gentoo.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2245454.KkMLN6mbIZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 13 September 2005 15:04, Margit Schubert-While wrote:
> In arch/i386/makefile we have :
> cflags-$(CONFIG_MPENTIUMII) =A0 =A0 +=3D -march=3Di686 $(call
> cc-option,-mtune=3Dpentium2)
> cflags-$(CONFIG_MPENTIUMIII) =A0 =A0+=3D -march=3Di686 $(call
> cc-option,-mtune=3Dpentium3)
> cflags-$(CONFIG_MPENTIUMM) =A0 =A0 =A0+=3D -march=3Di686 $(call
> cc-option,-mtune=3Dpentium3)
> cflags-$(CONFIG_MPENTIUM4) =A0 =A0 =A0+=3D -march=3Di686 $(call
> cc-option,-mtune=3Dpentium4)
>
> According to the gcc 3.x doc, the -mtune is not avaliable for i686
> and, indeed, with 3.3.5 no -mtune is generated/used (make V=3D1).

That's correct, gcc 3.4 started the -mtune flag.  Chances are if you really=
=20
want the -mtune optimizations you're going to have to upgrade to gcc 3.4 or=
=20
greater.

> This, of course, heavily penalizes P4's (the notorious inc/dec).

Are you referring to cpu cycle counts?  Is there certain code that causes t=
he=20
kernel to perform that unfavorably by a large scale?

> Margit

Chris White

--nextPart2245454.KkMLN6mbIZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDJ7GgFdQwWVoAgN4RAs4lAJ9Lj3Nne7U1P1Dj6MvmZH8RKGMkIgCgq2fu
8IEoDhvlAnbQhiS9WbDY93U=
=Eby5
-----END PGP SIGNATURE-----

--nextPart2245454.KkMLN6mbIZ--
