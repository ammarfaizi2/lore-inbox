Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUGJOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUGJOpN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUGJOpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:45:13 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:14928 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266273AbUGJOpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:45:09 -0400
Message-ID: <40F000F1.1080004@yahoo.com.au>
Date: Sun, 11 Jul 2004 00:45:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>,
       Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu> <2a4f155d040710035512f21d34@mail.gmail.com> <20040710123520.GA27278@elte.hu> <2a4f155d04071005585b5d8999@mail.gmail.com> <20040710135555.GA31068@elte.hu>
In-Reply-To: <20040710135555.GA31068@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * ismail dönmez <ismail.donmez@gmail.com> wrote:
> 
> 
>>>what filesystem are you using?
>>>
>>
>>XFS
> 
> 
> i've fixed latencies in ext3, i'm not sure how bad XFS is. But 2-3
> seconds delay is almost impossible to be a true scheduling latency -
> it's probably IO latency impacting your audio application. (it could
> also be normal preemption latency, if those tasks are not running as
> SCHED_FIFO - but 2-3 seconds preemption latency should not be caused by
> a simple cp -a. This leaves IO latency.).
> 

But it only skips when using aRts, which points the other way ;)

If all tasks are using realtime scheduling, then this discounts
the scheduler from the equation, however I'm not sure if this is
the case?
