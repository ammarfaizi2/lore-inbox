Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWD0T0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWD0T0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWD0T0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:26:34 -0400
Received: from mail.suse.de ([195.135.220.2]:5553 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965019AbWD0T0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:26:33 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc2-mm1
Date: Thu, 27 Apr 2006 21:26:30 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org> <p73vesv727b.fsf@bragg.suse.de> <20060427121930.2c3591e0.akpm@osdl.org>
In-Reply-To: <20060427121930.2c3591e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604272126.30683.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 21:19, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > >   The acphphp driver is still broken and v4l and memory hotplug are, I
> >  >   suspect, only hanging in there by the skin of their teeth.
> >  > 
> >  >   Could patch submitters _please_ be a lot more careful about getting the
> >  >   Kconfig correct, testing various Kconfig combinations (yes sometimes
> >  >   people will want to disable your lovely new feature) and just generally
> >  >   think about these things a bit harder?  It isn't rocket science.
> > 
> >  Is this something that could be automated with some machine power? 
> > 
> >  e.g. every time a patch is added a small cluster could build the patches
> >  with some configurations on various architectures and if it doesn't build 
> >  autoflame the patch submitter.
> > 
> >  We use this in SUSE for the SUSE kernels and it works quite well.
> > 
> >  Maybe someone could contribute the build power needed for that. I suppose
> >  it could be done by just a few scripts listening to mm-commits?
> 
> I suspect something like that would be quite a lot of work to set up -
> first-up one has to get all the patches to actually apply, and then work
> through any compile-time interactions between them.   Dunno.

The invariant could be that any single new patch added should still
compile. And it should apply of course. If not then warn the submitter.
Might generate quite a lot of email though.

Problem is when people add new stuff in multiple pieces that only
compile together though. iirc they go to mm-commits as individual
pieces, not a bundle right now.

It would probably not catch everything - just a few common
configurations and architectures.

> 
> I don't like dropping patches.  Because then the thing needs to be fixed up
> and resent and remerged and re-reviewed and rejects need to re-fixed-up and
> this adds emailing overhead and 12-24 hour turnaround, etc.  I very much
> prefer to hang onto the patch and get it fixed up.  This means that I
> usually have to do the fixing-up.

If it's caught early enough the submitter can be warned and they
might even fix it up themselves and send a new patch.

> So at this point in time what I'd like to do is to encourage developers to
> do these very basic things.  That's the low-hanging fruit right now.

Write a checklist for that?

-Andi 
