Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTLKMER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbTLKMER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:04:17 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:3272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264898AbTLKMEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:04:15 -0500
Subject: RE: Linux GPL and binary module exception clause?
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hua Zhong <hzhong@cisco.com>, "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0312100923370.29676@home.osdl.org>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
	 <Pine.LNX.4.58.0312100923370.29676@home.osdl.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1071144245.5712.577.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Thu, 11 Dec 2003 12:04:06 +0000
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-10 at 09:42 -0800, Linus Torvalds wrote:
> There's a reason for those lines at the top of the COPYING file saying
> that user space is not covered, and there are literally lawyers who say it
> would hold up in a court of law.

I'm glad that the lawyers have been specifically asked about that,
because the exception seems poorly worded to me. It does _not_ say that
user space 'is not covered'; in fact it says only that user space is not
considered a derived work.

But see §2 of the GPL:

	These requirements apply to the modified work as a whole. 
	If identifiable sections of that work are not derived from
	the Program, and can be reasonably considered independent
	and separate works in themselves, then this License, and its 	terms, do
not apply to those sections when you distribute
	them as separate works.  But when you distribute the same
	sections as part of a whole which is a work based on the
	Program, the distribution of the whole must be on the terms
	of this License, whose permissions for other licensees
	extend to the entire whole, and thus to each and every part
	regardless of who wrote it.

Being pedantic about it, the precise wording of the exception does not
prevent a user space program from being affected by the above even
though it is explicitly _not_ considered to be 'derived work', and
though it 'can be reasonably considered [an] independent and separate
[work] in [itself]'.

If you distribute your user space programs not 'as separate works' but
rather 'as part of a whole which is a work based on the Program', then
they may be affected.

I don't _like_ the idea that user space could be affected, and I hope
that the _intent_ of the exception is clear enough to cover the
ambiguity. I'm not really sure that's the case though.

For example, imagine explaining to a judge the technicalities about user
space and kernel space, and the 'separation' between the kernel and the
cramfs in the downloadable binary blob which forms the firmware for the
Linksys/Cisco wireless routers -- and hence arguing that the user space
bits are being distributed 'as separate works', rather than 'as part of
a whole...'. What reaction do you think you'd get?

I don't think the GPL on the kernel _should_ extend its reach into user
space, and I'll allow people to invoke estoppel by publicly stating here
and now that I'd never sue for such 'violations' alone.

Note the word "alone" in the above sentence. I won't rule out the
possibility of including such violations in a case against a vendor
shipping binary-only modules, or committing other violations.

-- 
dwmw2

