Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTFTI4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFTI4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:56:11 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:13807 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262490AbTFTI4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:56:04 -0400
Subject: Re: fast_copy_page sections?!
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Karl Vogel <karl.vogel@seagha.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <6DED3619289CD311BCEB00508B8E1336011774BD@nt-server2.antwerp.seagha.com>
References: <6DED3619289CD311BCEB00508B8E1336011774BD@nt-server2.antwerp.seagha.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VOyP/Sx9oca5Q7Z4oywZ"
Organization: Red Hat, Inc.
Message-Id: <1056100201.1721.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 20 Jun 2003 11:10:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VOyP/Sx9oca5Q7Z4oywZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-06-20 at 10:38, Karl Vogel wrote:
> In arch/i386/lib/mmx.c there is a function fast_copy_page() using some
> crafty asm statements. However I don't quite understand the part with the
> fixup sections?!=20

basically, if your cpu doesn't do prefetch, it will fault. The section
stuff adds an exception handler for this fault that zeroes out the
prefetch code so that next time there no longer is a prefetch() there.

--=-VOyP/Sx9oca5Q7Z4oywZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+8s9pxULwo51rQBIRArQzAJ4hKS6o2gjJ+8wdnvBFoa8z2VN2VwCZAX8z
xrF4CYjmrf1ZS6Vbw/uNz30=
=jgci
-----END PGP SIGNATURE-----

--=-VOyP/Sx9oca5Q7Z4oywZ--
