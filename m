Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTICG4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTICG4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:56:09 -0400
Received: from anumail4.anu.edu.au ([150.203.2.44]:65227 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S261240AbTICG4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:56:05 -0400
Message-ID: <3F55907B.1030700@cyberone.com.au>
Date: Wed, 03 Sep 2003 16:55:55 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903062817.GA19894@krispykreme>
In-Reply-To: <20030903062817.GA19894@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

>>>>I've frequently tried to make the point that all the scaling for
>>>>lots of processors is nonsense.  Mr Dell says it better:
>>>>
>>>>    "Eight-way (servers) are less than 1 percent of the market and
>>>>    shrinking pretty dramatically," Dell said. "If our competitors
>>>>    want to claim they're No. 1 in eight-ways, that's fine. We
>>>>    want to lead the market with two-way and four-way (processor
>>>>    machines)."
>>>>
>>>>Tell me again that it is a good idea to screw up uniprocessor
>>>>performance for 64 way machines.  Great idea, that.  Go Dinosaurs!
>>>>
>>>And does your 4 way have hyperthreading?
>>>
>>What part of "shrinking pretty dramatically" did you not understand?
>>Maybe you know more than Mike Dell.  Could you share that insight?
>>
>
>Ok. But only because you asked nicely.
>
>Mike Dell wants to sell 2 and 4 processor boxes and Intel wants to sell 
>processors with hyperthreading on them. Scaling to 4 or 8 threads is just
>like scaling to 4 or 8 processors, only worse.
>
>However, lets not end up in a yet another 64 way scalability argument here.
>
>The thing we should be worrying about is the UP -> 2 way SMP scalability
>issue. If every chip in the future has hyperthreading then all of sudden
>everyone is running an SMP kernel. And what hurts us?
>
>atomic ops
>memory barriers
>
>Ive always worried about those atomic ops that only appear in an SMP
>kernel, but Rusty recently reminded me its the same story for most of the
>memory barriers.
>
>Things like RCU can do a lot for this UP -> 2 way SMP issue. The fact it
>also helps the big end of town is just a bonus.
>

I think LM advocates aiming single image scalability at or before the knee
of the CPU vs performance curve. Say thats 4 way, it means you should get
good performance on 8 ways while keeping top performance on 1 and 2 and 4
ways. (Sorry if I mis-represent your position).

I don't think anyone advocates sacrificing UP performance for 32 ways, but
as he says it can happen .1% at a time.

But it looks like 2.6 will scale well to 16 way and higher. I wonder if
there are many regressions from 2.4 or 2.2 on small systems.


