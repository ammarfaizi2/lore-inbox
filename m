Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVG1BnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVG1BnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVG1BnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:43:00 -0400
Received: from waste.org ([216.27.176.166]:40070 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261199AbVG1Bm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:42:58 -0400
Date: Wed, 27 Jul 2005 18:42:41 -0700
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
Message-ID: <20050728014241.GC7425@waste.org>
References: <1122473595.29823.60.camel@localhost.localdomain> <20050727141754.GA25356@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727141754.GA25356@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 04:17:54PM +0200, Ingo Molnar wrote:
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > The following patch makes the MAX_RT_PRIO and MAX_USER_RT_PRIO 
> > configurable from the make *config.  This is more of a proposal since 
> > I'm not really sure where in Kconfig this would best fit. I don't see 
> > why these options shouldn't be user configurable without going into 
> > the kernel headers to change them.
> 
> i'd not do this patch, mainly because the '100 priority levels' thing is 
> pretty much an assumption in lots of userspace code. The patch to make 
> it easier to redefine it is of course fine and was accepted, but i dont 
> think we want to make it explicit via .config.
> 
> It's a bit like with the 3:1 split: you can redefine it easily via 
> include files, but it's not configurable via .config, because many 
> people would just play with it and would see things break.
> 
> so unless there's really a desire from distributions to actually change 
> the 100 RT-prio levels (and i dont sense such a desire), we shouldnt do 
> this.

The queues take a fairly substantial amount of memory. I've had an
option for configuring this under CONFIG_EMBEDDED in the -tiny tree
for quite some time.

-- 
Mathematics is the supreme nostalgia of our time.
