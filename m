Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGHM7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGHM7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUGHM7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:59:12 -0400
Received: from smtp2gate.fmi.fi ([193.166.223.32]:50921 "EHLO smtp2gate.fmi.fi")
	by vger.kernel.org with ESMTP id S263733AbUGHM6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:58:18 -0400
Message-Id: <200407081257.i68Cvm0U020579@leija.fmi.fi>
Subject: Re: [OT] NULL versus 0 (Re: [PATCH] Use NULL instead of integer 0 in
 security/selinux/)
In-Reply-To: <200407081442.25752.mbuesch@freenet.de>
To: Michael Buesch <mbuesch@freenet.de>
Date: Thu, 8 Jul 2004 15:57:48 +0300 (EEST)
From: Kari Hurtta <hurtta+zz1@leija.mh.fmi.fi>
CC: Kari Hurtta <hurtta+zz1@leija.mh.fmi.fi>,
       Martin Zwickel <martin.zwickel@technotrend.de>, root@chaos.analogic.com,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
X-Mailer: ELM [version 2.4ME+ PL117a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Filter: smtp2gate: 3 received headers rewritten with id 20040708/20307/01
X-Filter: smtp2gate: ID 20306/01, 1 parts scanned for known viruses
X-Filter: torvi: ID 22103/01, 1 parts scanned for known viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-- Start of PGP signed section.
> That's all OK, fine and correct, but
> #define NULL 0
> would work for both, C and C++ as far as I can see.
> Am I missing some special case?

As far I know it does not work on C when it is
used as  argument of function and function
have not prototype or function's prototype have ...

In that case compiler do not know that pointer
is required instead of integer. 

However this is just "as far I know", now I have not
in hand reference (or I did not found good quotation.)

/ Kari Hurtta

> 
> Quoting Kari Hurtta <hurtta+zz1@leija.mh.fmi.fi>:
> > -- Start of PGP signed section.
> > > Quoting Martin Zwickel <martin.zwickel@technotrend.de>:
> > > > include/linux/stddef.h:
> > > >
> > > > #undef NULL
> > > > #if defined(__cplusplus)
> > > > #define NULL 0
> > > > #else
> > > > #define NULL ((void *)0)
> > > > #endif
> > >
> > > Yes, I never understood the reason for this ugly
> > > #if defined(__cplusplus) here.
> > > It works, but is IMHO unneccessary.
> > >
> >
> > (This is is off topic, because kernel is not C++, but C).
> >
> > Some quotations from  Bjarne Stroustrup: The C++ Programming Language
> > (Third Edition),
> >
> >    p. 843:    Note that a pointer to function or a pointer to member
> >               cannot be implicity converted to a void *.
> >
> >    p. 844:    A constant expression (§C.5) that evaluates to 0 can
> >               be implicitly converted to any pointer or pointer
> >               to member type (§5.1.1.).
> >
> >
> >    p. 88:     In C, it has been popular to define a macro NULL to
> >               represent the zero pointer. Because of C++'s tighter
> >               type checking, the use of plain 0, rather than any
> >               suggested NULL macro, leads to fewer problems. If you
> >               feel you must define NULL, use
> >
> >                   const int NULL = 0;
> >
> > (typos mine.)
> >
> > / Kari Hurtta
> >
> >
> 
> --
> Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
> 
> 
-- End of PGP signed section, PGP failed!
