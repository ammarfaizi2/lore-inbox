Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbULPCHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbULPCHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbULPCFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:05:24 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:52706 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262582AbULPB7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:59:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Date: Wed, 15 Dec 2004 20:59:52 -0500
User-Agent: KMail/1.7
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
References: <20041213002751.GP16322@dualathlon.random> <200412151144.38785.gene.heskett@verizon.net> <20041215182012.GH16322@dualathlon.random>
In-Reply-To: <20041215182012.GH16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412152059.52292.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 19:59:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 13:20, Andrea Arcangeli wrote:
>On Wed, Dec 15, 2004 at 11:44:38AM -0500, Gene Heskett wrote:
>> The HZ=1000 is the culprit?
>
>HZ=1000 isn't the culprit. The culprit is the >1msec latency of the
> usb irq, but that wouldn't be visible with HZ 100 (for this
:> specific case HZ=100 would only be a band-aid).
>
>> Onboard AC-97 audio of course.  Crappy stuff... [..]
>
>I doubt it's the chip, but only the motherboard to blame. My laptop
> has the ac97 but no HZ sound out of it.
>
>> translate to 10 millisecond intervals.  If you had a 4 millisecond
>> latency,
>> that would be spread over 4 of the 1000 hz interrupts.  That
>> sounds rather confusing to the service routine I imagine.
>
>The ones that get confused are the system time and the jiffies, the
> rest of the system can deal with long irq delays. The tick
> adjustment was exactly implemented so that the jiffies and system
> time wouldn't get confused anymore, but it just confuses it the
> other way around in my current experience.
>
>> I'll do that just for grins & report back.
>
>Ok.

Unforch, I was not able to find that in the .config file, so where is
that particular option set?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

