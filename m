Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbTFRAcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTFRAcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:32:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52985 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265014AbTFRAcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:32:46 -0400
Message-ID: <3EEFB651.4020005@mvista.com>
Date: Tue, 17 Jun 2003 17:46:09 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Riley Williams <Riley@Williams.Name>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <20030617232113.J32632@flint.arm.linux.org.uk> <20030618003804.A21001@ucw.cz>
In-Reply-To: <20030618003804.A21001@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Jun 17, 2003 at 11:21:13PM +0100, Russell King wrote:
> 
> 
>>On Tue, Jun 17, 2003 at 11:11:46PM +0100, Riley Williams wrote:
>>
>>>On most architectures, the said timer runs at 1,193,181.818181818 Hz.
>>
>>Wow.  That's more accurate than a highly expensive Caesium standard.
>>And there's one inside most architectures?  Wow, we're got a great
>>deal there, haven't we? 8)
> 
> 
> Well, it's unfortunately up to 400ppm off on most systems. Nevertheless
> this is the 'official' frequency, actually it's a NTSC dotclock (14.3181818)
> divided by 12.
> 
> 
>>> > Please do not add CLOCK_TICK_RATE to the ia64 timex.h header file.
>>>
>>>It needs to be declared there. The only question is regarding the
>>>value it is defined to, and it would have to be somebody with better
>>>knowledge of the ia64 than me who decides that. All I can do is to
>>>post a reasonable default until such decision is made.
>>
>>If this is the case, we have a dilema on ARM.  CLOCK_TICK_RATE has
>>been, and currently remains (at Georges distaste) a variable on
>>some platforms.  I shudder to think what this is doing to some of
>>the maths in Georges new time keeping and timer code.

So do I :)
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

