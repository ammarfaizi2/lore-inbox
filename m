Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTDLOEA (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 10:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTDLOD7 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 10:03:59 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:60142 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262673AbTDLODz (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 10:03:55 -0400
Subject: Re: sysenter on x86
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030412135457.GB19869@codeblau.de>
References: <20030412135457.GB19869@codeblau.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EFK+Hzuvs0Z6BUNjBVGk"
Organization: Red Hat, Inc.
Message-Id: <1050156926.1449.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 12 Apr 2003 16:15:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EFK+Hzuvs0Z6BUNjBVGk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-04-12 at 15:54, Felix von Leitner wrote:
> I just added sysenter support for linux-2.5 on x86 to the diet libc, but
> I noted that the original patch said user space should jump to
> 0xfffff000, which segfaults.  Jumping to 0xffffe000 works.
>=20
> I suggest adding a comment somewhere in the kernel about the proper
> calling convention, because the glibc code is frankly not readable in
> this regard.

you HAVE to use the location as specified with the AT_SYSINFO elf flag.
The kernel is free to move this address around between builds, as long
as AT_SYSINFO gives the address for the location.

--=-EFK+Hzuvs0Z6BUNjBVGk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+mB9+xULwo51rQBIRApCSAKCjVUjPRZp4q16HJjE2bZYQ1acB2gCeMKXj
XdLzRURATwx9Q+ucJKA4bmg=
=xUeF
-----END PGP SIGNATURE-----

--=-EFK+Hzuvs0Z6BUNjBVGk--
