Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbRESTpR>; Sat, 19 May 2001 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbRESTo7>; Sat, 19 May 2001 15:44:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262194AbRESTow>; Sat, 19 May 2001 15:44:52 -0400
Date: Sat, 19 May 2001 21:44:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010519214443.B9550@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010515161750.B38@toy.ucw.cz> <Pine.LNX.4.21.0105191238040.14472-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0105191238040.14472-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 12:39:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > resume from disk is actually pretty hard to do in way it is readed linearily.
> > 
> > While playing with swsusp patches (== suspend to disk) I found out that
> > it was slow. It needs to do atomic snapshot, and only reasonable way to
> > do that is free half of RAM, cli() and copy.
> 
> Note that "resume from disk" does _not_ have to necessarily resume kernel
> data structures. It is enough if it just resumes the caches etc. 

> Don't get _too_ hung up about the power-management kind of "invisible
> suspend/resume" sequence where you resume the whole kernel state.

Ugh. Now I'm confused. How do you do usefull resume from disk when you
don't restore complete state? Do you propose something like "write
only pagecache to disk"?
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
