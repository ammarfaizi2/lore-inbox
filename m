Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVCCKQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVCCKQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVCCKQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:16:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:19369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262273AbVCCKPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:15:44 -0500
Date: Thu, 3 Mar 2005 02:15:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303021506.137ce222.akpm@osdl.org>
In-Reply-To: <4226D655.2040902@pobox.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002047.GA10434@kroah.com>
	<Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
	<20050303081958.GA29524@kroah.com>
	<4226CCFE.2090506@pobox.com>
	<20050303090106.GC29955@kroah.com>
	<4226D655.2040902@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> We need to not only produce a useful kernel, but also package it in a 
>  way that is useful to the direct consumers of the kernel:  distros 
>  [large and small] and power users.

This comes down to the question "what are we making"?  Is it an end
product, or is it a technology which can be turned into an end product? 
Because the two are different things.

I'd say that mainline kernel.org for the past couple of years has been a
technology, not a product.

We do put effort into productising that technology every couple of months
because that's what a (very important) minority of our users want, and
because it is good discipline, but productisation hasn't been the main
focus.

If we were to get serious with maintenance of 2.6.x.y streams then that is
a 100% productisation activity.  It's a very useful activity, and there is
demand for it.  But it is a very different activity.  And a lot of this
discussion has been getting these two activities confused.



But there's something else:

I would maintain that we're still fixing stuff faster than we're breaking
stuff.  If you look at the fixes which are going into the tree (and there
are a HUGE number of fixes), many of them are addressing problems which have
been there for a long time.

So as long as we remain in this state, we don't need to do anything.  The
technology gets closer to a product until we reach the stage where the
fixage rate equals the breakage rate.   And we're not there yet.

(It's nice that patches are called "fix the frobnozzle gadget", but this
analysis would be a lot easier if people would also label their patches
"break the frobnozzle gadget" when that's what they do.  Oh well).

So I'd suspect that on average, kernel releases are getting more stable. 
But the big big problem we have is that even though we fixed ten things for
each one thing we broke, those single breakages tend to be prominent, and
people get upset.  It's fairly bad PR that Dell Inspiron keyboards don't
work in 2.6.11, for example...

And people will incorrectly (and even wildly) generalise as a result of
such silly little isolated bugs.  We can wholly address such problems with
a 2.6.x.y productisation series.



And something else:

I don't think 2.2 and 2.4 models are applicable any more.  There are more
of us, we're better (and older) than we used to be, we're better paid (and
hence able to work more), our human processes are better and the tools are
better.  This all adds up to a qualitative shift in the rate and accuracy
of development.  We need to take this into account when thinking about
processes.

It's important to remember that all those kernel developers out there
*aren't going to stop typing*.  They're just going to keep on spewing out
near-production-quality code with the very reasonable expectation that
it'll become publically available in less than three years.  We need
processes which will allow that.




And another else:


Many people on this mailing list want a super-stable kernel as their first
(and sometimes only) priority (the product group).  But others have other
requirements: to make their code avaialble, or to get their hardware
supported, or to fix that scalability problem (the technology group).  The
product group's interests are in conflict with the technology group's. 

There will be no solution to this problem which is completely satisfactory
to either party.


>  What do those direct consumers really want?  What best serves them?

That's the primary question, of course.

Except I'd replace the term "consumers" with the more general term
"customers".  And I'd then say that, for example, the SGI Altix development
group is a customer of the kernel development team.

And how do we satisfy that customer?  By merging scary patches and hence
screwing your "consumers" ;)

oops.  Tension..


