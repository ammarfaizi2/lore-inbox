Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267941AbUHEUod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267941AbUHEUod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267963AbUHEUnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:43:14 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:19124 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267949AbUHEUlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:41:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] cputime (3/6): move jiffies stuff to jiffies.h
Date: Thu, 5 Aug 2004 22:40:39 +0200
User-Agent: KMail/1.6.2
References: <20040805180438.GD9240@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20040805180438.GD9240@mschwid3.boeblingen.de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu, arjanv@redhat.com,
       tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com, crisw@osdl.org,
       jan.glauber@de.ibm.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_KtpEBoer+07ZGel";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408052240.42719.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_KtpEBoer+07ZGel
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Donnerstag, 5. August 2004 20:04, Martin wrote:
> Move all that lovely jiffies related functions into ONE file,
> include/linux/jiffies.h. Since times.h is almost empty after the
> jiffies conversion functions have been moved, move the remaining
> definition of struct tms to include/linux/time.h. Replace all
> includes of <linux/times.h> with <linux/time.h> and kill times.h.
>=20
> --- linux-2.6.8-rc3/include/linux/times.h=A0=A0=A0=A0=A0=A0=A0Wed Jun 16 =
07:18:57 2004
> +++ linux-2.6.8-s390/include/linux/times.h=A0=A0=A0=A0=A0=A0Thu Jan =A01 =
01:00:00 1970
> @@ -1,65 +0,0 @@
=2E..
> -
> -struct tms {
> -=A0=A0=A0=A0=A0=A0=A0clock_t tms_utime;
> -=A0=A0=A0=A0=A0=A0=A0clock_t tms_stime;
> -=A0=A0=A0=A0=A0=A0=A0clock_t tms_cutime;
> -=A0=A0=A0=A0=A0=A0=A0clock_t tms_cstime;
> -};
> -

This should probably stay in linux/times.h, in order to be moved
to abi/times.h one day. glibc has its own sys/times.h, but struct
tms simply belongs into times.h, not time.h, according to the
times man page.

	Arnd <><

--Boundary-02=_KtpEBoer+07ZGel
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEptK5t5GS2LDRf4RAgWhAJ9QjKymZGS/v3ZzDQNup4r1jWtRNQCgmD9d
dCmniTEi84+ivXParWbgdIs=
=7DCJ
-----END PGP SIGNATURE-----

--Boundary-02=_KtpEBoer+07ZGel--
