Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUEFWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUEFWYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUEFWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 18:24:05 -0400
Received: from zlynx.org ([199.45.143.209]:40710 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S263117AbUEFWYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 18:24:02 -0400
Subject: Re: sigaction, fork, malloc, and futex
From: Zan Lynx <zlynx@acm.org>
To: Steve Beaty <beaty@emess.mscd.edu>
Cc: chris@scary.beasts.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405062137.i46LbnjF017523@emess.mscd.edu>
References: <200405062137.i46LbnjF017523@emess.mscd.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WwOmo1Ose7FLbHcMnfP+"
Message-Id: <1083882160.8704.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7jb) 
Date: Thu, 06 May 2004 16:22:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WwOmo1Ose7FLbHcMnfP+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-06 at 15:37, Steve Beaty wrote:
> > I am not sure it is really a problem though.  I don't think you should
> > be allowed to fork inside a signal handler.  That seems very wrong.
>=20
> 	i can't disagree :-)  but fork() is supposed to be reentrant...

In your test program, I just tried using sys_clone to fork the process
directly.  It works.  The problem really is inside glibc.  If glibc is
not POSIX compliant in this instance, I suppose you will have to file a
bug with them.
--=20
Zan Lynx <zlynx@acm.org>

--=-WwOmo1Ose7FLbHcMnfP+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAmrqvG8fHaOLTWwgRAuIAAJ9rblmG3+zqwIwzatox4D9FR/rA/ACfbAzF
lWlg3jBDzp+tbDgR2LkeZbE=
=60Qg
-----END PGP SIGNATURE-----

--=-WwOmo1Ose7FLbHcMnfP+--

