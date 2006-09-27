Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWI0JJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWI0JJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWI0JJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:09:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53985 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751029AbWI0JJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:09:28 -0400
Date: Wed, 27 Sep 2006 11:09:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060927090902.GC24857@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz> <20060925160648.de96b6fa.akpm@osdl.org> <20060925232151.GA1896@elf.ucw.cz> <20060925172240.5c389c25.akpm@osdl.org> <20060926102434.GA2134@elf.ucw.cz> <20060926094607.815d126f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926094607.815d126f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is "swapoff -a; echo disk > /sys/power/state" slow for you? If so, we
> > have something reasonably easy to debug, if not, we'll try something
> > else...
> 
> sony:/home/akpm# swapoff -a 
> sony:/home/akpm# time (echo disk > /sys/power/state) 
> echo: write error: no such device
> (; echo disk > /sys/power/state; )  0.00s user 0.08s system 1% cpu 5.259 total
> 
> It took an additional two-odd seconds to bring the X UI back into a serviceable
> state.

Console switches take long... yes it would be nice to fix X :-).

But we did not reproduce that 12 seconds problem. Can you try patches
from

http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw

?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
