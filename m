Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUAFErL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUAFErL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:47:11 -0500
Received: from [38.119.218.103] ([38.119.218.103]:30344 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S265768AbUAFErH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:47:07 -0500
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.045425 secs)
Date: Mon, 5 Jan 2004 22:47:05 -0600
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1-mm[1|2] on Alpha build failure
Message-ID: <20040106044705.GA13288@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


A change to include/asm-alpha/smp.h went in during 2.6.1-rc1-mm1 which
appears to have broken compilation on Alpha.  Specifically, the addition
of:
#define cpu_possible_map       cpu_present_map
seems to have caused a problem, since cpu_present_map doesn't appear to
be declared anywhere.


CC      init/main.o
In file included from init/main.c:33:
include/linux/kernel_stat.h: In function `kstat_irqs':
include/linux/kernel_stat.h:47: error: `cpu_present_map' undeclared (first =
use in this function)
include/linux/kernel_stat.h:47: error: (Each undeclared identifier is repor=
ted only once
include/linux/kernel_stat.h:47: error: for each function it appears in.)
init/main.c: In function `smp_init':
init/main.c:348: error: `cpu_present_map' undeclared (first use in this fun=
ction)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2


--=20
Nathan Poznick <kraken@drunkmonkey.org>

Retribution often means that we eventually do to ourselves what we have
done unto others. - Eric Hoffer


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+j3JYOn9JTETs+URAtQKAKCrYrQf8ARuxkhyQPMiMcOTT9byPACfXGhq
ctTrwoXGECkUd/0cEDEkNgk=
=xS09
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
