Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272539AbTHJH5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272548AbTHJH5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:57:06 -0400
Received: from dyn-ctb-210-9-243-231.webone.com.au ([210.9.243.231]:8712 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272539AbTHJH5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:57:03 -0400
Message-ID: <3F35FAC0.7020000@cyberone.com.au>
Date: Sun, 10 Aug 2003 17:56:48 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy   ...
References: <200308100405.52858.roger.larsson@skelleftea.mail.telia.com> <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <200308100405.52858.roger.larsson@skelleftea.mail.telia.com> <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 03:43 PM 8/10/2003 +1000, Nick Piggin wrote:
>
>
>> Roger Larsson wrote:
>>
>>> *       SCHED_FIFO requests from non root should also be treated as 
>>> SCHED_SOFTRR
>>>
>>
>> I hope computers don't one day become so fast that SCHED_SOFTRR is
>> required for skipless mp3 decoding, but if they do, then I think
>> SCHED_SOFTRR should drop its weird polymorphing semantics ;)
>
>
> :)  My box is slow enough to handle them just fine, as long as I make 
> sure that oinkers don't share the same queue with the light weight 
> player.


Just my (unsuccessful) attempt at humor! I think SCHED_SOFTRR is great,
although probably fills a quite small niche between SCHED_OTHER and
the realtime scheduling while being a possibility for security problems
(don't know, maybe that that is sorted?). But...

Some of the people saying playback needs to be realtime are right for
absolutely 100%, but seem to have forgotten that their pentium 100 did
just fine, and that a skip now and again probably doesn't signal the
end of the world.

I think its fairly obvious that it indicates there are problems with
the general purpose scheduler. Thankfully it is getting addressed,
which makes this just a rant ;)


