Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUGKNCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUGKNCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUGKNCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:02:46 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:61639 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S266582AbUGKNCo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:02:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: GCC 3.4 and broken inlining.
Date: Sun, 11 Jul 2004 15:01:18 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, aoliva@redhat.com,
       ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
References: <2fG2F-4qK-3@gated-at.bofh.it> <20040711013218.414941ce.akpm@osdl.org> <20040711115039.GD4701@fs.tum.de>
In-Reply-To: <20040711115039.GD4701@fs.tum.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hoT8AkSMiJr3HJR";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407111501.21769.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_hoT8AkSMiJr3HJR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 11. Juli 2004 13:50, Adrian Bunk wrote:
> -#if __GNUC_MINOR__ >=3D 1 =A0&& __GNUC_MINOR__ < 4
> +#if __GNUC_MINOR__ >=3D 1
> =A0# define inline=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__inlin=
e__ __attribute__((always_inline))
> =A0# define __inline__=A0=A0=A0=A0__inline__ __attribute__((always_inline=
))
> =A0# define __inline=A0=A0=A0=A0=A0=A0__inline__ __attribute__((always_in=
line))

While we're there, shouldn't this really be the following?

# define inline=A0=A0=A0=A0=A0=A0=A0  =A0inline   __attribute__((always_inl=
ine))
# define __inline__=A0=A0=A0=A0__inline__ __attribute__((always_inline))
# define __inline=A0=A0=A0=A0=A0=A0__inline   __attribute__((always_inline))

I find it somewhat annoying that the preprocessor expands every "inline"
to "__inline__ __attribute__((always_inline)) __attribute__((always_inline)=
)"
in the current code.

	Arnd <><

--Boundary-02=_hoT8AkSMiJr3HJR
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8Toh5t5GS2LDRf4RAh+VAJ93Wc0Qv4imBGWxCe1SoubqCR7qQACeN8sv
2IeyZmX8MLscD7gmrqRMoRI=
=Sspq
-----END PGP SIGNATURE-----

--Boundary-02=_hoT8AkSMiJr3HJR--
