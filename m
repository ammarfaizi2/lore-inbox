Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUGMNvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUGMNvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUGMNvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:51:48 -0400
Received: from sp36.amenworld.com ([62.193.200.26]:672 "EHLO tuxedo-es.org")
	by vger.kernel.org with ESMTP id S265031AbUGMNvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:51:39 -0400
Subject: Kernel hacking option "Debug memory allocations" possible leak of
	PaX memory randomization
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gDts9ZCTauW/gL/Gvh8D"
Message-Id: <1089726693.3283.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 15:51:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gDts9ZCTauW/gL/Gvh8D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've compiled a new kernel (2.6.7) 2 days ago, using the grSecurity
patch that comes with PaX inside.

I've configured the environment for running with PaX, and i ran out that
PaX tests.

They shown suspicious results:

Anonymous mapping randomisation test     : 16 bits (guessed)
Heap randomisation test (ET_EXEC)        : 13 bits (guessed)
Heap randomisation test (ET_DYN)         : 23 bits (guessed)
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : 15 bits (guessed)
Shared library randomisation test        : 15 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 23 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 23 bits (guessed)

I didn't know why the test shown that but i'm suspecting on the kernel=20
hacking option called "Debug memory allocations" that it's enabled on my=20
kernel configuration.

I've talked with Peter Busser from the Adamantix project about it he thinks=
=20
that it's possible, i'm not sure and i didn't make a further research on it=
.

Is anyone of you having the same situation, is it an unexpected behavior or=
 it's a bug
on the kernel source?
Is that option non-compatible with PaX RANDSTACK and the rest of PaX's memo=
ry randomization
features?

Cheers,

--=20
Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>

--=-gDts9ZCTauW/gL/Gvh8D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8+jlDcEopW8rLewRArJVAJ939eZTikVc0Z7ZiL4VfONOEh3DfQCcCtWn
cUNBY9B0N8ILvmcXUybtoTg=
=Xgno
-----END PGP SIGNATURE-----

--=-gDts9ZCTauW/gL/Gvh8D--

