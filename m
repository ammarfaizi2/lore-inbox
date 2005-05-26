Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVEZX7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVEZX7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVEZX7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:59:12 -0400
Received: from mail.timesys.com ([65.117.135.102]:26470 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261850AbVEZX7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:59:08 -0400
Message-ID: <4296626E.1000903@timesys.com>
Date: Thu, 26 May 2005 19:57:34 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <20050525005942.GA24893@nietzsche.lynx.com>	 <1116982977.19926.63.camel@dhcp153.mvista.com>	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>	 <20050526193230.GY86087@muc.de>	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>	 <20050526202747.GB86087@muc.de> <1117140397.1583.60.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1117140397.1583.60.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 May 2005 23:52:37.0859 (UTC) FILETIME=[FEE8A330:01C5624D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich wrote:
> On Thu, 2005-05-26 at 22:27 +0200, Andi Kleen wrote:
> 
>>>Here, I am talking about separating out the patch, and applying it
>>>first, not dropping it from the RT implementation. 
>>
>>I really dislike the idea of interrupt threads. It seems totally
>>wrong to me to make such a fundamental operation as an interrupt
>>much slower.  If really any interrupts take too long they should
>>move to workqueues instead and be preempted there. But keep
>>the basic fundamental operations fast please (at least that used to be one
>>of the Linux mottos that served it very well for many years, although more
>>and more people seem to forget it now) 
> 
> IRQ threads are configurable.  If you don't want them, you CAN turn them
> off (if you have already turned them on). 
> 
> You don't HAVE to turn them on. 

Unless you have configured PREEMPT_RT which requires
PREEMPT_SOFTIRQS and PREEMPT_HARDIRQS such that
spinlock-mutexes are able to synchronize interrupt
processing.  In other PREEMPT_* configuration modes
inclusion of IRQ threads is optional.

I think this may have been the source of confusion in
prior discussions.

-john


-- 
john.cooper@timesys.com
