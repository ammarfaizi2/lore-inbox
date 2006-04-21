Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWDUMaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWDUMaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDUMaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:30:05 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:20131 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932113AbWDUMaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:30:04 -0400
Message-ID: <4448D047.8070202@compro.net>
Date: Fri, 21 Apr 2006 08:29:59 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dmarkh@cfl.rr.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages ?
References: <44475DBA.7020308@cfl.rr.com> <44477585.4030508@yahoo.com.au> <4447E6C4.9070207@compro.net> <4447E86E.9000507@yahoo.com.au>
In-Reply-To: <4447E86E.9000507@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Mark Hounschell wrote:
>> Nick Piggin wrote:
> 
>>> This area is going through some changes lately. If you want something to
>>> quickly get things working, removing VM_PFNMAP from your vma flags
>>> should
>>> work.
>>>
>>
>>
>> Yes, that actually does work while the task is running but as soon as I
>> exit the task the machine freezes.
> 
> Hmm. Does it freeze, or oops? (ie. were you in X and missed the oops)
> Can you get a sysrq backtrace?
> 
> Oh, hmm you'll need to increment the refcount of each page before
> mapping it. That's probably the problem.
> 
> OK, I'd suggest either using vm_insert_page, or converting it all over
> to a ->nopage handler then.
> 

I set the bit back on after get_user_pages and now I seem to be OK.

You've looked at the code some obviously. What is in my future WRT these
changes being made that you referenced above and the depreciation of
some of the calls in use. Given my situation, do you foresee anything
that will keep me from being able to get valid bus addresses for my pte?

Thanks
Mark
