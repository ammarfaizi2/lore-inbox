Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264874AbUENAG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUENAG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 20:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUENAG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 20:06:29 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:654 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264874AbUENAG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 20:06:28 -0400
Message-ID: <40A40A0C.3070906@yahoo.com.au>
Date: Fri, 14 May 2004 09:51:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.6.6-mm2
References: <40A36C94.EB004C37@tv-sign.ru>
In-Reply-To: <40A36C94.EB004C37@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> Hello.
> 
> Andrew Morton wrote:
> 
>>+yield_irq.patch
>>
>>From: Nick Piggin
>>
>>this_rq_lock does a local_irq_disable, and sched_yield()
>>needs to undo that.
> 
> 
> I beleive it is safe to enter schedule() with interrupts
> disabled. schedule() does spin_lock_irq()->local_irq_disable()
> anyway.
> 
> Could you please explain, why it is needed?
> 

It is safe to enter schedule() with interrupts disabled. I
found this "problem" while searching for something else in
sched.c

For consistency it is a good thing to do, however I would
be just as happy with a 1 line comment instead. Ingo what
do you prefer?
