Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVAIBJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVAIBJy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVAIBJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:09:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:43244 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262176AbVAIBJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:09:31 -0500
Date: Sun, 9 Jan 2005 02:20:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/4] let's kill verify_area
In-Reply-To: <20050106175607.6b15b8e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501090210520.4014@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501070212560.3430@dragon.hygekrogen.localhost>
 <20050106172624.7cc2a142.akpm@osdl.org> <Pine.LNX.4.61.0501070246160.3430@dragon.hygekrogen.localhost>
 <20050106175607.6b15b8e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > On Thu, 6 Jan 2005, Andrew Morton wrote:
> > 
> > > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > > >
> > > > verify_area() if just a wrapper for access_ok() (or similar function or 
> > > > dummy function) for all arch's.
> > > 
> > > This sounds more like "let's kill Andrew".  I count 489 instances in the
> > > tree.  Please don't expect this activity to take top priority ;)
> > > 
> > Heh, right, there's an aspect I hadn't really considered.
> > I'm not expecting top priority, not at all. This is nowhere near being 
> > anything important, just something that should happen eventually - so I 
> > thought, why not just deprecate it now and let it be cleaned up over time 
> > (and I'll do my share, don't worry :)
> > 
> > Accept the patch if you think it makes sense, drop it if you think it does 
> > not (or should wait). 
> 
> The way to do this is to fix up the callers first, in just ten or so
> patches.  Then mark the function deprecated when most of the conversion is
> done.
> 
> If we deprecate the functions first then 10000 people send small fixes via
> various snaky routes and it's really hard to coordinate the overlapping
> fixes.  The s/MODULE_PARM/module_param/ stuff did that, because we made it
> warn first, then I held the big sweep patch off for 2.6.11.
> 

Ok, that makes sense.

Here's my plan then:

I'll get to work on converting roughly one tenth og the verify_area 
occourances and then post a patch for that for review. If it turns out to 
be OK I'll get to work on the rest and do as many as I can and at that 
point (assuming those patches are also OK) I'll re-submit a patch to 
deprecate the function so the remaining instances can get cleaned up and 
the function removed.
This will probably take me a few days to do since A) it seems I didn't 
even get my initial conversions correct so I'll need to be more careful, 
and B) I have limited time.  But, I'll start doing the initial 1/10'th 
patch now and hopefully post that to lkml within a few days.

Thank you for your feedback.


-- 
Jesper Juhl


