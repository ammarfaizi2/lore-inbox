Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVEZVZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVEZVZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEZVZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:25:32 -0400
Received: from mail.timesys.com ([65.117.135.102]:51161 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261784AbVEZVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:25:23 -0400
Message-ID: <42963E61.4080609@timesys.com>
Date: Thu, 26 May 2005 17:23:45 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, john.cooper@timesys.com
Subject: Re: RT patch acceptance
References: <20050525001019.GA18048@nietzsche.lynx.com>	 <1116981913.19926.58.camel@dhcp153.mvista.com>	 <20050525005942.GA24893@nietzsche.lynx.com>	 <1116982977.19926.63.camel@dhcp153.mvista.com>	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>	 <20050526193230.GY86087@muc.de>  <429633B1.5060601@timesys.com> <1117141254.1583.69.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1117141254.1583.69.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 May 2005 21:18:52.0062 (UTC) FILETIME=[83E7BBE0:01C56238]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich wrote:
> On Thu, 2005-05-26 at 16:38 -0400, john cooper wrote:
>>Spin if the lock is contended and the owner is active
>>on a cpu under the assumption the lock owner's average
>>hold time is less than that of a context switch.  There
>>are restrictions as once a path holds an adaptive
>>mutex as a spin lock it cannot acquire another adaptive
>>mutex as a blocking lock.
> 
> It might be simpler to get things working with a basic implementation
> first, (status quo), and then look into adding something like this. 

I wasn't suggesting this is the time to consider doing so,
but rather pointing it out as an available optimization.

> I don't see how this approach decreases the complexity of the task at
> hand, especially not in regards to concurrency.

It increases the efficiency of the mutex as we don't incur
context switches (in general) unless necessary.  Concurrency
isn't fundamentally affected.

-john


-- 
john.cooper@timesys.com
