Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268439AbTCFWHZ>; Thu, 6 Mar 2003 17:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268444AbTCFWHZ>; Thu, 6 Mar 2003 17:07:25 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15121
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S268439AbTCFWHY>; Thu, 6 Mar 2003 17:07:24 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030306124257.4bf29c6c.akpm@digeo.com>
References: <20030228202555.4391bf87.akpm@digeo.com>
	 <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
	 <20030306124257.4bf29c6c.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046989091.715.46.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 17:18:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 15:42, Andrew Morton wrote:

> So I'm a happy camper, and will be using Ingo's combo patch.  But I do not
> use XMMS and xine and things like that - they may be running like crap with
> these patches.  I do not know, and I do not have a base to compare against
> even if I could work out how to get them going.

Linus,

This is great for me, too.  I played around with some mp3 playing and
did the akpm-window-wiggle test.  It is definitely the smoothest.

I think we definitely need Ingo's tweaked scheduler parameters - I have
been running a similar set of values myself for some time.  But your
patch seems to make the difference.

This is the most subject stuff on the planet, but here is a rough
ranking of interactivity performance in the bad cases on a scale of 1
(worse) to 5 (best):

linus-patch + tweaked-parameters:	5
linus-patch:				4
tweaked-parameters + reniced X:		3.5
tweaked-parameters:			2.5
stock:					1

Sorry, did not test Ingo's full patch.  It is basically the tweaked
parameters plus the sync wakeup which looks correct.

In the average case, the O(1) scheduler does fine without any changes. 
The heuristic works.  It is just the worst-case cases where we need
help, and from above I think we have that.

	Robert Love

