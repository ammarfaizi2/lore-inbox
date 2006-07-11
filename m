Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWGKJFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWGKJFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWGKJFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:05:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750803AbWGKJFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:05:54 -0400
Date: Tue, 11 Jul 2006 11:05:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/2] swsusp: clean up browsing of pfns
Message-ID: <20060711090525.GE1787@elf.ucw.cz>
References: <200607102240.45365.rjw@sisk.pl> <200607102251.40083.rjw@sisk.pl> <20060711083415.GB1787@elf.ucw.cz> <20060711015941.d35f0b7d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711015941.d35f0b7d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-07-11 01:59:41, Andrew Morton wrote:
> On Tue, 11 Jul 2006 10:34:15 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > > Clean up some loops over pfns for each zone in snapshot.c: reduce the number
> > > of additions to perform, rework detection of saveable pages and make the code
> > > a bit less difficult to understand, hopefully.
> > 
> > Also remove the BUG_ON() so that you can solve Andrew's monster
> > machine problem.
> 
> I don't understand your comment.  I assume you're adding an explanation for
> the removal of:
> 
> -	BUG_ON(PageReserved(page) && PageNosave(page));
> 
> from saveable_page().

Yes.

> But my emt64 test box is oopsing when touching a hole in the memory-map; it
> isn't going BUG() (any more than usual ;))

Well, it would go BUG() with patch Rafael has somewhere on the
disk. Next step is having pages both reserved and nosave, I believe.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
