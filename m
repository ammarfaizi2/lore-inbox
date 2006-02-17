Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWBQQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWBQQXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbWBQQXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:23:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57835 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030633AbWBQQXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:23:50 -0500
Message-ID: <43F5F87E.4030307@us.ibm.com>
Date: Fri, 17 Feb 2006 08:23:26 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@elte.hu>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Robust futexes
References: <1140152271.25078.42.camel@localhost.localdomain>
In-Reply-To: <1140152271.25078.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Hi Ingo, all,
> 
> 	Noticed (via LWN, hence the delay) your robust futex work.  Have you
> considered the less-perfect, but simpler option of simply having futex
> calls which tell the kernel that the u32 value is in fact the holder's
> TID?
> 
> 	In this case, you don't get perfect robustness when TID wrap occurs:
> the kernel won't know that the lock holder is dead.  However, it's
> simple, and telling the kernel that the lock is the tid allows the
> kernel to do prio inheritence etc. in future.

Priority Inheritance has come up a couple of times in relation to Ingo's new 
LightWeight Robust Futexes.  Ingo has said that PI is orthogonal to LWRF, but I 
don't think we've heard if there are plans already in the works (or in his head 
:-) for PI.  Rusty's comment above reads as "the current LWRF implementation 
cannot support PI" - is there something about it that makes PI impractical to 
implement?

Thanks,

-- 
Darren Hart
