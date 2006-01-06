Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWAFLSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWAFLSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWAFLST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:18:19 -0500
Received: from mout0.freenet.de ([194.97.50.131]:57222 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932135AbWAFLST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:18:19 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 5/7]  uninline capable()
Date: Fri, 6 Jan 2006 12:18:17 +0100
User-Agent: KMail/1.8.3
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544160.2940.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1136544160.2940.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1509288.WjeIDJWFcG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601061218.17369.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1509288.WjeIDJWFcG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 06 January 2006 11:42, you wrote:
> Index: linux-2.6.15/include/linux/sched.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/include/linux/sched.h
> +++ linux-2.6.15/include/linux/sched.h
> @@ -1102,19 +1102,8 @@ static inline int sas_ss_flags(unsigned=20
>  }
> =20
> =20
> -#ifdef CONFIG_SECURITY
> -/* code is in security.c */
> +/* code is in security.c or kernel/sys.c if !SECURITY */
>  extern int capable(int cap);

BTW, is there a special reason why this is declared in sched.h
instead of capability.h?

=2D-=20
Greetings Michael.

--nextPart1509288.WjeIDJWFcG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDvlH5lb09HEdWDKgRAn9rAJ9/TE7Ngk1aDy6l5DiFCpaThE99WgCgks4q
OZTPZGeD3x7h8yaDA1GatJM=
=YhND
-----END PGP SIGNATURE-----

--nextPart1509288.WjeIDJWFcG--
