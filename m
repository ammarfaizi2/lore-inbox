Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUJIMer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUJIMer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 08:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUJIMer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 08:34:47 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:12014 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266756AbUJIMep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 08:34:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Jin, Gordon" <gordon.jin@intel.com>
Subject: Re: [PATCH x86_64]: Add TCSBRKP ioctl translation for arch/x86_64/ia32
Date: Sat, 9 Oct 2004 14:31:45 +0200
User-Agent: KMail/1.6.2
Cc: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
References: <8126E4F969BA254AB43EA03C59F44E848AF8D0@pdsmsx404>
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E848AF8D0@pdsmsx404>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_0o9ZBG5cp91L27R";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410091431.48915.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_0o9ZBG5cp91L27R
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 09 Oktober 2004 11:47, Jin, Gordon wrote:
> --- linux-2.6.8/arch/x86_64/ia32/ia32_ioctl.c.orig=A0=A0=A0=A0=A0=A02004-=
09-23 09:21:20.000000000 -0700
> +++ linux-2.6.8/arch/x86_64/ia32/ia32_ioctl.c=A0=A0=A02004-09-23 09:22:31=
=2E000000000 -0700
> @@ -189,6 +189,7 @@ COMPATIBLE_IOCTL(RTC_SET_TIME)
> =A0COMPATIBLE_IOCTL(RTC_WKALM_SET)
> =A0COMPATIBLE_IOCTL(RTC_WKALM_RD)
> =A0COMPATIBLE_IOCTL(FIOQSIZE)
> +COMPATIBLE_IOCTL(TCSBRKP)
> =A0
> =A0/* And these ioctls need translation */
> =A0HANDLE_IOCTL(TIOCGDEV, tiocgdev)

This is not the optimal solution, for two reasons:

=2D If it is needed on all architectures, you should instead remove it
  from the ones that currently define it and put it in
  include/linux/compat_ioctl.h.

=2D It is not actually COMPATIBLE_IOCTL, but rather ULONG_IOCTL,
  as far as I can tell. Yes, I made the same mistake in
  arch/s390/kernel/compat_ioctl.c, but you can fix it now
  that you are touching it anyway.

	Arnd <><

--Boundary-02=_0o9ZBG5cp91L27R
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBZ9o05t5GS2LDRf4RAhNfAKCbRwd1AGd7NJ4RVRoJ3wz9VXxx6wCeOvzw
x7W6wwGCbqIEZGFJmwTGCJM=
=zpdZ
-----END PGP SIGNATURE-----

--Boundary-02=_0o9ZBG5cp91L27R--
