Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271692AbTGREiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 00:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271693AbTGREiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 00:38:51 -0400
Received: from mail.donpac.ru ([217.107.128.190]:17861 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S271692AbTGREit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 00:38:49 -0400
Date: Fri, 18 Jul 2003 08:53:35 +0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 954] New: link failure for arch/ppc/mm/built-in.o, function mem_pieces_find
Message-ID: <20030718045335.GA12803@pazke>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <5310000.1058499045@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <5310000.1058499045@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -11.5 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 198, 07 17, 2003 at 08:30:45 -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=3D954
>=20
>            Summary: link failure for arch/ppc/mm/built-in.o, function
>                     mem_pieces_find
>     Kernel Version: 2.6.0-test1 + cset-20030717_2009
>             Status: NEW
>           Severity: blocking
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: barryn@pobox.com
>=20
>=20
> Distribution: Gentoo
> Hardware Environment: 400MHz Apple PowerMac G4 (AGP Graphics model)
> Software Environment: gcc 2.95.3, binutils 2.12.90.0.7 20020423
> Problem Description:
> When I try to compile linux-2.6.0-test1 + the cset-20030719_2009 patch (i=
=2Ee.,
> the latest BitKeeper snapshot on kernel.org as of this writing), I get th=
is
> compile error:
>   LD      .tmp_vmlinux1
> arch/ppc/mm/built-in.o: In function `mem_pieces_find':
> arch/ppc/mm/built-in.o(.init.text+0x8f8): undefined reference to `__va'
> arch/ppc/mm/built-in.o(.init.text+0x8f8): relocation truncated to fit:
> R_PPC_REL24 __va
> make: *** [.tmp_vmlinux1] Error 1

Does this one-line patch helps ?

diff -u linux-2.6.0-test1.vanilla/arch/ppc/mm/mem_pieces.c linux-2.6.0-test=
1/arch/ppc/mm/mem_pieces.c
--- linux-2.6.0-test1.vanilla/arch/ppc/mm/mem_pieces.c	2003-07-18 08:47:49.=
000000000 +0400
+++ linux-2.6.0-test1/arch/ppc/mm/mem_pieces.c	2003-07-18 08:48:53.00000000=
0 +0400
@@ -19,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/blk.h>
 #include <linux/init.h>
+#include <asm/page.h>
=20
 #include "mem_pieces.h"
=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/F31Pby9O0+A2ZecRAiE2AJ9lJ0CAcLbegbcwYWh+VNWAdiim8QCfT+57
qL949pMSa0k7s0uImRqqJPM=
=vnW7
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
