Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbRDLXRy>; Thu, 12 Apr 2001 19:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135381AbRDLXRo>; Thu, 12 Apr 2001 19:17:44 -0400
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:57847 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S135380AbRDLXRl>; Thu, 12 Apr 2001 19:17:41 -0400
Date: Thu, 12 Apr 2001 19:17:26 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac5
Message-ID: <20010412191726.A719@athame.dynamicro.on.ca>
Reply-To: glouis@dynamicro.on.ca
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14njvB-0000xu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <E14njvB-0000xu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Apr 12, 2001 at 05:26:11PM +0100
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20010412 (Thu) at 1726:11 +0100, Alan Cox wrote:
>=20
> 2.4.3-ac5

> o	Fix rwsem compile problem			(me)

No such luck, I fear, at least not with egcs-2.91.66:
/usr/src/linux-2.4.3ac5/include/asm/rwsem.h:26: badly punctuated
parameter list in #define'
/usr/src/linux-2.4.3ac5/include/asm/rwsem.h: In function 'down_read':
/usr/src/linux-2.4.3ac5/include/asm/rwsem.h:52: warning: implicit
declaration of function 'rwsemdebug'

I went in and #if 0'd around the #ifdef at line 26 and uncommented the
corresponding lines in "old gcc" and it worked fine.  Do gcc and egcs
really not define anything source could #ifdef to figure out to which
compiler it's being submitted?  Yuk!

--=20
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Comment: finger greg@bgl.nu for public key

iEYEARECAAYFAjrWN4YACgkQDlwut6d6Rj1kiwCcD6mhho5blaUmmau3b8L2UMXY
Vo4An05TlmwVpjPHpm8cYqizrafpBVM9
=M1j1
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
