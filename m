Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbSKUTXw>; Thu, 21 Nov 2002 14:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSKUTXw>; Thu, 21 Nov 2002 14:23:52 -0500
Received: from ppp-217-133-220-209.dialup.tiscali.it ([217.133.220.209]:17308
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S266972AbSKUTXu>; Thu, 21 Nov 2002 14:23:50 -0500
Subject: Re: [patch] threading enhancements, tid-2.5.48-C0
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211211050380.3577-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211211050380.3577-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/UMkz16AH9YwFFDMfaNT"
Organization: 
Message-Id: <1037907039.1767.129.camel@home.ldb.ods.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Nov 2002 20:30:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/UMkz16AH9YwFFDMfaNT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> this method is quite dangerous as the register usage is largely ad-hoc in
> the x86 lowlevel code. Eg. your %ebx use clashes with that of kernel
> threads, which also go through ret_from_fork.
Yes, I realize that it was a bad idea, since bloat in task_struct can be
avoided by putting clear_tid in an union other temporary data (e.g.
*link_count), without using arch-specific code (and this is a obviously
a separate patch).


--=-/UMkz16AH9YwFFDMfaNT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA93TRedjkty3ft5+cRAmQ/AKCK7SPP/PGvE/EE9NJKqYSDNaNlEACgrHIk
6xrtig9bCzO9KL6hPqTWGLs=
=cBcR
-----END PGP SIGNATURE-----

--=-/UMkz16AH9YwFFDMfaNT--
