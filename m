Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbTL0BMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 20:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTL0BMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 20:12:16 -0500
Received: from quechua.inka.de ([193.197.184.2]:42634 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265290AbTL0BMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 20:12:14 -0500
Date: Sat, 27 Dec 2003 02:11:53 +0100
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6] building extra modules, with r/o source
Message-ID: <20031227011153.GA8961@zombie.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

#include <hallo.h>

I have a general question to the new kernel build system which is
claimed to be very generic: how does someone build external modules
having the MINIMAL SET of the kernel headers and other configuration
files? With Kernel 2.4, it was mostly feasible:

 - compiler calls were identical and portable
 - MODVERSIONS setting and modified compiler command could be configured
   using the .config file and few kernel headers
 - compiler name could be extracted from the configured headers
 - kernel headers only were enough to build the most modules out there

With 2.6, I see two major flaws:

 - module writers are encouraged to use the kernel build system to
   compile modules. Problem: apparently the whole build system must be
   shipped together with the headers. Solution: unknown. I would like to
   see something like the gtk-config script generated during the
   complete kernel build which would provide all needed information
   including compiler command. External modules could get the complete
   command line by running=20
   sh /usr/src/kernel-foo-headers/kmod-build --compile foo.c

 - the build system also tries to write in the kernel source directory.
   This is simply not acceptable if /usr is mounted read-only or if you
   try to build external modules as user. The only good solution I see
   is using some temporary directory to write run-time files. I tried
   setting different variables in Makefile but that did not help, and
   the build scripts are not documented consistent enough to be easy to
   understand.

MfG,
Eduard.
--=20
Wu=DFten Sie schon...
=2E.. da=DF "finish" gar nicht finnisch ist, sondern englisch?

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/7NxZ4QZIHu3wCMURAu55AJ9NsJg1guE2rvUCXgAmlQnYFmOzZwCdEtGY
Qedx4gmFh7WSQQ9OI/p9vmA=
=NnqT
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
