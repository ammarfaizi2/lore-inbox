Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUGHMnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUGHMnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGHMnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:43:10 -0400
Received: from mout0.freenet.de ([194.97.50.131]:59264 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261605AbUGHMnE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:43:04 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Kari Hurtta <hurtta+zz1@leija.mh.fmi.fi>
Subject: Re: [OT] NULL versus 0 (Re: [PATCH] Use NULL instead of integer 0 in security/selinux/)
Date: Thu, 8 Jul 2004 14:42:23 +0200
User-Agent: KMail/1.6.2
References: <200407081238.i68CcCM1020517@leija.fmi.fi>
In-Reply-To: <200407081238.i68CcCM1020517@leija.fmi.fi>
Cc: Martin Zwickel <martin.zwickel@technotrend.de>, root@chaos.analogic.com,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407081442.25752.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

That's all OK, fine and correct, but
#define NULL 0
would work for both, C and C++ as far as I can see.
Am I missing some special case?


Quoting Kari Hurtta <hurtta+zz1@leija.mh.fmi.fi>:
> -- Start of PGP signed section.
> > Quoting Martin Zwickel <martin.zwickel@technotrend.de>:
> > > include/linux/stddef.h:
> > >
> > > #undef NULL
> > > #if defined(__cplusplus)
> > > #define NULL 0
> > > #else
> > > #define NULL ((void *)0)
> > > #endif
> >
> > Yes, I never understood the reason for this ugly
> > #if defined(__cplusplus) here.
> > It works, but is IMHO unneccessary.
> >
>
> (This is is off topic, because kernel is not C++, but C).
>
> Some quotations from  Bjarne Stroustrup: The C++ Programming Language
> (Third Edition),
>
>    p. 843:    Note that a pointer to function or a pointer to member
>               cannot be implicity converted to a void *.
>
>    p. 844:    A constant expression (§C.5) that evaluates to 0 can
>               be implicitly converted to any pointer or pointer
>               to member type (§5.1.1.).
>
>
>    p. 88:     In C, it has been popular to define a macro NULL to
>               represent the zero pointer. Because of C++'s tighter
>               type checking, the use of plain 0, rather than any
>               suggested NULL macro, leads to fewer problems. If you
>               feel you must define NULL, use
>
>                   const int NULL = 0;
>
> (typos mine.)
>
> / Kari Hurtta
>
>

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7UEvFGK1OIvVOP4RAua2AKCCwyC3TzasTBCbPQLaKaU47UJEbACZAY4P
wd6n6AvSuJ+ThZE/Msbs9x0=
=jvQR
-----END PGP SIGNATURE-----
