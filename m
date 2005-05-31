Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVEaHfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVEaHfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVEaHfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:35:42 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:28063 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261323AbVEaHfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:35:33 -0400
Message-ID: <429C139E.6020705@andrew.cmu.edu>
Date: Tue, 31 May 2005 03:34:54 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de>	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>	 <20050526193230.GY86087@muc.de>	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>	 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>	 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>	 <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>	 <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au>	 <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au>	 <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au>	 <429BA27A.5010406@andrew.cmu.edu> <1117505204.22167.11.camel@mindpipe>
In-Reply-To: <1117505204.22167.11.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
 > Since *everything* is preemptible except a few known code paths whose
 > execution times determine the maximum possible latency from interrupt
 > to running the highest priority user process.

Have all the code paths been audited?  If there's a reference to an 
analysis that's been done, please pass it on as I'd like to read it. 
Remember that it must take into account completely cold L1 and L2 caches 
for almost all of the computation, or its not truly a worst-case 
analysis.  If this has been done, I stand corrected.  If not, then 
there's no proven maximum latency, just statistical arguments that it 
works well.  Keep in mind that such an argument can be good enough for 
most of the RT stuff people are doing, but I'm not putting my hand under 
the saw just yet :)

 > That's the determinism, no more, no less.  But some people
 > inexplicably think this thread is about providing deterministic hard
 > RT performance for some subset of system calls, or disk IO or
 > something, none of which have anything to do with PREEMPT_RT.

Well, that's the direction people want to take it in, since an RT thread 
unable to receive any type of input or produce some type of output isn't 
particularly useful for anything.  First steps first, of course.

I really think the RT patches are great in what they achieve, but true 
hard realtime does require proof, and I'm not aware of that having been 
done (yet).  However that's not a prerequisite for usefulness; A 
measurement of 5 or 7 nines of reliability getting sub 100us latency 
will certainly make most application writers happy.

  - Jim Bruce
