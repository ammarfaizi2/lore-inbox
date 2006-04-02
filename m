Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWDBAUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWDBAUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 19:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDBAUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 19:20:01 -0500
Received: from xenotime.net ([66.160.160.81]:45499 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932321AbWDBAUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 19:20:01 -0500
Date: Sat, 1 Apr 2006 16:22:13 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: mrmacman_g4@mac.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header
 infrastructure
Message-Id: <20060401162213.dc68d120.rdunlap@xenotime.net>
In-Reply-To: <20060329222640.GA2755@ucw.cz>
References: <200603141619.36609.mmazur@kernel.pl>
	<200603231811.26546.mmazur@kernel.pl>
	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	<200603241623.49861.rob@landley.net>
	<878xqzpl8g.fsf@hades.wkstn.nix>
	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<20060326065416.93d5ce68.mrmacman_g4@mac.com>
	<1143376351.3064.9.camel@laptopd505.fenrus.org>
	<A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
	<20060329222640.GA2755@ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006 22:26:41 +0000 Pavel Machek wrote:

> Hi!
> 
> > I plan to add a lot of other definitions to this file 
> > later on.  For  example different architectures have 
> > different notions of what a  __kernel_ino_t is (unsigned 
> > int versus unsigned long).  I may rename  this file as 
> > types.h, but from looking through the code I figure I'll  
> > have enough general purpose declarations about "This 
> > architecture has  blah" that a separate stddef.h file 
> > will be worth it.
> > 
> > >(and... why do you prefix these with _KABI? that's a 
> > >mistake imo.  Don't bother with that. Really. Either 
> > >these need exporting to  userspace, but then either use 
> > >__ as prefix or don't use a prefix.  But KABI.. No.)
> > 
> > According to the various standards all symbols beginning 
> > with __ are  reserved for "The Implementation", including 
> > the compiler, the  standard library, the kernel, etc.  In 
> > order to avoid clashing with  any/all of those, I picked 
> > the __KABI_ and __kabi_ prefixes for  uniqueness.  In 
> > theory I could just use __, but there are problems  with 
> > that too.  For example, note how the current compiler.h 
> > files  redefine __always_inline to mean something kinda 
> > different.  The GCC  manual says we should be able to 
> > write this:
> 
> __KABI_ everywhere will just make your headers totally unreadable.
> Please don't do that.

Ack, I agree.

---
~Randy
