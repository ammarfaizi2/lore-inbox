Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932949AbWFWJTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbWFWJTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbWFWJTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:19:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18048 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932949AbWFWJS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:18:59 -0400
Date: Fri, 23 Jun 2006 11:18:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-ID: <20060623091801.GB5343@elf.ucw.cz>
References: <1150297122.31522.54.camel@lappy> <20060616204024.GA7097@ucw.cz> <1150526492.28517.26.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150526492.28517.26.camel@lappy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Some folks find 128KB of env+arg space too little. Solaris provides them with
> > > 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> > > would like to run the supported vendor kernel.
> > > 
> > > In the interrest of not penalizing everybody with the overhead of just
> > > setting it larger, provide a sysctl to change it.
> > 
> > I very muh like that idea.
> > 
> > > Compiles and boots on i386.
> > > 
> > > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > ....but does is also work if you keep changing that value in the tight
> > loop while trying to work with the system?
> > 
> 
> Yes, I've added a bprm local copy of max_arg_pages:

Thanks for explanation.

I've been upping that value 10 times on all my systems, so yes, I'd
like to see that configurable.

You probably want to mail it to lkml, cc: akpm, and see what happens.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
