Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSHLMOq>; Mon, 12 Aug 2002 08:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317904AbSHLMOq>; Mon, 12 Aug 2002 08:14:46 -0400
Received: from ppp-217-133-217-5.dialup.tiscali.it ([217.133.217.5]:7400 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S317892AbSHLMOp>;
	Mon, 12 Aug 2002 08:14:45 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
In-Reply-To: <Pine.LNX.4.44.0208112326580.29560-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0208112326580.29560-200000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-uPcV7tqh8wXsTD2j9LD2"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 14:18:27 +0200
Message-Id: <1029154707.4258.28.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uPcV7tqh8wXsTD2j9LD2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Comments?
Numbers:
unconditional copy of 2 tls descs: 5 cycles
this patch with 1 tls desc: 26 cycles
this patch with 8 tls descs: 52 cycles
lldt: 51 cycles
lgdt: 50 cycles
context switch: 2000 cycles (measured with pipe read/write and vmstat so
it's not very accurate)

So this patch causes a 1% context switch performance drop for
multithreaded applications.

Note: the benchmark doesn't include the initial test for non-zero
nr_tls_bytes and doesn't include setting the LDT descriptor


--=-uPcV7tqh8wXsTD2j9LD2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9V6eTdjkty3ft5+cRAob8AJ9PixVu0EnWJwa1rnLuf34TVpW/LgCbB9M8
d3La6REN6OGPdzW69VExmu0=
=gkGa
-----END PGP SIGNATURE-----

--=-uPcV7tqh8wXsTD2j9LD2--
