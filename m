Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTLBGqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 01:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTLBGqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 01:46:22 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:64402 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261262AbTLBGqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 01:46:20 -0500
Date: Tue, 2 Dec 2003 17:44:18 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>, pinotj@club-internet.fr
Cc: manfred@colorfullife.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031202064418.GA2312@frodo>
References: <mnet1.1070127696.1558.pinotj@club-internet.fr> <Pine.LNX.4.58.0312011606200.2733@home.osdl.org> <20031202013716.GG621@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202013716.GG621@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Tue, Dec 02, 2003 at 12:37:16PM +1100, Nathan Scott wrote:
> On Mon, Dec 01, 2003 at 04:36:33PM -0800, Linus Torvalds wrote:
> > 
> > I assume it's not an option to try another filesystem on this setup, but
> > it's entirely possible that the 2.6.x buffer-head removal has impacted XFS
> > negatively - although I'm a bit surprised at how easily you seem to show
> > problems, since XFS actually has active maintenance.
> > 
> > Nathan - I don't know if you follow linux-kernel, but Jerome Pinot has
> 
> Yep, although I try to filter out "noise" and have inadvertently
> missed this discussion so far.
> 
> > been having bad slab problems for some time now. Do normal XFS users
> > compile with slab debugging turned on?
> 
> Hmm - I know I do - my nightly QA testing runs with this set.
> Let me dig through the archives and catch up a bit on this issue;
> I'll get back to you.

OK, I've run XFS through hours and hours of very heavy stress now,
using a variety of different tests, and have tried different mount
and mkfs options as well.  And with a few kernel compiles thrown in
in the background for good measure.  Either we have quite different
hardware configs, compilers, etc; or this is something else.  This
was done with preempt enabled too (which I usually test without).

I'm not seeing anything to suggest random slab corruption, and I'm
so far unable to trip things up as easily as you're able to Jerome.
Do you have just a very small amount of memory perhaps?  I can try
running while very low on memory, but thats the only other obvious
thing I can think of atm.

cheers.

-- 
Nathan
