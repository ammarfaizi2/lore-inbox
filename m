Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313668AbSDURpE>; Sun, 21 Apr 2002 13:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313675AbSDURpE>; Sun, 21 Apr 2002 13:45:04 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:61859 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313668AbSDURpC>;
	Sun, 21 Apr 2002 13:45:02 -0400
Date: Sun, 21 Apr 2002 13:45:00 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@work.bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421134500.A7828@havoc.gtf.org>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com> <20020421133225.F4479@havoc.gtf.org> <20020421103923.I10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 10:39:23AM -0700, Larry McVoy wrote:
> On Sun, Apr 21, 2002 at 01:32:25PM -0400, Jeff Garzik wrote:
> > On Sun, Apr 21, 2002 at 10:23:39AM -0700, Larry McVoy wrote:
> > > > IOW, I propose to create a "linuspush" script that replaces his current
> > > > "bk push" command.  Linus pushes batches of csets out at a time,
> > > > make these cset batches the pre-patches...
> > > 
> > > This is easily doable as a trigger.  I'm pretty sure that all you want
> > > is
> > 
> > Not quite -- pre-patches are a one-big-patch, diffed against the most
> > recently released kernel.  
> 
> That's easier yet.
> 
> 	bk diffs -Cv2.5.8
> 
> > One quality of all traditional Linus pre-patches and patches is that
> > if you have N csets modifying a single file, you see N gnu-style diff
> > modifications, instead of the single one you would get when generating
> > the patch via GNU diff.
> 
> Did you get that backwards?  Do you want to see N diffs on a single
> file or do you want one?  We can do either, diffs -C does one.

Didn't get it backwards, I misunderstood BK.

It sounds like 'bk diffs -C' does what I want.


> Also, we're planning on making a "push stack", which remembers the set of
> csets pushed each time, so you can do
> 
> 	bk undo	# remove the last push effects
> 	bk undo	# remove the last push effects
> 	..
> 	bk undo	# remove the clone effects and destroy the repository
> 
> You could use that to generate these patches you want.

Gnifty... I don't know that I would ever use the multiple-undo stack,
but being able to see a single GNU-style patch for set of "what I just
downloaded in the last bk pull" would definitely come in handy.
(substitute "last bk pull" with "a bk pull N pulls ago" if you like)

	Jeff


