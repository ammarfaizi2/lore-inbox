Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbULOQp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbULOQp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbULOQp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:45:59 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:15241 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262386AbULOQok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:44:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Date: Wed, 15 Dec 2004 11:44:38 -0500
User-Agent: KMail/1.7
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
References: <20041213002751.GP16322@dualathlon.random> <200412142159.23488.gene.heskett@verizon.net> <20041215091741.GA16322@dualathlon.random>
In-Reply-To: <20041215091741.GA16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412151144.38785.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 10:44:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 04:17, Andrea Arcangeli wrote:
>On Tue, Dec 14, 2004 at 09:59:23PM -0500, Gene Heskett wrote:
>> Which way?  I was running quite fast here, several minutes an
>
>In the future, if I disable the logic it goes in the past at the
> same speed it was previously going in the future.
>
>> hour, then I discovered the tickadj command, found its default
>> was 10000, and started reducing it.  At 9926, I'm staying within
>> a sec an hour now.  I have no idea when this started, I didn't
>
>That seems quite an hack, note I did an hack too and it make the
> drift much smaller (it gets manageable). But our modifications are
> wrong.
>
>The point is that this didn't happen with HZ=100, so it's not that
>tickadj is wrong, it's the tick adjustment code that doesn't work.
>
The HZ=1000 is the culprit?

>You may want to recompile your kernel with HZ=100 and verify it goes
>away (I didn't verify myself, but I verified the max irq latency I
> get is 4msec, and in turn I'm sure HZ=100 would fix it

Humm, that might also reduce the obviousness of the irq activity in
the audio, there are times when I can hear it very plainly while a
low level audio src is in use, like the sub-millivolt levels that come
out of my Hauppauge WinTV-GO+FM card.   I keep having to turn the
master down to almost zip in order to keep it from sounding like I
have mice chewing in the walls, but its coming from the speakers. 
Onboard AC-97 audio of course.  Crappy stuff...   Humm, 100HZ would
translate to 10 millisecond intervals.  If you had a 4 millisecond 
latency,
that would be spread over 4 of the 1000 hz interrupts.  That sounds
rather confusing to the service routine I imagine.

I'll do that just for grins & report back.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

