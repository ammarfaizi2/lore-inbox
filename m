Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSJNIGj>; Mon, 14 Oct 2002 04:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbSJNIGj>; Mon, 14 Oct 2002 04:06:39 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:29454 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261857AbSJNIGi>;
	Mon, 14 Oct 2002 04:06:38 -0400
Date: Mon, 14 Oct 2002 12:11:23 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] 2.4.6 compatibility cruft in 8250_pci.c
Message-ID: <20021014081123.GA338@pazke.ipt>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20021009004606.G12270@flint.arm.linux.org.uk> <57751.172.192.100.207.1034134903.squirrel@mail.orbita1.ru> <20021011132723.B8823@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20021011132723.B8823@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment
Content-Transfer-Encoding: quoted-printable

On =D0=9F=D1=82=D0=BD, =D0=9E=D0=BA=D1=82 11, 2002 at 01:27:23 +0100, Russe=
ll King wrote:
> On Wed, Oct 09, 2002 at 07:41:43AM +0400, Andrey Panin wrote:
> > Ugh, this is not what i need. I want to move SIIG combo cards support
> > from 8250_pci.c to parport_serial.c module. For this I need to export
> > pci_siig[12]0x_fn() functions having struct pci_board *board as one
> > of arguments. parport_serial.c modules already includes
> > <linux/serialP.h> so used it for 2.4, but 2.5 is different.
>=20
> Well, I'd like to eliminate struct pci_board from the init functions
> for several reasons.  One of them is that some of the init functions
> do buggy things with it (like increasing the number of ports.)
>=20
> This should solve your problem - please confirm.
>
Yes it should fix my problem, actually SIIG initialization functions don't
even use this argument.

When you submit this change to 2.5 I'll send a patch ASAP.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9qnwqBm4rlNOo3YgRAoNWAJ9bYJ6beg92zNbRuB8rnX7JCuhNRACcCkaV
wUNPy3Ik7m3Jcgb9v9gpBWw=
=pWy5
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
