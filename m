Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932739AbWJINGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWJINGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbWJINGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:06:33 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:46539 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932739AbWJINGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:06:33 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] kernel-doc: fix function name in usercopy.c
Date: Mon, 9 Oct 2006 15:07:36 +0200
User-Agent: KMail/1.9.4
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20061008194429.c98d7387.rdunlap@xenotime.net> <20061009032851.GA5344@martell.zuzino.mipt.ru> <20061008203617.f3ca1270.rdunlap@xenotime.net>
In-Reply-To: <20061008203617.f3ca1270.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart29022953.itjAfBExOR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610091507.36988.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart29022953.itjAfBExOR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Randy Dunlap wrote:
> On Mon, 9 Oct 2006 07:28:51 +0400 Alexey Dobriyan wrote:
> > On Sun, Oct 08, 2006 at 07:44:29PM -0700, Randy Dunlap wrote:
> > >  /**
> > > - * strlen_user: - Get the size of a string in user space.
> > > + * strnlen_user: - Get the size of a string in user space.
> >
> > It's better to not spend time fixing mismatches, but to teach kernel-doc
> > extract function name from function itself.
> >
> > 	/**
> > 	 * Get the size of a string in user space.
> > 	 * @foo: bar
> > 	 */
> > 	 size_t strnlen_user()
>
> OK, maybe a good idea.  I'll add that to the wish list.
> However, we have seen examples of:
>
> /**
>  * doc for foo
>  */
> int foo(int arg)
> {
> }
>
> then someone inserts a new function bar() between the kernel-doc
> and foo().  How would we catch that (automated)?
> other than by our review process?

Warn if the function signature of the documented function does not match th=
e=20
function and throw away the manpage then.

Eike

--nextPart29022953.itjAfBExOR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFKkmYXKSJPmm5/E4RAk70AJ9PG+jK04iq+b0wvuocS5vpHCTOAQCgnW5D
e/eVPR9yc+50IEg5pURvlQ8=
=fISa
-----END PGP SIGNATURE-----

--nextPart29022953.itjAfBExOR--
