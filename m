Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVALX3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVALX3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVALX0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:26:35 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:28362 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261570AbVALXXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:23:50 -0500
Message-ID: <41E5B177.4060307@f2s.com>
Date: Wed, 12 Jan 2005 23:23:35 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Richard Purdie <rpurdie@rpsys.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk>
In-Reply-To: <20050112221753.F17131@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> That depends whether the hardware already provides 0.5s of debounce
> already.  Some people do, some people don't.  This is why it needs to
> be left to the implementation and not a core issue.

Agreed. IIRC my toshiba PDAs *dont* provide a delay. OTOH they also 
provide *two* ways of detecting card presence...

>>>>2. Card Initialisation Problems
>>>
>>>Different cards behave differently.  I suspect you have yet another
>>>quirky card.
>>
>>What is the policy on handling this? Pin the error down, then see what can 
>>be done about it? I'll just have to move delays about until I find the one 
>>that helps guess.
>>
>>I was wondering if there was some kind of timing specification somewhere as 
>>all these cards seem to work fine under other operating systems...
> 
> That's probably the official MMC specification from the MMC forum.  Us
> mere open source developers don't have access to such costly specs, so
> we have to make do with the specs released by card manufacturers which
> do go into the protocol sufficiently deeply.
> 
> Unfortunately, such specs only cover MMC cards and not SD cards.

ISTR seeing a SD card doc at some point

> I have no idea - and that's the big problem.  We just don't know
> what the situation is with SD.
> 
> Maybe now that it's more wildly known that there's SD support available
> from handhelds.org, maybe (if the SD forum are reading lkml) we'll see
> some reaction.  Let's just hope it's positive.

Well I *know* I never saw the specs from the SD forum. I hacve never 
reverse engineered a SDHC core driver either (I have reverse engineered 
a chip driver but it contained no SD *protocol* information.

as such my code should be 100% safe to commit to the kernel.

PS. Richard - I am here - hope you receive this!
