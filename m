Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932849AbWF3Rgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbWF3Rgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbWF3Rga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:36:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57325 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932849AbWF3Rg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:36:29 -0400
Date: Fri, 30 Jun 2006 19:36:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Greg KH <greg@kroah.com>, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060630173605.GA4464@elf.ucw.cz>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606290825.50674.nigel@suspend2.net> <20060628224428.GC27526@elf.ucw.cz> <200606290914.58784.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606290914.58784.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That's not true. The compression and encryption support add ~1000 lines,
> > > as you pointed out the other day. If I moved compression and encryption
> > > support to userspace, I'd remove 1000 lines and:
> > >
> > > - add more code for getting the pages copied to and from userspace
> >
> > No, if your main loop is already in userspace, you do not need to add
> > any more code. And you'd save way more than 1000 lines:
> >
> > * encryption/compression can be removed
> >
> > * but that means that writer plugins/filters can be removed
> >
> > * if you do compress/encrypt in userspace, you can remove that ugly
> > netlink thingie, and just display progress in userspace, too
> >
> > ...and then, image writing can be moved to userspace...
> >
> > * swapfile support
> >
> > * partition support
> >
> > * plus their plugin infrastructure.
> 
> That's going way beyond your inital suggestion. And you haven't responded to 
> the other points (which have instead been deleted).

Well, you were arguing that in uswsusp only "thin layer" is in
userspace, and I think I've just shown you it is more thick than you
think.

Of course I deleted your other points, or did you really want me to
argue with "copying from userspace is slow"? Hint: memory is 3GB/sec,
while disk is 50MB/sec.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
