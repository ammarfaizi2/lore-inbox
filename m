Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbRESTrr>; Sat, 19 May 2001 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262121AbRESTrh>; Sat, 19 May 2001 15:47:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12307 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262106AbRESTr1>; Sat, 19 May 2001 15:47:27 -0400
Date: Sat, 19 May 2001 12:47:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <20010519214443.B9550@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0105191245360.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Pavel Machek wrote:
> 
> > Don't get _too_ hung up about the power-management kind of "invisible
> > suspend/resume" sequence where you resume the whole kernel state.
> 
> Ugh. Now I'm confused. How do you do usefull resume from disk when you
> don't restore complete state? Do you propose something like "write
> only pagecache to disk"?

Go back to the original _reason_ for this whole discussion. 

It's not really a "resume" event, it's a "populate caches really
efficiently at boot" event. But the two are basically the same problem,
it's only a matter of how much you populate (do you populate _everything_
or do you populate just disk caches. Populating just the caches is the
smaller and simpler problem, that only solves the "fast boot" issue).

		Linus

