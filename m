Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273463AbRIYT7n>; Tue, 25 Sep 2001 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273455AbRIYT7d>; Tue, 25 Sep 2001 15:59:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46608 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273463AbRIYT7X>; Tue, 25 Sep 2001 15:59:23 -0400
Date: Tue, 25 Sep 2001 21:59:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tommy Reynolds <reynolds@redhat.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: GFP_FAIL?
Message-ID: <20010925215950.C17829@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010924210951.A165@bug.ucw.cz> <20010925144611.01590a08.reynolds@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925144611.01590a08.reynolds@redhat.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I need to alloc as much memory as possible, *but not more*. I do not
> > want to OOM-kill anything. How do I do this? Tried GFP_KERNEL, will
> > oom-kill. GFP_USER will OOM-kill, too.
> 
> Try GFP_ATOMIC; GFP_KERNEL sets the __GFP_WAIT flag and you don't
> want that.

No, I want other apps to be moved to swap, dirty data written out
etc. I really can't live with GFP_ATOMIC. 

> But, if you're really asking how to know how large the current working set is,
> so that you don't grab more than your applications are going to need and
> eventually OOM, you'll need to set GFP_HAVE_CRYSTAL_BALL ;-)

I want to push just as much that I do not cause OOM. I'll stop
applications real soon after that.

							Pavel
-- 
Causalities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
