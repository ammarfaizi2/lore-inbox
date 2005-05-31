Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEaWP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEaWP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVEaWP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:15:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24332
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261155AbVEaWPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:15:19 -0400
Date: Wed, 1 Jun 2005 00:15:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
Subject: Re: RT patch acceptance
Message-ID: <20050531221505.GZ5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk> <1117556283.2569.26.camel@localhost.localdomain> <20050531171143.GS5413@g5.random> <1117561379.2569.57.camel@localhost.localdomain> <20050531175152.GT5413@g5.random> <1117564192.2569.83.camel@localhost.localdomain> <20050531205424.GV5413@g5.random> <1117574551.5511.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117574551.5511.19.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 05:22:31PM -0400, Steven Rostedt wrote:
> it.  If the -RT patch is merged, then all that would be needed is a
> CONFIG option set.

If RT is merged and RTAI not, that might be simpler to install, but I
wouldn't judje on what's simpler to use based on mainline inclusion or
not. I don't work in the emebdded-RT space, but if I had to build an
hard-RT embedded app for myself and I didn't need to run syscalls in
real time (i.e. no audio ioctls), I'd sure start with RTAI.

> I wouldn't call RTAI, RTLinux or a nano-kernel (embedded with Linux)
> "Diamond" hard.  Maybe "Ruby" hard, but not diamond.  Remember, I use to
> test code that was running airplane engines, and none of those mentioned
> would qualify to run that.  I wouldn't want to be in an airplane that
> had one of those as the main OS unless someone really stripped them down
> or did the real work to verify them.

Sure agreed. But the main reliability problem that makes it only "ruby"
isn't the nanokernel itself, but the hardware too complex and linux
itself way too complex and not-provable, since it could hang and lock
the bus with a wrong dma operation on a graphics card or whatever else.
Perhaps those apps should run on OS stripped down w/o MMU and w/o irqs
and on much slower and more reliable cpus and ram. I'm not really an
expert of this area.

>From a linux point of view, currently you can't get an harder stone than
RTAI/RTLinux/nanokernel (that's probably why I was biased and I called
it "diamond" hard, even if it was only "ruby" in absolute terms ;).

> How much guarantee can the RTAI projects give on latencies?  And how

That depends on the hardware I guess.

> So, time may tell. Ingo's patch may one day get to Ruby level, but right
> now I believe 90% of all RT applications are satisfied with the "Metal"
> level.

Possible. My only worry is that embedded people goes to metal level
thinking it's better than the ruby level, when they would be better and
simpler at the ruby level.
