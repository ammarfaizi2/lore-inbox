Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVASEZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVASEZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVASEZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:25:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:44513 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261559AbVASEZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:25:08 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119000556.GB14749@atomide.com>
References: <20050119000556.GB14749@atomide.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 15:21:07 +1100
Message-Id: <1106108467.4500.169.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 16:05 -0800, Tony Lindgren wrote:
> Hi all,
> 
> Attached is the dynamic tick patch for x86 to play with
> as I promised in few threads earlier on this list.[1][2]
> 
> The dynamic tick patch does following:
>
> .../...

Nice, that's exactly what I want on ppc to allow the laptops to have the
CPU "nap" longer when idle ! I'll look into adding ppc support to your
patch soon.

BTW. Is it possible, when entering the "idle" loop, to quickly know an
estimate of when the next tick shoud actually kick in ?

Also, looking at the patch, I think it mixes a bit too much of x86
things with generic stuffs... like pm_idle an x86 thing. 

Other implementation details comments: Do you need all those globals to
be exported ? And give them better names than "ltt", that makes using of
system.map quite annoying ;)

I don't understand your comment about "we must have all processors idle"
as well... 

So while the whole thing is interesting, I dislike the actual
kernel/dyn-tick-timer.c implementation, which should be moved to arch
stuff at this point imho.

Ben.


