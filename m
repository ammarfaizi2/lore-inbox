Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUGHL36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUGHL36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUGHL35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:29:57 -0400
Received: from mout2.freenet.de ([194.97.50.155]:62384 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S264965AbUGHL34 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:29:56 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: root@chaos.analogic.com
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Date: Thu, 8 Jul 2004 13:28:38 +0200
User-Agent: KMail/1.6.2
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos>
In-Reply-To: <Pine.LNX.4.53.0407080707010.21439@chaos>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil, jmorris@redhat.com, mika@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407081328.40545.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting "Richard B. Johnson" <root@chaos.analogic.com>:
> Because NULL is a valid pointer value. 0 is not. If you were
> to make 0 valid, you would use "(void *)0", which is what
> NULL just happens to be in all known architectures so far,
> although that could change in an alternate universe.

No, that is not true.
In C/C++ this is true:
NULL == 0

You can _always_ use 0 instead of NULL. The use of NULL is
_only_ for readability reasons. When you assign 0 to a
pointer, the compiler knows that you want to assign a
NULL-pointer and not the value 0.
Even on architectures where the NULL-pointer is not
represented as 0 in memory (another bitmask), it's still
valid to assign 0 to a pointer, because the compiler
_knows_ that you are handling with a pointer and does
The Right Thing (tm).

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7S/mFGK1OIvVOP4RAoJ4AKCVY9QbxaXEjGthqGXpoN1Wqw8bzACgwzW/
AZVhE8MYOGNwKC/k74qZUBw=
=Vy7x
-----END PGP SIGNATURE-----
