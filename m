Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSHVVTR>; Thu, 22 Aug 2002 17:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSHVVTR>; Thu, 22 Aug 2002 17:19:17 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:41258 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S317329AbSHVVTQ>;
	Thu, 22 Aug 2002 17:19:16 -0400
Date: Thu, 22 Aug 2002 23:23:19 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: A copy_from_user problem in 2.5(.31)
Message-ID: <20020822212319.GD2024@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am looking at getting the SX serial driver to work under 2.5,
specifically 2.5.31 (no others have been tried). The SX board
needs to have its firmware downloaded (uploaded?) before it works,
by some ioctl magic on a misc device. The ioctl does copy_from_user
to get the firmware. This copy_from_user fails under 2.5.31 but
works on 2.4.19.

The firmware in userspace is a char array part of program text.
If I walk or otherwise touch this array prior to the ioctl,
it works fine on 2.5.31.

The copy_from_user fails at addres 804BFFE, AFAICS.

I probably missed an inportant datapoint. Please ask for more
info.

Regards,
  Rasmus

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ZVZHlZJASZ6eJs4RAl9WAKCStbH4gyjxihaot4pLsSJeFhGuUgCggeSM
L+doEThtx2FQJSTNolSg3ts=
=IpCs
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
