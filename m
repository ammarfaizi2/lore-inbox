Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVCNRWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVCNRWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVCNRWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:22:52 -0500
Received: from mail.tmr.com ([216.238.38.203]:37387 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261628AbVCNRWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:22:40 -0500
Date: Mon, 14 Mar 2005 12:10:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Greg KH <greg@kroah.com>
cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
In-Reply-To: <20050311220150.GA4925@kroah.com>
Message-ID: <Pine.LNX.3.96.1050314115353.4343A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Greg KH wrote:

> On Fri, Mar 11, 2005 at 11:19:28AM -0800, Chris Wright wrote:
> > * Matt Mackall (mpm@selenic.com) wrote:
> > > Or do you want to do it the same way you do for every other branch? I
> > > don't want to special-case it in my code and I don't think users want
> > > to special-case it in their brains. Have separate interdiffs on the
> > > side, please, and then people can choose, but do it the standard way.
> > > 
> > > Dear ${SUCKER}s, can we have a decision on this? My ketchup tool is
> > > broken for 2.6.11.2 and I don't want to cut a new release until a firm
> > > decision is made. Obviously I have a strong preference for all 2.6.x.y
> > > diffs being against 2.6.x, it means that .y can be treated the same as
> > > -rc, -bk, -mm, ... (and I already coded it that way when 2.6.8.1 came
> > > out).
> > 
> > I agree with having the patch be against .x, with x.y -> x.y+1 interdiffs
> > available on the side.  Greg, any issue with that?
> 
> No, I agree with that, and will not be hard to do at all (the release
> script already handles this just fine.)  
> 
> I've held off rediffing 2.6.11.2 so far, as I don't know where to put
> the x.y+1 interdiffs?  kernel/v2.6/incr/ ?  Any thoughts?

I guess incr is as good as any, I thought you would put the "against base" 
somewhere, having already decided to do incrementals. Hopefully you will
at least change the numbering on the patch file (no, not the version in
the Makefile), so patch 2.6.11.3i is againt 2.6.11.2, and 2.6.11.3 is
against 2.6.11. That way people can tell after the download which one they
have if they forget.

I didn't like the initial decision to go incremental, and I even less like
changing now, but it's the right thing to do. It's not like we have a big
investment in scripts or anything, and you're doing the work.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

