Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263495AbTDYIyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 04:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbTDYIyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 04:54:19 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:23278 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263495AbTDYIyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 04:54:15 -0400
Subject: Re: compiling modules with gcc 3.2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: devnetfs <devnetfs@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030425063147.9206.qmail@web20421.mail.yahoo.com>
References: <20030425063147.9206.qmail@web20421.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j34ZNJnA1jIij2ZXZNtZ"
Organization: Red Hat, Inc.
Message-Id: <1051261584.1391.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 25 Apr 2003 11:06:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j34ZNJnA1jIij2ZXZNtZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-04-25 at 08:31, devnetfs wrote:
> Hello,
>=20
> Will kernel modules compiled with gcc 3.2 load in kernel compiled with
> gcc 2.96 (RH system)?  The RH 8.0 release notes state that 2.96
> compiled modules can't be loaded on RH8.0 (as its compiled using gcc
> 3.2). So
> does the reverse also hold true?

yes

> Either way why is this so? AFAIK gcc 3.2 has abi incompatiblities
> w.r.t. C++ and not C (which the kernel+modules are written in).

there are some cornercase C ABI changes but nobody except DAC960 will
ever hit those. The more serious change is that the kernel contains
workarounds for older compilers (the test used is major < 3) that
changes the size of structures etc etc, and that breaks the module
stuff.

--=-j34ZNJnA1jIij2ZXZNtZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+qPqQxULwo51rQBIRAnHgAJ9sU4hbucbSQJqc3qDIiUxLUF61ZgCfdRuG
zkiJ6yNSK5goWbJv87sHotc=
=0Asr
-----END PGP SIGNATURE-----

--=-j34ZNJnA1jIij2ZXZNtZ--
