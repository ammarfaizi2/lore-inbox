Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWCVWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWCVWwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCVWwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:52:53 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:8026 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750969AbWCVWww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:52:52 -0500
Message-ID: <4421D541.6090103@bigpond.net.au>
Date: Thu, 23 Mar 2006 09:52:49 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, mingo@elte.hu, akpm@osdl.org
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
References: <20060322104143.GC30422@krispykreme> <4421307F.8020300@yahoo.com.au>
In-Reply-To: <4421307F.8020300@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 22 Mar 2006 22:52:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Anton Blanchard wrote:
> 
>> One way to solve this is to always take runqueues in cpu id order. To do
>> this we add a cpu variable to the runqueue and check it in the
>> double runqueue locking functions.
>>
>> Thoughts?
>>
> 
> You're right. I can't think of a better fix, although we've been trying
> to avoid adding cpu to the runqueue structure.

But now that it's there it will enable further optimizations in parts of
sched.c, wouldn't it?  E.g. there's a number of functions that get
passed both the run queue and the CPI id as arguments and these could be
simplified.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

