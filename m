Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTGGRkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTGGRkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:40:20 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:44453 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S264091AbTGGRkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:40:14 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: 2.5.74-mm1
Date: Mon, 7 Jul 2003 19:55:58 +0200
User-Agent: KMail/1.5.2
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <20030707152339.GA9669@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071007140.4704@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307071007140.4704@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071955.58774.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 19:25, Davide Libenzi wrote:
> On Mon, 7 Jul 2003, Jamie Lokier wrote:
> > Davide Libenzi wrote:
> > > The scheduler has to work w/out external input, period.
> >
> > Can you justify this?
> >
> > It strikes me that a music player's thread which requests a special
> > music-playing scheduling hint is not unreasonable, if that actually
> > works and scheduler heuristics do not.
>
> Jamie, looking at those reports it seems it is not only a sound players
> problem.

You still seem to be having trouble with the idea that the sound servicing 
thread is a realtime process, and thus fundamentally different from other 
kinds of processes.  Could you please explain why you disagree with this?

> The *application* has to hint the scheduler, not the user.

Partly true, in that users should be able to supply the hint in some way, they 
desire.  However in this case - Zinf - the point is moot, because Zinf is 
trying hard to give the hint, but it fails because of above-mentioned 
braindamage.

> If reports about UI interactivity are true, this means that there's
> something wrong in the current scheduler though. Besides the player issue.

The current scheduler, complete with Con's tweaks, is working very well for me 
in combination with "nice -something".  The remaining issue there is pure 
policy.  In that regard, I'm trying to find the most appropriate way of 
fixing up user space so that Zinf's SetPriority actually achieves its 
intended effect.  Running all logins at some setable non-negative default 
priority is the best idea I've seen so far in that regard, and soon my system 
will be doing just that.  I'll let you know if anything explodes ;-)

If there's a remaining fundamental flaw in the kernel scheduler, it would be 
the lower-priority process starvation question, which holds the promise of 
plenty of future lkml navel gaz^W^Wdiscussion indeed.

Regards,

Daniel

