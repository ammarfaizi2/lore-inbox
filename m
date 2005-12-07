Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVLGLJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVLGLJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVLGLJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:09:35 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:25483 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750851AbVLGLJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:09:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qTyulX7UBPn9mvfo8FIcdkmQaTcr7hjPY5bXqYN7YVMn5YFh5Zsl77xVP2P194ouM10dSrYoYHsm/IkqHtcBYuftzeAdII1CfkRyiL6VatFE/LCvcmnEBP3yk37p2EtEOyXsl0W3gB135wokd3+3lzHSbcXMvXCOy3ZAVrvlZos=  ;
Message-ID: <4396C2EB.1000203@yahoo.com.au>
Date: Wed, 07 Dec 2005 22:09:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu> <4396B81E.4030605@yahoo.com.au> <20051207104900.GA26877@elte.hu>
In-Reply-To: <20051207104900.GA26877@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>
>>>so i believe that:
>>>
>>>	- 'struct ktimer', 'struct ktimeout'
>>>
>>>is in theory superior naming, compared to:
>>>
>>>	- 'struct ptimer', 'struct timer_list'
>>>
>>
>>Just curious -- why the "k" thing?
> 
> 
> yeah. 'struct timer' and 'struct timeout' is even better. I tried it on 

Oh good, glad you think so :)

> real code and sometimes it looked a bit funny: often we have a 'timeout' 
> parameter somewhere that is a scalar or a timeval/timespec. So at least 

Sure... hmm, the names timeout and timer themselves have something
vagely wrong about them, but I can't quite place my finger on it,
not a real worry though...

Maybe it is that timeout is an end result, but timer is a mechanism.
So maybe it should be 'struct interval', 'struct timeout';
or 'struct timer', 'struct timeout_timer'.

But I don't know really, it isn't a big deal.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
