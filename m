Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbULPKXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbULPKXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 05:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbULPKXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 05:23:06 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:45264 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261418AbULPKW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 05:22:57 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH 0/30] return statement cleanup - kill pointless parentheses
Date: Thu, 16 Dec 2004 11:16:31 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.61.0412160010550.3864@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0412160010550.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Message-Id: <200412161116.31607.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_/BWwBoyx6GhsuHs";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_/BWwBoyx6GhsuHs
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 16 Dezember 2004 01:02, Jesper Juhl wrote:
> If these patches are generally acceted then I think it would make sense t=
o=20
> make a small addition to Documentation/CodingStyle mentioning the prefere=
d=20
> form of return statements, so we (hopefully) won't have to do cleanups=20
> like this too often in the future.
> Below I've included a proposed patch adding such a bit to CodingStyle.

I think the change in Documentation/CodingStyle is useful, even though I
don't really like changing all the existing code without going through
the respective maintainers.

> 1) the parentheses are pointless.
> 2) removing the parentheses decreases source file size slightly.
> 3) they look odd and when reading code you don't want to be stopped wonde=
ring
>    - no parentheses is simply more readable (at least to me).=20
> 4) When I've submitted patches for other stuff in the past I've a few tim=
es
>    been asked if I could fix up the return statements while I was at it -=
 so
>    it seems to be wanted. =20

This is basically the same category as the first three chapters of
CodingStyle. It's not nice to read, but there is no real problem in the=20
code. Think of these issues as whitespace fixes: you are making the job
harder for code maintainers for very little gain. I would suggest that
you submit these patches only to the code maintainers, not to the Trivial
Patch Monkey or Andrew.

Or even better, change scripts/Lindent to do the change automatically for
code that it is used on, if that can be done in a reliable way.

 Arnd <><



--Boundary-02=_/BWwBoyx6GhsuHs
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBwWB/5t5GS2LDRf4RAsESAJ9NRP2uFHGPeJTXvgvXZQuldq8d0gCeO10b
+Abobl04QWm+aKUYZDyCu90=
=ypic
-----END PGP SIGNATURE-----

--Boundary-02=_/BWwBoyx6GhsuHs--
