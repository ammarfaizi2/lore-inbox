Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317609AbSFRUlA>; Tue, 18 Jun 2002 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317607AbSFRUlA>; Tue, 18 Jun 2002 16:41:00 -0400
Received: from mail.webmaster.com ([216.152.64.131]:47761 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317608AbSFRUk6> convert rfc822-to-8bit; Tue, 18 Jun 2002 16:40:58 -0400
From: David Schwartz <davids@webmaster.com>
To: <rusty@rustcorp.com.au>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 13:40:55 -0700
In-Reply-To: <E17KPS1-0003pP-00@wagner.rustcorp.com.au>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618204056.AAA5683@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>"The sched_yield() function shall force the running thread to relinquish
>>>>the processor until it again becomes the head of its thread list.
>>>>It takes no arguments."

>>>Notice how incredibly useless this definition is.  It's even defined in
>>>terms of UP.

>>Huh?! This definition is beautiful in that it makes no such=
>>assumptions. How would you say this is invalid on an SMP machine? By
>>"the= processor", they mean "the process on which the thread is
>>running" (the only one= it could relinquish, after all).

>Read again: they use "relinquish ... until", not "relinquish".  Subtle
>difference.

	So?

>I have 32 processors and 32 threads.  One does a yield().  What
>happens?  What should happen?

	It should relinquish the processor it is running on until it again becomes 
the head of its thread list. (IE, for as long as it takes the scheduler to 
decide that it's the thread to run.)

>Given that yield is "sleep for some time but I won't tell you what I'm
>doing", I have no sympathy for yield users 8)

	I have sympathy for those who use it properly, I have no sympathy for those 
who loop on sched_yield burning the CPU and then complaining that it burns 
CPU.

	DS


