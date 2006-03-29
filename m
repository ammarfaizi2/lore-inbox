Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWDAR1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWDAR1r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 12:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWDAR1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 12:27:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35850 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751569AbWDAR1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 12:27:46 -0500
Date: Wed, 29 Mar 2006 22:26:41 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header	infrastructure
Message-ID: <20060329222640.GA2755@ucw.cz>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I plan to add a lot of other definitions to this file 
> later on.  For  example different architectures have 
> different notions of what a  __kernel_ino_t is (unsigned 
> int versus unsigned long).  I may rename  this file as 
> types.h, but from looking through the code I figure I'll  
> have enough general purpose declarations about "This 
> architecture has  blah" that a separate stddef.h file 
> will be worth it.
> 
> >(and... why do you prefix these with _KABI? that's a 
> >mistake imo.  Don't bother with that. Really. Either 
> >these need exporting to  userspace, but then either use 
> >__ as prefix or don't use a prefix.  But KABI.. No.)
> 
> According to the various standards all symbols beginning 
> with __ are  reserved for "The Implementation", including 
> the compiler, the  standard library, the kernel, etc.  In 
> order to avoid clashing with  any/all of those, I picked 
> the __KABI_ and __kabi_ prefixes for  uniqueness.  In 
> theory I could just use __, but there are problems  with 
> that too.  For example, note how the current compiler.h 
> files  redefine __always_inline to mean something kinda 
> different.  The GCC  manual says we should be able to 
> write this:

__KABI_ everywhere will just make your headers totally unreadable.
Please don't do that.

-- 
Thanks, Sharp!
