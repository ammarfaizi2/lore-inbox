Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbULABAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbULABAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbULAA75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:59:57 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27914 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261201AbULAAsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:48:19 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411301636050.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <8219.1101828816@redhat.com>
	 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
	 <1101854061.4574.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
	 <1101858657.4574.33.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
	 <1101860688.4574.50.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301636050.22796@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 00:47:37 +0000
Message-Id: <1101862057.4574.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 16:37 -0800, Linus Torvalds wrote:
> 
> On Wed, 1 Dec 2004, David Woodhouse wrote:
> > 
> > The concept isn't at all hard to understand. But no patch is 'obviously
> > correct' if you want to protect against the _slightest_ possibility that
> > people might be abusing something you're taking away. 
> 
> I really disagree. That's kind of my point. We _can_ make sure that there 
> is abzolutely zero semantic content change.

We've _never_ made sure that there's absolutely zero semantic content
change in our private headers.

> People both inside and outside the kernel who use the old <linux/xxx.h>
> headers will get exactly what they got before if we do it right.

They'll get that if we change nothing at all.

> > Some people might define __KERNEL__ on purpose when compiling something
> > in userspace, to get something that would otherwise be hidden from them.
> > Would you consider that sacrosanct too?
> 
> Why _do_ you want to break things? Do the cleanup. Don't do the breakage.

I'm trying to understand precisely where _you_ want to draw the line
between 'cleanup' and 'breakage'. 

You obviously don't agree that including atomic.h was an entirely stupid
thing for userspace to be doing in the first place, and that it's
reasonable for that not to compile in future; you believe that it should
continue to compile and silently do the wrong thing. We've covered that
much.

So where _do_ you draw the line? Trying to use spinlock.h? Defining
__KERNEL__ before including kernel headers?

I can try to apply common sense here, having discussed it with a bunch
of other people. But you don't seem to agree with that; hence further
guidance would be appreciated. But we can just submit patches to do the
cleanups and see what you take and what you don't, if you really want to
make us jump through hoops for the sake of it without indicating what
you'd accept and what you'd not beforehand.

-- 
dwmw2

