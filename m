Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKSKmZ>; Mon, 19 Nov 2001 05:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRKSKmP>; Mon, 19 Nov 2001 05:42:15 -0500
Received: from [202.54.110.230] ([202.54.110.230]:56334 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id <S277514AbRKSKmC>; Mon, 19 Nov 2001 05:42:02 -0500
Message-ID: <E04CF3F88ACBD5119EFE00508BBB212174A80B@exch-01.noida.hcltech.com>
From: Rajiv Malik <rmalik@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: tools for maintainence of LS-120/LS-240(super disk)
Date: Mon, 19 Nov 2001 16:14:04 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all, 
linux kernel now provides support for LS-120/LS-240 through its IDE Floppy
driver.

are there any tools available for superdisk(LS-120/LS-240), like we have for
floppies as such fdutil is one ??

Regards,
rajiv.



-----Original Message-----
From: Linus Torvalds [mailto:torvalds@transmeta.com]
Sent: Monday, November 19, 2001 7:34 AM
To: Horst von Brand
Cc: Andrea Arcangeli; ehrhardt@mathematik.uni-ulm.de;
linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1 



On Sun, 18 Nov 2001, Horst von Brand wrote:
> Linus Torvalds <torvalds@transmeta.com> said:
> > And nope, not really. It does use plain stores to page->flags, and I
agree
> > that it is ugly, but if the page was locked before calling it, all the
> > stores will be with the PG_lock bit set - and even plain stores _are_
> > documented to be atomic on x86 (and on all other reasonable
architectures
> > too).
>
> Even unaligned stores?

Actually, even unaligned stores (which page->flags is NOT) are atomic,
even if Intel strongly discourages them (for performance reasons if no
others) and there tends to be documentation that doesn't guarantee it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
