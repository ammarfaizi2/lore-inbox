Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVAYJZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVAYJZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 04:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVAYJZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 04:25:44 -0500
Received: from gate.adanco.com ([212.25.16.151]:30212 "EHLO johnny.adanco.com")
	by vger.kernel.org with ESMTP id S261827AbVAYJZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 04:25:31 -0500
From: Adrian von Bidder <avbidder@fortytwo.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Date: Tue, 25 Jan 2005 10:25:29 +0100
User-Agent: KMail/1.7.2
References: <20050124222449.GB16078@venus>
In-Reply-To: <20050124222449.GB16078@venus>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3054908.r1YR6YK8Y2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501251025.29624@fortytwo.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3054908.r1YR6YK8Y2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 January 2005 23.24, Edward Peschko wrote:
[ Linux interoperability in danger - libc !=3D libc ]

Hi,

[this may be just ignorance - I only use one distro (Debian), and don't try=
=20
to mix binaries]

Before discussing solutions: Is there a survey on how bad the problem reall=
y=20
is?  IIRC some minor API changes were done between some gcc versions, but=20
mostly on the C++ side.  I know Debian, too, ships with a quite heavily=20
patched toolchain, but the Debian libc/binutils/gcc packagers work together=
=20
with the upstream developers, and many Debian specific patches end up in=20
the official releases sooner or later. (And most of Debian's patches=20
concern architectures like ARM, m68k, HPPA etc., which the big=20
distributions don't support anyway.)

So, I guess, the survey would need to compare only C programs (not C++),=20
since you explicitly are talking about libc - C++ has always been more=20
difficult.  And, it would be important to differentiate between=20
incompatibilites caused by gcc versions from incompatibilities really=20
caused by vendor specific modifications.

cheers
=2D- vbi

P.S.: looking at Debian's libc6 glibc package (2.3.2.ds1-20):
 - 106 patches total
Going by the name of the patch files only:
 - 8 hurd specific
 - 4 arm specific
 - 9 hppa specific
 - 4 m68k specific
 - 3 alpha specific
 - 1 amd64 specific
 - 1 x86 specific
 - 4 sparc specific
 - 5 mips specific
 - 3 ppc specific
 - 1 ia64 specific
 - 3 s390 specific
 - 4 correcting paths/build system only (wouldn't affect the libc API as=20
such)
 - 15 locale specific (dito)

So, over half of the patches will likely not affect 95% of Linux users.  Of=
=20
the rest, a good number clearly affect multithreaded programs only (which,=
=20
admittedly, are much more widespread now than a few years back.)  I didn't=
=20
look at any patches at all, so I can't judge how much the patches do really=
=20
change the libc.  Also, I can't say how intrusive the patches of other=20
distributions are.

=2D-=20
We are not loved by our friends for what we are; rather, we are loved in
spite of what we are.
  -- Victor Hugo

--nextPart3054908.r1YR6YK8Y2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: get my key from http://fortytwo.ch/gpg/92082481

iKcEABECAGcFAkH2EIlgGmh0dHA6Ly9mb3J0eXR3by5jaC9sZWdhbC9ncGcvZW1h
aWwuMjAwMjA4MjI/dmVyc2lvbj0xLjUmbWQ1c3VtPTVkZmY4NjhkMTE4NDMyNzYw
NzFiMjVlYjcwMDZkYTNlAAoJECqqZti935l6+AgAoIykhWjVuNA2S1LJEBqtmaN8
JASrAJ9Ms2ZN/Q6Dpdy3CGvD1qq3xzDI/Q==
=XkFU
-----END PGP SIGNATURE-----

--nextPart3054908.r1YR6YK8Y2--
