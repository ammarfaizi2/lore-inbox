Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbWBHInW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWBHInW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWBHInW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:43:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48213 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030505AbWBHInV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:43:21 -0500
Date: Wed, 8 Feb 2006 09:45:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mrmacman_g4@mac.com, ak@suse.de, hch@infradead.org, jeffm@suse.com,
       linux-kernel@vger.kernel.org, kernel-bugzilla@luksan.cjb.net
Subject: Re: quality control
Message-ID: <20060208084522.GC4338@suse.de>
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com> <43E6BF48.5010301@namesys.com> <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com> <p73hd7clp5k.fsf@verdi.suse.de> <96DB44F5-85D3-4F78-8417-D5AB9303D696@mac.com> <20060206134415.GZ13598@suse.de> <20060207144433.6bdc4f66.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207144433.6bdc4f66.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Look, it's really simple: lets say I make a change that has to do with
> > PM, you do a quick compile test with and _without_ PM just to check you
> > didn't screw anything up with that change. You change reiserfs acl
> > stuff, you do a quick compile test with and without that configured.
> > 
> > It's a pretty standard procedure, and contrary to what you think, it
> > _is_ required before submitting a patch. No one is asking anyone to
> > check all possible configure options, but the interesting data set is
> > typically extremely easy to guess looking at a change.
> 
> <rofl>
> 
> bix:/usr/src/op> find patches -name '*build-fix*' | wc -l
>     533
> 
> bix:/usr/src/op> find patches -name '*fix.patch' | wc -l
>    5109
> 
> A lot of people don't make the slightest effort.  But it's not a big
> problem, really.  Silly build errors are reported early and are almost
> always trivial to fix.  The major drawback is that they can wreck a -mm
> release for many testers.

That's precisely the problem, it may be really simple to fix but often
will stop people from testing.

Your fix count probably isn't totally accurate either, I bet a lot of
these are fixups due to conflicts with other patches. I'm talking about
the fact that someone sends Linus a patch which doesn't compile for the
case you could (and should) have trivially checked. A little edumacation
never hurt :-)

-- 
Jens Axboe

