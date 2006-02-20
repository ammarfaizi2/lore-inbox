Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWBTQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWBTQmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWBTQmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:42:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161010AbWBTQl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:41:59 -0500
Date: Mon, 20 Feb 2006 17:41:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220164129.GB19156@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140437152.3429.20.camel@mindpipe> <20060220123122.GA6086@dspnet.fr.eu.org> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220153922.GA17362@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Even with wanting to move as many things to 
> > > userspace as possible, merging suspend2 with cleanups if necessary,
> > > _then_ starting from there to move things to userspace seems more
> > > realistic long-term.
> > 
> > The _only_ thing we moved to the user space was the writing and reading
> > of the image.  [We moved it quite literally, by porting the analogous swsusp
> > code from the current -mm.]
> > 
> > Currently we are _not_ moving _anything_ to the user space.  We're just
> > _implementing_ some things in the user space, but _not_ from scratch.
> 
> >From what I see of the messages in this thread, at that point you're
> just trying to play catchup with suspend2.  Don't that feel a little
> strange to you?  You know you have working GPL code handy, tested with
> happy users, with a maintainer who would be happy to have it in the
> kernel, and instead of making it better you spend your talents redoing
> the same functionality only slightly differently.  Why?  Just for a
> semireligious argument on where the userspace/kernelspace separation
> should be in the suspend process?

There is 14000 lines of code that is very far away from being
mergeable into kernel. It is less work to reimplement it in userspace
than clean it up for kernel inclusion. 

And no, Nigel is *not* willing to help. He's willing to fix small
problems, but not big ones.

> > The problem is to merge suspend2 we'd have to clean it up first and
> > actually solve some problems that it works around.  That, arguably,
> > would be more work than just implementing some _easy_ stuff in the
> > user space.
> 
> Stuff that is _already_ _done_ and working.

It is not done. It is too ugly, and it is not done in a way that could
be merged into kernel.

> Are you really, really sure you're not rejecting suspend2 in bulk
> because you didn't write it?  Do we need a John W. Linville as suspend
> maintainer for things to go better?
> 
> Please tell me what is wrong in my perception of what is going on.
> 
>   OG, not even a suspend2 user.

...and probably never seen suspend2 patch.

If you see suspend2 patch, and still feel some parts of it are good
and could be reused in userspace, feel free to help.

> [1] Look at s2ram.c and puke.  I understand it has been clobbed
> together for testing and as such does not pretend to be of any
> quality, but it's so bad it's painful.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
