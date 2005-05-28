Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVE1Enl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVE1Enl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 00:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVE1Enl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 00:43:41 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:19111 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261897AbVE1Ene (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 00:43:34 -0400
Message-ID: <4297F6F2.3040804@yahoo.com.au>
Date: Sat, 28 May 2005 14:43:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050524192029.2ef75b89.akpm@osdl.org>	 <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de>	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>	 <20050526193230.GY86087@muc.de>	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>	 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>	 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>	 <20050527233645.GA2283@nietzsche.lynx.com>  <4297EB57.5090902@yahoo.com.au> <1117254442.4253.12.camel@mindpipe>
In-Reply-To: <1117254442.4253.12.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-05-28 at 13:53 +1000, Nick Piggin wrote:
> 
>>Run RT programs in your RT kernel, and GP programs in your Linux
>>kernel. The only time one will have to cross into the other domain
>>is when they want to communicate with one another.
>>
> 
> 
> And what about a multithreaded program with RT and non-RT threads?
> 

Have to rewrite them.... Well, there are obviously none written for
Linux today, because it doesn't support hard-RT ;)

If you are talking about soft-RT, or things running on Linux today,
then sure they'll keep working. Even some or all of PREEMPT_RT may
be merged into the Linux guest too, for better soft-RT. I haven't
been arguing against that.

> 
> No one ever said anything about hard RT IO, or making any syscalls hard
> RT.

Actually this is exactly what was being talked about. But note
that we're not specifically talking about PREEMPT_RT here, just
2 possible architectures that might achieve that.

>  AFAIK this has never even come up during the PREEMPT_RT
> development.  We just want our userspace code to be scheduled as soon as
> it's runnable.  For the purposes of this entire thread, it's safe to
> assume that if the RT thread does make any syscalls, it knows exactly
> what it is doing, as in the JACK write() example.
> 

I agree we'll never have a fully functional hard-RT Linux kernel.
But this thread hasn't been about whether or not the RT task knows
what it is doing (we assume it does), but the possibility of making
more parts of the kernel able to provide some RT guarantee (ie. so
said RT task *can* use more functionality).

Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
