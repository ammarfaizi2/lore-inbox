Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268143AbUHQIKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268143AbUHQIKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUHQIKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:10:41 -0400
Received: from mail.donpac.ru ([80.254.111.2]:7573 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S268143AbUHQIKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:10:15 -0400
Date: Tue, 17 Aug 2004 12:10:09 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jens Maurer <Jens.Maurer@gmx.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
Message-ID: <20040817081009.GA806@pazke>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Jens Maurer <Jens.Maurer@gmx.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4121A211.8080902@gmx.net> <1092727670.2792.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1092727670.2792.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6+20040803i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 230, 08 17, 2004 at 09:27:51AM +0200, Arjan van de Ven wrote:
> On Tue, 2004-08-17 at 08:13, Jens Maurer wrote:
> > The attached patch (against kernel 2.6.8.1) enables using SSE
> > instructions for copy_page and clear_page.
> >=20
> > A user-space test on my Pentium III 850 MHz shows a 3x speedup for
> > clear_page (compared to the default "rep stosl"), and a 50% speedup
> > for copy_page (compared to the default "rep movsl").  For a Pentium-4,
> > the speedup is about 50% in both the clear_page and copy_page cases.
>=20
>=20
> we used to have code like this in 2.4 but it got removed: the non
> temperal store code is faster in a microbenchmark but has the
> fundamental problem that it evics the data from the cpu cache; the
> actual USE of the data thus is a LOT more expensive, result is that the
> overall system performance goes down ;(

Did SSE clear_page() suffered from this issue too ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBIb1hby9O0+A2ZecRAp5tAJ9IzW6qXFNZQFcASBIFPshFm5yLCgCfRT1G
/usZr3l8m33uEnoDzWTz6wQ=
=hVPI
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
