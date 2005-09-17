Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVIQUyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVIQUyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 16:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVIQUyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 16:54:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751203AbVIQUyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 16:54:04 -0400
Subject: Re: mmap (2) vs read (2)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linh Dang <linhd@nortel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <wn58xxvhdz8.fsf@linhd-2.ca.nortel.com>
References: <wn58xxvhdz8.fsf@linhd-2.ca.nortel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-x1k5kpWfz8zl0a5MVQLh"
Organization: Red Hat, Inc.
Date: Sat, 17 Sep 2005 14:26:35 -0400
Message-Id: <1126981595.3010.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-x1k5kpWfz8zl0a5MVQLh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-09-17 at 12:10 -0400, Linh Dang wrote:
> Hi, how come reading memory from /dev/mem using pread(2) or mmap(2)
> will give diffent results?

because you're being evil ;)

mmap of /dev/mem for *ram* is special. To avoid cache aliases and other
evils, you can only mmap non-ram realistically on /dev/mem.

Why are you using /dev/mem in the first place, it's a sure sign that
you're doing something really wrong in your design...


--=-x1k5kpWfz8zl0a5MVQLh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDLF/apv2rCoFn+CIRAs4jAJsFzGUMn8LX0rUzk9zXVYf5rfrjPQCeLUiH
D0yFXEeMcNQaCmBHtb5dZG0=
=RE/6
-----END PGP SIGNATURE-----

--=-x1k5kpWfz8zl0a5MVQLh--

