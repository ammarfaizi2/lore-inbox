Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSLQMAZ>; Tue, 17 Dec 2002 07:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSLQMAZ>; Tue, 17 Dec 2002 07:00:25 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:35822 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S264954AbSLQMAY>; Tue, 17 Dec 2002 07:00:24 -0500
Subject: Re: Multithreaded coredump patch where?
From: Arjan van de Ven <arjanv@redhat.com>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
References: <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it>
	<5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it> 
	<5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-JMzQM3TGDyeS5MzvqFRD"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 13:08:16 +0100
Message-Id: <1040126896.10390.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JMzQM3TGDyeS5MzvqFRD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-12-17 at 12:05, Roberto Fichera wrote:=20
> At 13.21 16/12/02 -0800, mgross wrote:
>=20
> >I haven't rebased the patches I posted back in June for a while now.
> >
> >Attached is the patch I posted for the 2.4.18 vanilla kernel.  Its a bit
> >controversial, but it seems to work for a number of folks.  Let me know =
if
> >you have any troubles re-basing it.
>=20
> Only one hunk failed on include/asm-ia64/elf.h but fixed by hand.
> Why do you say a bit controversial ?
The design has theoretical (but probably in practice not trivial to
trigger) deadlocks; by design it prevents processes that are sleeping
from running, regardless whether those processes are in kernel space or
not. If they are in kernel space, they can accidentally be holding a
semaphore that something in the core dumping path will need to get (

--=-JMzQM3TGDyeS5MzvqFRD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9/xOwxULwo51rQBIRAt8zAKCFMfugTpDqKJFHO/JFlDPRCuJEdACdG09+
WldHS2mESk0RiAfrNOgpsUM=
=P4Zl
-----END PGP SIGNATURE-----

--=-JMzQM3TGDyeS5MzvqFRD--
