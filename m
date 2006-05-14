Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWENQXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWENQXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWENQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:23:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32914 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751485AbWENQXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:23:22 -0400
Date: Sun, 14 May 2006 18:22:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Message-ID: <20060514162236.GF2438@elf.ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz> <200605120652.55658.david-b@pacbell.net> <1147565632.21291.15.camel@localhost.localdomain> <200605140851.29221.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605140851.29221.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 14-05-06 08:51:26, David Brownell wrote:
> On Saturday 13 May 2006 5:13 pm, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-05-12 at 06:52 -0700, David Brownell wrote:
> > > On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> > > > 
> > > > What will be impacted by this?
> > > 
> > > Driver suspend/resume testing ... impact is strongly negative.
> > > ...
> > > Which IMO makes removing this a Bad Thing.  It needs to have some
> > > kind of replacement in place before the "magic numbers" go away.
> > 
> > And that's why Pavel is not proposing to remove it right away... but to
> > schedule it's removal so that developpers know right now that building a
> > whole new kernel<->user interface based on that is not the smartest
> > thing to do.
> 
> How could we schedule the removal before we have even had a couple
> releases to fine-tune its replacement, and verify that the main issues
> with the current thing are fully resolved?
> 
> ... plus, removing the whole power/* directory is clearly wrong.  The
> issue that's been acknowledged is only with the contents of a single
> file, power/state, not the whole directory.

Sorry, I meant only ../state file. Fixed locally.

> There may be a bit of a gap in the process here.  "July 2007" is a
> date that's not backed up by anything more than agreement that the
> current approach is a lose.  Deprecation is not the same as removal.

Maybe date will need to be shifted...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
