Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWEYVoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWEYVoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWEYVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:44:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28383 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030447AbWEYVom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:44:42 -0400
Date: Thu, 25 May 2006 23:43:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: kronos@kronoz.cjb.net
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp in 2.6.16: works fine w/o PSE...
Message-ID: <20060525214350.GC6347@elf.ucw.cz>
References: <20060524230538.GA616@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524230538.GA616@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm CC-ing the two swsusp gurus ;)
> 
> > I was just feeling lucky and tried suspend-to-disk cycle
> > on my VIA C3 machine, which lacks PSE which is marked as
> > being required for swsusp to work.  After commenting out
> > the PSE check in include/asm-i386/suspend.h and rebooting,
> > I tried the whole cycle, several times, with real load
> > (while running 3 kernel compile in parallel) and while
> > IDLE... And surprizingly, it all worked flawlessly for
> > me, without a single glitch...
> > 
> > So the question is: is PSE really needed nowadays?

I think so. Or can you prove that pagetables are not going to be
overwritten in wrong order in !PSE case?

Look at x86-64 how !PSE case can be solved, but it is a bit of code.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
