Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUESK1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUESK1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUESK1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:27:23 -0400
Received: from maximus.kcore.de ([213.133.102.235]:49800 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S263228AbUESK1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:27:10 -0400
From: Oliver Feiler <kiza@gmx.net>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.4 patch] Re: CONFIG_ATALK cannot be compiled as a module
Date: Wed, 19 May 2004 12:27:42 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
References: <20040510235343.GD18093@fs.tum.de>
In-Reply-To: <20040510235343.GD18093@fs.tum.de>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_uazqAB0wY4OLlrc";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405191227.58002.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_uazqAB0wY4OLlrc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi Adrian,

sorry for the late reply, didn't find time to test it earlier.

On Tuesday 11 May 2004 01:53, Adrian Bunk wrote:

> > > > when selecting CONFIG_ATALK as a module the symbols
> > > > register_snap_client and unregister_snap_client will be unresolved.
> > > > As I understand it they are in net/802/psnap.c which does not get
> > > > compiled when Appletalk is selected as a module. Compiling into the
> > > > kernel works fine.
> > > >...

> The patch below that should fix it.
>
> diffstat output:
>  net/802/Makefile |   60 ++++++++++++++---------------------------------
>  net/Makefile     |    2 -
>  2 files changed, 20 insertions(+), 42 deletions(-)
>
> patch description:
> - net/Makefile: there might be modules in net/802/
> - net/802/Makefile: deuglyfy it and make it more similar to the
>                     2.6 version

Yes, works fine. No unresolved symbols.

=46WIW, the modules psnap.o and p8022.o don't export a license and taint th=
e=20
kernel:

Warning: loading /lib/modules/2.4.26/kernel/net/802/p8022.o will taint the=
=20
kernel: no license
  See http://www.tux.org/lkml/#export-tainted for information about tainted=
=20
modules
Module p8022 loaded, with warnings
Warning: loading /lib/modules/2.4.26/kernel/net/802/psnap.o will taint the=
=20
kernel: no license
Module psnap loaded, with warnings
Module appletalk loaded, with warnings


Other than that it works for me. Thanks for your help!

	Oliver

=2D-=20
Oliver Feiler  -  http://kiza.kcore.de/

--Boundary-02=_uazqAB0wY4OLlrc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAqzatOpifZVYdT9IRAjlIAKDOT7A9BAe5Uz9HdzJqNQneqNe3NwCgzyfZ
iHEtwXkMd/OcH+DzyizgOac=
=U8O9
-----END PGP SIGNATURE-----

--Boundary-02=_uazqAB0wY4OLlrc--

