Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWGEXVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWGEXVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWGEXVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:21:46 -0400
Received: from xenotime.net ([66.160.160.81]:22703 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965052AbWGEXVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:21:45 -0400
Date: Wed, 5 Jul 2006 16:24:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, tglx@linutronix.de, mingo@elte.hu,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-Id: <20060705162425.547f3d3f.rdunlap@xenotime.net>
In-Reply-To: <1151947627.3108.39.camel@laptopd505.fenrus.org>
References: <1151885928.24611.24.camel@localhost.localdomain>
	<20060702173527.cbdbf0e1.akpm@osdl.org>
	<Pine.LNX.4.64.0607031007421.12404@g5.osdl.org>
	<1151947627.3108.39.camel@laptopd505.fenrus.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 19:27:07 +0200 Arjan van de Ven wrote:

> On Mon, 2006-07-03 at 10:13 -0700, Linus Torvalds wrote:
> >         #ifndef xyzzy
> >         #define zyzzy() /* empty */
> >         #endif
> > 
> 
> now if you write it as
> 
> #define zyzzy() do { ; } while (0)
> 
> it even works in a
> 
> if (foo())
> 	zyzzy();
> bar();
> 
> scenario 
> 
> (I know you know that, just pointing that out before people copy your
> example :-)

OK, I'll bite.  What part of Linus's macro doesn't work.
I compiled your foo/zyzzy/bar example with both his "empty"
macro and the do-while macro.  Same code produced both ways,
no compile warnings/errors.

---
~Randy
