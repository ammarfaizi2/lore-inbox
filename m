Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269029AbUJENlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269029AbUJENlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269046AbUJENlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:41:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269029AbUJENk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:40:58 -0400
Subject: Re: PROBLEM: large auto variables cause segfault under 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Andrei A. Voropaev" <av@simcon-mt.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041005132741.GD28160@avorop.local>
References: <20041005132741.GD28160@avorop.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c0iaO9ryOWBSmmOrC8tV"
Organization: Red Hat UK
Message-Id: <1096983652.9975.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 15:40:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c0iaO9ryOWBSmmOrC8tV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-05 at 15:27, Andrei A. Voropaev wrote:
> Declaring very large auto variables cause segfaults in the program under
> 2.6 kernel.
>=20
> Take a look at this program.
>=20
>   int main( int argc, char **argv )
>   {
>        unsigned char  bRet =3D 0;
>  =20
>        char tst[67123456];
>  =20
you have a stack variable that is several orders of magnitude bigger
than the rlimit you have set for the stack I suspect. Try increasing the
stack rlimit...


--=-c0iaO9ryOWBSmmOrC8tV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBYqRkxULwo51rQBIRAr/8AKCS1COL2s+scUPFn/mYGeaCuW6N0QCgnNZc
bWaI9GZu2vbmIAvtvbIhDY8=
=xf+t
-----END PGP SIGNATURE-----

--=-c0iaO9ryOWBSmmOrC8tV--

