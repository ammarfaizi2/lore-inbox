Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSHKBdE>; Sat, 10 Aug 2002 21:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHKBdE>; Sat, 10 Aug 2002 21:33:04 -0400
Received: from mail019.syd.optusnet.com.au ([210.49.20.160]:64962 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S317400AbSHKBdD>; Sat, 10 Aug 2002 21:33:03 -0400
Date: Sun, 11 Aug 2002 11:36:39 +1000
From: Pete de Zwart <dezwart@froob.net>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Pete de Zwart <dezwart@froob.net>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
Message-ID: <20020811013639.GG27819@niflheim>
References: <200208092200.RAA34736@tomcat.admin.navo.hpc.mil> <20020811000340.GF27819@niflheim> <200208111052.25488.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <200208111052.25488.bhards@bigpond.net.au>
User-Agent: Mutt/1.3.28i
X-environment: Linux niflheim 2.4.19 i686 /dev/pts/2
X-Url: http://froob.net/~dezwart/
X-Organisation: Froob Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yeah, that makes sense, it's not the kernel's job to take care of the
printers status beyond the basics.

Make the printer drivers like a pseudo-micro-kernel, have the basic printer
operations done in the kernel and have the rest of the functionality farmed
out to individual printer modules.

Ignoring the above, where should the functionality for the extended printer
operations reside?

In the print spooler? A separate process that deals with a bunch of printer=
s?

If this is going off-topic for LKML where would be a better place to discuss
this?

	Pete de Zwart.

Around about 1052h 11/08/2002, Brad Hards emitted the following wisdom:
> So the kernel doesn't care about most of the error codes (since it isn't=
=20
> interpreting the data stream), but there are some things that are noted f=
or=20
> historical reasons. Those things (like "out of paper" turn out to be wide=
ly=20
> supported (or if not, are at least set to benign values). All the "unique=
"=20
> error codes are a problem for userspace.
>=20
> Does this make sense?

--=20
The real reason your computer crashed, thanx to the BOFH:
"Mailer-daemon is busy burning your message in hell."

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Vb+njCPqVJhK9xARAtwoAJ0VS7YAtVea13UZG4yEKFZdx5MOAgCg5Vt7
fHXzTdv72uxdke9inmdNW8Y=
=PBEK
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
