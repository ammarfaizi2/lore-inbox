Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUFZDZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUFZDZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 23:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUFZDZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 23:25:32 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:39944 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265900AbUFZDZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 23:25:30 -0400
Message-ID: <1088211932.40dccbdc48b45@vds.kolivas.org>
Date: Sat, 26 Jun 2004 11:05:32 +1000
From: kernel@kolivas.org
To: Willy Tarreau <willy@w.ods.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <40DC38D0.9070905@kolivas.org> <20040625222027.GJ29808@alpha.home.local>
In-Reply-To: <20040625222027.GJ29808@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Willy Tarreau <willy@w.ods.org>:

> Hi Con,
> 
> although I was one of those who complained a lot about the 2.6 scheduler,
> and still don't use it because of its sluggishness under X11, I'm impressed
> by your work here. I've tried the good old test which was *very* sluggish
> on a vanilla 2.6 :

Well I can take the blame for that since I tuned it. I tried very hard to do it
without changing the overall design :\

> 
> # for i in $(seq 1 20); do xterm -e sh -c "while :; do locate /;done" & done
> 
> It opens 20 xterms constantly listing my slocate database (vmstat shows
> no I/O).
> 
> Under vanilla 2.6 (up to 2.6.4 at least), some of these xterms would freeze
> for up to about 10 seconds IIRC during redrawing, with incomplete lines,
> etc...
> This still happens with your patch and /p/s/k/interactive=0, but to a lesser
> extent it seems. But it does not happen anymore with interactive=1, hence
> the
> progress !
> 
> However, you warned us that the nice parameter was very sensible. Indeed,
> it *is* ! When my window manager (ctwm, very light) is at 0, just like the
> script above, the windows appear slowly and irregularly on the screen,
> but this takes no more than 15s, during which windows get no title, then
> suddenly they get everything right. If I renice the WM at +1, I see no
> more than 5 windows on the screen with no decoration at all, and then I
> cannot even change the focus to another one anymore. Then, as soon as I
> change the WM's nice value to -1, suddenly all remaining windows appear
> with their title. The same is true if I start the script with the WM at
> -1 initially. It's just as if the nice value was directly used as the
> priority in a queue.
> 
> Oh and BTW, this is an SMP box (dual athlon).
> 
> Well, I see there is some very good progress ! Please keep up the good
> work !

Thanks! I'll try my best.

Con


