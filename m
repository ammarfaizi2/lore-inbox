Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTASNP5>; Sun, 19 Jan 2003 08:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTASNP5>; Sun, 19 Jan 2003 08:15:57 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:41198 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267459AbTASNP4>; Sun, 19 Jan 2003 08:15:56 -0500
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E18aEyl-0006O0-00@bigred.inka.de>
References: <25160.1042809144@passion.cambridge.redhat.com>
	 <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
	 <E18a1aZ-0006mL-00@bigred.inka.de>
	 <20030119001256.GA11575@compsoc.man.ac.uk>
	 <E18aEyl-0006O0-00@bigred.inka.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BrNkanD9vKKv9EkpSizC"
Organization: Red Hat, Inc.
Message-Id: <1042981591.1479.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Jan 2003 14:06:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BrNkanD9vKKv9EkpSizC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-01-19 at 13:55, Olaf Titz wrote:

> It is also a bug that parts of the development infrastructure are
> installed in /lib/modules/<version> and it's somewhat documented that
> compiling modules needs this /lib/modules/<version> stuff. That may be
> true for the ideal, simplified Red Hat world but in reality the
> machine and running OS version of the development machine is likely
> different from the box it will run on. Mixing development environment
> and install target only causes confusion.

you make a series of good points before this. However
/lib/modules/<version>/build is nothing Red Hat specific. It's something
that is the result of a similar discussion long ago where Linus finally
decreed this location for finding the full source of modules.
Combine that with the makefile dwmw2 showed and you can compile external
modules EVERYWHERE on ANY distribution (assuming said distribution
doesn't go out of the way to break the decree). Afaik RHL, SuSE,
Mandrake, Debian and Slackware at least have this correct.

Yes it breaks if you move around your source after doing make
modules_install. Yes it breaks if you don't have the tree at all. But
both situations are "invalid" wrt the decree, and need a fixed symlink.


--=-BrNkanD9vKKv9EkpSizC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+KqLXxULwo51rQBIRAughAJoDWKJfODlfQkdHrBEjKMtJRsh/7QCgh8UL
Iz8aawf5OKsMO6nBTpS6zYc=
=XuGe
-----END PGP SIGNATURE-----

--=-BrNkanD9vKKv9EkpSizC--
