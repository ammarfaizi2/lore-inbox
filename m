Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWFZQCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFZQCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWFZQCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:02:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14519 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750721AbWFZQCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:02:50 -0400
Date: Mon, 26 Jun 2006 18:02:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
Message-ID: <20060626160239.GA3257@elf.ucw.cz>
References: <200606211716.01472.a1426z@gawab.com> <Pine.LNX.4.61.0606220741540.25261@yvahk01.tjqt.qr> <200606222036.39908.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606222036.39908.a1426z@gawab.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-06-22 20:36:39, Al Boldi wrote:
> Jan Engelhardt wrote:
> > >Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
> > >
> > >This can be seen running top d.1, that shows top, itself, consuming 0ms
> > >CPUtime.
> > >
> > >Will this bug have consequences for sched.c?
> >
> > Works for me, somewhat.
> > TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on this
> > CPU.)
> 
> That's what I thought for a long time.  But at closer inspection, top d.1 
> slows down other apps by about the same amount of time at 1000Hz and 100Hz, 
> only at 1000Hz it is accounted for whereas at 100Hz it is not.

It is not a bug... it is design decision. If you eat "too little" cpu
time, you'll be accouted 0 msec. That's what happens at 100Hz...
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
