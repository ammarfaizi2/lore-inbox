Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVHMV3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVHMV3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 17:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVHMV3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 17:29:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:19874 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932325AbVHMV3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 17:29:44 -0400
Date: Sat, 13 Aug 2005 23:29:24 +0200
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk, gerg@uclinux.org, jdike@karaya.com,
       sammy@sammy.net, lethal@linux-sh.org, wli@holomorphy.com,
       davem@davemloft.net, matthew@wil.cx, geert@linux-m68k.org,
       paulus@samba.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       dev-etrax@axis.com, rpurdie@rpsys.net, spyro@f2s.com,
       Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Convert sigaction to act like other unices
Message-ID: <20050813212924.GQ22901@wotan.suse.de>
References: <1123900802.5296.88.camel@localhost.localdomain> <20050813123956.GN22901@wotan.suse.de> <1123941614.5296.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123941614.5296.112.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2005 at 10:00:14AM -0400, Steven Rostedt wrote:
> On Sat, 2005-08-13 at 14:39 +0200, Andi Kleen wrote:
> > On Fri, Aug 12, 2005 at 10:40:02PM -0400, Steven Rostedt wroqte:
> > > Here's a patch that converts all architectures to behave like other unix
> > > boxes signal handling.  It's funny that I didn't need to change the m68k
> > > architecture, since it was the only one that already behaves this way!
> > > (the m68knommu does not!)
> > 
> > <rest snipped which also wasn't better>
> > 
> > This is not a description of what you changed. A patch entry has to 
> > start with a rationale and then a description of the change.
> 
> Sorry, I forgot that not all were in on the thread.  (duh, I added a
> bunch of others, I guess I wasn't thinking clearly).

I actually read the thread, but patches with useless descriptions
like your previous one cannot be applied in general because you cannot expect
that people later looking at the <VCS system of the week> logs 
know about some obscure thread months or years before. Or rather
the person who applied it would need to write a better description
on his own, which is not their job.

My general feeling about the change is that it risks breaking programs
and doesn't seem to have any compelling advantages,
so unless there is a bug demonstrated I wouldn't apply it.

-Andi

