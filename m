Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWCXIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWCXIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCXIQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:16:26 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:59284 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932375AbWCXIQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:16:25 -0500
Message-ID: <4423AAC7.2050007@aitel.hist.no>
Date: Fri, 24 Mar 2006 09:16:07 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
CC: Jan Knutar <jk-lkml@sci.fi>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: swap prefetching merge plans
References: <200603230856.24091.volker.armin.hemmann@tu-clausthal.de> <44225BBF.2040604@yahoo.com.au> <200603231347.51219.jk-lkml@sci.fi> <200603231450.02479.volker.armin.hemmann@tu-clausthal.de>
In-Reply-To: <200603231450.02479.volker.armin.hemmann@tu-clausthal.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hemmann, Volker Armin wrote:

>On Thursday 23 March 2006 12:47, you wrote:
>  
>
>>On Thursday 23 March 2006 10:26, Nick Piggin wrote:
>>    
>>
>>>Hemmann, Volker Armin wrote:
>>>      
>>>
>>>>Hi,
>>>>
>>>>I am just a user, but I would love to see this feature.
>>>>
>>>>After compiling stuff, I have usually some kb in swap (300kb, 360 kb),
>>>>and lots of free ram. But even this few kb make my KDE desktop extremly
>>>>sluggish. It feels, like every byte is fetched individually and always
>>>>the wrong stuff ends in swap.
>>>>        
>>>>
>>>I'm almost positive this wouldn't be the cause of your problems (even a
>>>slow disk could read all these blocks in, randomly, in under 2 seconds,
>>>assuming they're spread from one end of the platters to the other).
>>>      
>>>
>>Maybe he meant 300 megabytes.
>>    
>>
>
>no, I meant kilobytes.
>
>And swapoff really helps.
>
>Some moments of disk activity, and bang, computer is as fast as always again.
>
>But having stuff in swap? konqueror is slow, kmail is slow, opening a konsole 
>session, slow. Everything crawls with lots of disk access. 
>
>next time the computer is slow, I could gather some data - if you tell me, 
>what is interessting for you, I'll save it.
>  
>
Strange indeed.  300k in swap is nothing - I often enough
have 50M in swap without a slowdown - but then, I don't
run kde. 

Be aware that the 300k in swap doesn't account for all that
is removed from memory.  Linux don't put executable code
in swap - such stuff is simply dropped because it can
be reloaded from the executable files anytime.
I don't think swapoff+swapon helps with that though.

Helge Hafting

