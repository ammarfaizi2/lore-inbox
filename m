Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVBYPDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVBYPDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVBYPB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:01:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:18077 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262714AbVBYPBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:01:39 -0500
Date: Fri, 25 Feb 2005 16:01:38 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, riel@redhat.com,
       linux-kernel@vger.kernel.org, Ian.Pratt@cl.cam.ac.uk,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20050225150138.GA32519@wotan.suse.de>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D1E3291@liverpoolst.ad.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D1E3291@liverpoolst.ad.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Phase 1 is for us to submit a load of patches that squeeze out the low
> hanging fruit in unifying xen/i386 and i386. Most of these will be
> strict cleanups to i386, and the result will be to almost halve the
> number of files that we need to modify.

Sounds good. I would try to track that for x86-64 too then when
possible to make the later x86-64 merge easier.

> 
> The next phase is that we re-organise the current arch/xen as follows:
> 
> We move the remaining (reduced) contents of arch/xen/i386 to
> arch/i386/xen (ditto for x86_64). We then move the xen-specific files

What would these files be? 

> that are shared between all the different xen architectures to
> drivers/xen/core. I know this last step is a bit odd, but it's the best
> location that Rusty Russel and I could come up with.
> 
> At this point, I'd hope that we could get xen into the main-line tree.
> 
> The final phase is to see if we can further unify more native and xen
> files. This is going to require some significant i386 code refactoring,
> and I think its going to be much easier to do if all the code is in the
> main-line tree so that people can see the motivation for what's going
> on.

Hmm, I would prefer to do that during the merge. I'm not sure there
will be that much push afterwards to unify stuff, and then we might
be stuck with an inferior setup.

I don't think it makes much difference for review if the previous
code is in mainline or not.

-Andi
