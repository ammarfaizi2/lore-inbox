Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVANJa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVANJa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVANJa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:30:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22153 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261857AbVANJag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:30:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org, mjw@us.ibm.com
Subject: Re: [PATCH] PPC64: 32bit wrapper for ioctls.
Date: Fri, 14 Jan 2005 10:23:07 +0100
User-Agent: KMail/1.6.2
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
References: <41E6C1FF.4000203@us.ltcfwd.linux.ibm.com>
In-Reply-To: <41E6C1FF.4000203@us.ltcfwd.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200501141023.08156.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_8945BI5w26YN1v/";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_8945BI5w26YN1v/
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 13 Januar 2005 19:46, Mike Wolf wrote:
> Hi Paul,
> =A0 The patch adds some 32bit wrappers for 2 ioctls that Java needs.
> Assuming this doesn't generate a round of discussion, please
> forward upstream to akpm/torvalds.

Why add them to arch/ppc64? These don't look architecture specific, so they
should go into include/linux/compat_ioctl.h.=20

> --- linus-0112.orig/arch/ppc64/kernel/ioctl32.c=A02005-01-13 10:35:10.165=
539000 -0600
> +++ linus-0112/arch/ppc64/kernel/ioctl32.c=A0=A0=A0=A0=A0=A02005-01-13 10=
:51:43.450433277 -0600
> @@ -43,6 +43,8 @@
> =A0COMPATIBLE_IOCTL(TIOCSTART)
> =A0COMPATIBLE_IOCTL(TIOCSTOP)
> =A0COMPATIBLE_IOCTL(TIOCSLTC)
> +COMPATIBLE_IOCTL(TIOCMIWAIT)

Note that TIOCMIWAIT is not COMPATIBLE_IOCTL, but ULONG_IOCTL. It doesn't m=
ake
a difference for ppc64, but if you add it to the generic file that is neede=
d for
s390x.

	Arnd <><



--Boundary-02=_8945BI5w26YN1v/
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB54985t5GS2LDRf4RAmN8AJ49XzALCE6Jexn08pEMpAuEnaKOmgCfYq/d
hjf2FPKcAdO6w1oqyKX9E10=
=93nR
-----END PGP SIGNATURE-----

--Boundary-02=_8945BI5w26YN1v/--
