Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbREWMGv>; Wed, 23 May 2001 08:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbREWMGl>; Wed, 23 May 2001 08:06:41 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2147 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263062AbREWMG3>; Wed, 23 May 2001 08:06:29 -0400
Date: Wed, 23 May 2001 12:29:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Getting FS access events
Message-ID: <20010523122950.E27177@redhat.com>
In-Reply-To: <20010519214443.B9550@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0105191245360.14472-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105191245360.14472-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 12:47:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 19, 2001 at 12:47:15PM -0700, Linus Torvalds wrote:
> 
> On Sat, 19 May 2001, Pavel Machek wrote:
> > 
> > > Don't get _too_ hung up about the power-management kind of "invisible
> > > suspend/resume" sequence where you resume the whole kernel state.
> > 
> > Ugh. Now I'm confused. How do you do usefull resume from disk when you
> > don't restore complete state? Do you propose something like "write
> > only pagecache to disk"?
> 
> Go back to the original _reason_ for this whole discussion. 
> 
> It's not really a "resume" event, it's a "populate caches really
> efficiently at boot" event.

Then you'd better be sure that the cache (or at least, the saved
image) only contains data which is guaranteed not to be written
between successive restores from the same image.  The big advantage of
just resuming from the state of the previous shutdown (whether it's
cache or the whole kernenl state) is that you've got a much higher
expectation that nothing on disk got modified between the save and the
restore.

--Stephen
