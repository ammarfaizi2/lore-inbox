Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267579AbUHEHJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267579AbUHEHJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUHEHJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:09:13 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:50879 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267579AbUHEHI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:08:56 -0400
Message-ID: <4111DC6B.2090902@yahoo.com.au>
Date: Thu, 05 Aug 2004 17:06:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube>	 <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au>	 <411196EE.9050408@bigpond.net.au> <41119A3B.2020202@yahoo.com.au>	 <4111A39C.40200@bigpond.net.au>  <4111A418.5030101@yahoo.com.au> <1091672930.3547.1781.camel@cube>
In-Reply-To: <1091672930.3547.1781.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Wed, 2004-08-04 at 23:06, Nick Piggin wrote:
> 
>>Peter Williams wrote:
>>
>>
>>>Nick Piggin wrote:
>>>
>>>
>>>>However if you add or remove scheduling policies, your
>>>>p->policy method breaks.
>>>
>>>
>>>Not if Albert's numbering system is used.
>>>
>>
>>What if another realtime policy is added? Or one is removed?
> 
> 
> What if, what if...
> 
> You're going to have to change the code anyway.
> One might toss this into <linux/sched.h> to make
> as a nice reminder:
> 
> #define SCHEDS_RT (SCHED_RR|SCHED_FIFO)
> 

I'm not saying your renumbering is a bad idea, but making the
argument that it would simplify rt_task is bogus.

> As it is now, SCHED_FIFO is already used as a
> bit flag in one place.
> 

But it isn't a bit flag, we're just lucky it works. Submit a
patch?
