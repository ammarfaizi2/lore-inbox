Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTLBPxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTLBPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 10:53:17 -0500
Received: from [68.114.43.143] ([68.114.43.143]:28090 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262196AbTLBPxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 10:53:14 -0500
Date: Tue, 2 Dec 2003 10:53:13 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.23-bk1 && RTC
Message-ID: <20031202155313.GD18468@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Looks like RTC is broken in 2.4.23-bk1.

gcc -D__KERNEL__ -I/exp/src1/kernels/2.4.23/Server/General/linux-2.4.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -nostdinc -iwithprefix include -DKBUILD_BASENAME=rtc  -c -o rtc.o rtc.c
rtc.c: In function `rtc_init':
rtc.c:772: `RTC_IOMAPPED' undeclared (first use in this function)
rtc.c:772: (Each undeclared identifier is reported only once
rtc.c:772: for each function it appears in.)
rtc.c:773: `RTC_IO_EXTENT' undeclared (first use in this function)
rtc.c: In function `rtc_exit':
rtc.c:873: `RTC_IOMAPPED' undeclared (first use in this function)
rtc.c:874: `RTC_IO_EXTENT' undeclared (first use in this function)

If I disable the Enhanced Real Time Clock in menuconfig it compiles just
fine.



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zLVp8+1vMONE2jsRAqtwAJ4zcNZq8zMfDrITggfowQ/WGCxoywCguZcs
CcagU2PcAh278gPIHweyDFQ=
=ZH61
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
