Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030724AbWLETvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030724AbWLETvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbWLETvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:51:52 -0500
Received: from mail.tmr.com ([64.65.253.246]:48081 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030724AbWLETvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:51:51 -0500
Message-ID: <4575CEAC.2010503@tmr.com>
Date: Tue, 05 Dec 2006 14:55:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jaswinder Singh <jaswinderrajput@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PREEMPT is messing with everyone
References: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com>	 <45758B57.6040107@stud.feec.vutbr.cz> <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
In-Reply-To: <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> On 12/5/06, Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>> Jaswinder Singh wrote:
>> > Hi,
>> >
>> > preempt stuff SHOULD only stay in #ifdef CONFIG_PREEMP_* , but it is
>> > messing with everyone even though not defined.
>> >
>> > e.g.
>> >
>> > 1. linux-2.6.19/kernel/spinlock.c
>> >
>> > Line 18: #include <linux/preempt.h>
>> >
>> > Line 26:  preempt_disable();
>> >
>> > Line 32:  preempt_disable();
>> >
>> > and so on .
>>
>> Don't worry. These compile into "do { } while (0)" (i.e. nothing) when
>> CONFIG_PREEMPT is not set.
>>
> 
> Yes, Compiler will remove it but this looks ugly and confusing.
> 
> Why dont we use like this :-

Because it's ugly and confusing.
> 
> #ifdef CONFIG_PREEMPT
> #include <linux/preempt.h>
> #endif
> 
> #ifdef CONFIG_PREEMPT
> preempt_disable();
> #endif
> 
> #ifdef CONFIG_PREEMPT
> preempt_enable();
> #endif


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
