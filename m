Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRCJP1d>; Sat, 10 Mar 2001 10:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131019AbRCJP1Y>; Sat, 10 Mar 2001 10:27:24 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131018AbRCJP1O>;
	Sat, 10 Mar 2001 10:27:14 -0500
Message-ID: <20010309122618.A449@bug.ucw.cz>
Date: Fri, 9 Mar 2001 12:26:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010307202027.B27421@ugly.wh8.tu-dresden.de> <Pine.LNX.4.20.0103081427040.3785-100000@falcon.etf.bg.ac.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.20.0103081427040.3785-100000@falcon.etf.bg.ac.yu>; from Boris Dragovic on Thu, Mar 08, 2001 at 02:29:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > did "these" apply only to the tasks, that actually hold a lock?
> > if not, then i don't like this idea, as it gives the processes
> > time for the only reason, that it _might_ hold a lock. this basically 
> > undermines the idea of static classes. in this case, we could actually
> > just make the "nice" scale incredibly large and possibly nonlinear, 
> > as mark suggested.
> 
> would it be possible to subqueue tasks that are holding a lock so that
> they get some guaranteed amount of cpu and just leave other to be executed
> when processor really idle?

There was implementation which promoted SCHED_IDLE task to normal
priority whenever it entered syscall. I liked it.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
