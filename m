Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbTBCPKd>; Mon, 3 Feb 2003 10:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBCPKd>; Mon, 3 Feb 2003 10:10:33 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:57583 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266675AbTBCPKc>; Mon, 3 Feb 2003 10:10:32 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044285222.2396.14.camel@gregs>
References: <1044285222.2396.14.camel@gregs>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q3PTHmljBiXsLc5/Eq42"
Organization: Red Hat, Inc.
Message-Id: <1044285587.2527.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Feb 2003 16:19:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q3PTHmljBiXsLc5/Eq42
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-03 at 16:13, Grzegorz Jaskiewicz wrote:
> few days ago i started to port driver for our hardware in company from
> windows to linux. It is simple ISA card, which gives me interrupt each
> 8ms. So i can check it state and latch some sort of watchdog on it -
> saying that i am still running (just for security, if system hangs card
> is blocking all inputs/outputs).=20

> #include <linux/modversions.h>

don't do that. ever.

> #ifdef CONFIG_KMOD
> #include <linux/kmod.h>
> #endif

bullshit ifdef's (and the surrounding code has a whole bunch too

btw you do know you can't do vmalloc (or vfree) from interrupt context ?
And that every vmalloc eats at minimum 8Kb of virtual memory space? Of
which you can't count on having more than 64Mb on x86 ?

--=-q3PTHmljBiXsLc5/Eq42
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+PoiTxULwo51rQBIRAmDwAJ48trT0JIW+49vpvMNFhKDw6Ds4TQCfQ+hz
Y3N5ISTb6DtTh532l1B+SwI=
=bhOg
-----END PGP SIGNATURE-----

--=-q3PTHmljBiXsLc5/Eq42--
