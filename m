Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVEXP0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVEXP0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVEXP0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:26:06 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:19363 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262116AbVEXPY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:24:59 -0400
Message-ID: <42934748.8020501@yahoo.com.au>
Date: Wed, 25 May 2005 01:24:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu>
In-Reply-To: <20050524150537.GA11829@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>i just noticed that Nick's latest idle-optimizations patch is not in 
>>>-rc4-mm2, so this will cause some clashes.
>>
>>Yeah, hmm. I've just got lazy with porting to other architectures and 
>>sending to Andrew. I'll get it into shape in the next day or so and so 
>>this patch will go on top of it hopefully before Andrew is ready to 
>>release the next kernel.
> 
> 
> we could do it in the other direction just as much - i only touched 3 
> architectures. Up to Andrew i guess.
> 

How about just setting need_resched at the start of the cpu_idle
function instead? Rather than changing the structure of the idle
loops themselves. That would suit me best.

Thanks,
Nick

