Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946070AbWKJJDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946070AbWKJJDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946087AbWKJJDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:03:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34535 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946070AbWKJJDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:03:16 -0500
Date: Fri, 10 Nov 2006 10:03:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Message-ID: <20061110090303.GB3196@elf.ucw.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com> <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz> <20061107212614.GA6730@ucw.cz> <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz> <20061107231456.GB7796@elf.ucw.cz> <Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>If some rogue threads (and it may not even be intetional) call the same
> >>syscall stressing the one spinlock all the time, other syscalls needing
> >>the same spinlock may stall.
> >
> >Fortunately, they'll unstall with probability of 1... so no, I do not
> >think this is real problem.
> 
> You can't tell that CPUs behave exactly probabilistically --- it may 
> happen that one gets out of the wait loop always too late.

Well,  I don't need them to be _exactly_ probabilistical.

Anyway, if you have 2048 CPUs... you can perhaps get some non-broken
ones.

> >If someone takes semaphore in syscall (we do), same problem may
> >happen, right...? Without need for 2048 cpus. Maybe semaphores/mutexes
> >are fair (or mostly fair) these days, but rwlocks may not be or
> >something.
> 
> Scheduler increases priority of sleeping process, so starving process 
> should be waken up first. But if there are so many processes, that
>process

I do not think this is how Linux scheduler works.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
