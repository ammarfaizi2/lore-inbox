Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUHQH2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUHQH2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268133AbUHQH2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:28:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268132AbUHQH2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:28:22 -0400
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jens Maurer <Jens.Maurer@gmx.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4121A211.8080902@gmx.net>
References: <4121A211.8080902@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dxOrFj0RXcoKEdIGcQec"
Organization: Red Hat UK
Message-Id: <1092727670.2792.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 09:27:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dxOrFj0RXcoKEdIGcQec
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-17 at 08:13, Jens Maurer wrote:
> The attached patch (against kernel 2.6.8.1) enables using SSE
> instructions for copy_page and clear_page.
>=20
> A user-space test on my Pentium III 850 MHz shows a 3x speedup for
> clear_page (compared to the default "rep stosl"), and a 50% speedup
> for copy_page (compared to the default "rep movsl").  For a Pentium-4,
> the speedup is about 50% in both the clear_page and copy_page cases.


we used to have code like this in 2.4 but it got removed: the non
temperal store code is faster in a microbenchmark but has the
fundamental problem that it evics the data from the cpu cache; the
actual USE of the data thus is a LOT more expensive, result is that the
overall system performance goes down ;(

--=-dxOrFj0RXcoKEdIGcQec
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBIbN2xULwo51rQBIRAqahAJ923/F/630U7c+c/RSfiJma2A8YBwCdG8d5
oOcgTcgaRhP2zqtX/SCYxN0=
=hSl7
-----END PGP SIGNATURE-----

--=-dxOrFj0RXcoKEdIGcQec--

