Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263593AbUEGOZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUEGOZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUEGOZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:25:23 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:12672 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263593AbUEGOZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:25:12 -0400
Date: Thu, 6 May 2004 15:08:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040506130846.GA241@elf.ucw.cz>
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <20040429133613.791f9f9b.pj@sgi.com> <20040429141947.1ff81104.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429141947.1ff81104.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > How on earth is the kernel supposed to know that for this one particular
> > > job you don't care if it takes 3 hours instead of 10 minutes,
> > 
> > I'd pay ten bucks (yeah, I'm a cheapskate) for an option that I could
> > twiddle that would mark my nightly updatedb and backup jobs as ones to
> > use reduced memory footprint (both for file caching and backing user
> > virtual address space), even if it took much longer.
> > 
> > So, rather than protest in mock outrage that it's impossible for the
> > kernel to know this, instead answer the question as stated in all
> > seriousness ... well ... how _could_ the kernel know, and what _could_
> > the kernel do if it knew.  What mechanism(s) would be needed so that
> > the kernel could restrict a jobs memory usage?
> 
> Two things:
> 
> a) a knob to say "only reclaim pagecache".  We have that now.
> 
> b) a knob to say "reclaim vfs caches harder".  That's simply a matter of boosting
>    the return value from shrink_dcache_memory() and perhaps shrink_icache_memory().
> 
> It's not quite what you're after, but it's close.

Perhaps what we really want is "swap_back_in" script? That way you
could do "updatedb; swap_back_in" in cron and be happy.

								Pavel
-- 
When do you have heart between your knees?
