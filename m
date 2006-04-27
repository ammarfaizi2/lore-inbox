Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWD0TVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWD0TVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWD0TVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:21:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964919AbWD0TVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:21:05 -0400
Date: Thu, 27 Apr 2006 12:19:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-Id: <20060427121930.2c3591e0.akpm@osdl.org>
In-Reply-To: <p73vesv727b.fsf@bragg.suse.de>
References: <20060427014141.06b88072.akpm@osdl.org>
	<p73vesv727b.fsf@bragg.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> >   The acphphp driver is still broken and v4l and memory hotplug are, I
>  >   suspect, only hanging in there by the skin of their teeth.
>  > 
>  >   Could patch submitters _please_ be a lot more careful about getting the
>  >   Kconfig correct, testing various Kconfig combinations (yes sometimes
>  >   people will want to disable your lovely new feature) and just generally
>  >   think about these things a bit harder?  It isn't rocket science.
> 
>  Is this something that could be automated with some machine power? 
> 
>  e.g. every time a patch is added a small cluster could build the patches
>  with some configurations on various architectures and if it doesn't build 
>  autoflame the patch submitter.
> 
>  We use this in SUSE for the SUSE kernels and it works quite well.
> 
>  Maybe someone could contribute the build power needed for that. I suppose
>  it could be done by just a few scripts listening to mm-commits?

I suspect something like that would be quite a lot of work to set up -
first-up one has to get all the patches to actually apply, and then work
through any compile-time interactions between them.   Dunno.

I don't like dropping patches.  Because then the thing needs to be fixed up
and resent and remerged and re-reviewed and rejects need to re-fixed-up and
this adds emailing overhead and 12-24 hour turnaround, etc.  I very much
prefer to hang onto the patch and get it fixed up.  This means that I
usually have to do the fixing-up.

And that's OK - it's one of the things I do.  But it's striking how silly
so many of these problems are - they demonstrate a very basic lack of care
and thought.

It's obvious that the originators haven't even compiled their feature with
its config option disabled, or they haven't spent the requisite 30
seconds thinking about their Kconfig dependencies, or they haven't verified
that all architectures support the architecture functions which they're
relying upon or they haven't grepped the tree for symbol clashes, etc.

So at this point in time what I'd like to do is to encourage developers to
do these very basic things.  That's the low-hanging fruit right now.
