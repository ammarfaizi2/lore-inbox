Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSICUsD>; Tue, 3 Sep 2002 16:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318919AbSICUsD>; Tue, 3 Sep 2002 16:48:03 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:46381 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S318918AbSICUsC>;
	Tue, 3 Sep 2002 16:48:02 -0400
Date: Tue, 3 Sep 2002 22:52:29 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: __func__ in 2.5.33?
Message-ID: <20020903225229.A24108@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I trying to compile the SX driver for the 2.5.33 kernel, I got a
lot of warnings looking like (this is from a test program, not
the driver itself)

test.c: In function `main':
test.c:6: called object is not a function
test.c:6: parse error before string constant

This seems to stem from the recent __FUNCTION__ vs. __func__
change in kernel.h and the SX driver's use of __FUNCTION__ in the
following construct

#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ "\n")

My gcc (vers. 2.96) does not accept the above when __FUNCTION__ is
#defined to be (__func__). I likes __func__ well enough, though.

So I guess my question is whether I should change the above define,
and if so, to what, or if __FUNCTION__ should be defined to something
else?

BTW, it was my impression that the kernel would continue
with __FUNCTION__? Maybe I missed something....

Regards,
  Rasmus

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9dSEMlZJASZ6eJs4RArWaAJ0XHVCapvWCBJGaN5iydbXrD8EvqACeJa4G
y4KjnRGgPf6erw3+Lab2rOI=
=U+uB
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
