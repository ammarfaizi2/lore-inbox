Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVATXHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVATXHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVATXHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:07:09 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:24769 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262212AbVATXGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:06:42 -0500
Date: Fri, 21 Jan 2005 00:06:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050120230616.GD22201@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <200501202246.38506.rjw@sisk.pl> <20050120220630.GB22201@elf.ucw.cz> <200501202358.53918.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202358.53918.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The readability of code is also important, IMHO.
> > 
> > It did not seem too much better to me.
> 
> Well, the beauty is in the eye of the beholder. :-)
> 
> Still, it shrinks the code (22 lines vs 37 lines), it uses less GPRs (5 vs 7), it uses less
> SIB arithmetics (0 vs 4 times), it uses a well known scheme for copying data pages.
> As far as the result is concerned, it is equivalent to the existing code, but it's simpler
> (and faster).  IMO, simpler code is always easier to understand.
> 
> 
> > > > If you want cheap way to speed it up, kill cr3 manipulation.
> > > 
> > > Sure, but I think it's there for a reason.
> > 
> > Reason is "to crash it early if we have wrong pagetables".
> > 
> > > > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> > > 
> > > I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> > > If necessary, I can change the patch to work with his code (hugang, what do you think?).
> > 
> > I think it is just not worth the effort.
> 
> Why?  It won't take much time.  I've spent more time for writing the messages
> in this thread ... ;-)

Well, I know that current code works. It was produced by C compiler,
btw. Now, new code works for you, but it was not in kernel for 4
releases, and... this code is pretty subtle. And it is hand-made, not
C produced.

So... your code may be better but I do not think it is so much better
that I'd like to risk it.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
