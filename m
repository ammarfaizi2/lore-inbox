Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUBWDeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUBWDeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:34:18 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:21131 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261794AbUBWDeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:34:10 -0500
Date: Sun, 22 Feb 2004 19:34:08 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-ID: <20040223033408.GB26929@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2004 at 05:22:00PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3=
-mm2/

Rusty's patch 'add-MODULE_VERSION-macro.patch' is missing a change that
results in modules_install installing all of the modules AND their
constituent source files into /lib/modules. The change, which did appear
in Makefile.modpost correctly, follows here.

--- scripts/Makefile.modinst~	2004-02-22 19:31:28.000000000 -0800
+++ scripts/Makefile.modinst	2004-02-22 19:31:49.000000000 -0800
@@ -9,7 +9,7 @@
=20
 #
=20
-__modules :=3D $(shell cat /dev/null $(wildcard $(MODVERDIR)/*.mod))
+__modules :=3D $(shell head -q -n1 $(wildcard $(MODVERDIR)/*.mod))
 modules :=3D $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=3D.o)))
=20
 ifneq ($(filter-out $(modules),$(__modules)),)
=20
--=20
Joshua Kwan

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQDl0rqOILr94RG8mAQL8FxAAhQeuYImRos5pfO9Qsl20iPBViB428inf
9wNAZkqfmvyVOM1VFMDPUikxvcUVmq8cDWdEh1MFQBz5JhRfWpCiwYUyV9b3JdxL
DZ1oDwo4p0sQlkOHXayYNiadOI/K3jwCskKvsuMiHOjLbt9h1hkEJcPb6wBI6jhC
Wb1ZoPUAvig2JJLiqPC0UCNULdChs5MSKPu4tr2XF+XZrBHQnAE3cxBP+Vf58yvY
DYPflg6vYi7e6vmVWu39FutzE/r8mRSh1aPZStG1tdmsTEoZmDCz/poPdZTjaOlW
+9Uh8GgFiI56b3dopNWL0BTwQ5r3m1idV8C6xoUTCIFspBpr/WqgYouSYYRcJ014
BSoA4oW/3E1CYqU8G5E0zlSbsX86E3QGOl+dcL641/Vu7ZFXZMO6qbw1izNOFWDV
LD9JrJZISl/M+Iu1RLLZIbB4PpHT8Z9UDren5yyc8vNOy1weISONUums/WzlZ8af
P+87XTEGgvlun6rZoQcaYDnGiCTgTlvTURwJa2efyKFMrMLEgRx/50WDHLEg5h9D
xzG4I7rCgh1iJBVbDSTFubede49szLsXDHdzEgeMg/r3Ot1UFiR/mxR1p6mS3CR7
woJJW8faExOcFjAyAiOnuBzVjBXq9G1PRs8zpyTGgDQJrvkMgOlvEyhLh9xEAfno
0xEjC1Xj+mo=
=hyJT
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
