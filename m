Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWEOOex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWEOOex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEOOex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:34:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:28364 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964948AbWEOOex convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:34:53 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: =?iso-8859-15?q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Mon, 15 May 2006 07:34:38 -0700
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, mista.tapas@gmx.net,
       efault@gmx.de, rostedt@goodmis.org, rlrevell@joe-job.com
References: <200605121924.53917.dvhltc@us.ibm.com> <1147691746.3970.16.camel@frecb000686>
In-Reply-To: <1147691746.3970.16.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605150734.39849.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 04:15, Sébastien Dugué wrote:

>   I've been running you test program on my box under a stress-kernel
> load and did not observe any failure as you describe, not even a max
> latency overshooting the 100 us limit (max latencies in the 60~70 us).
>
>   I even went to decrease PERIOD to 1 ms and still no failure.
>
>   I'm running rt20 with the futex priority based wakeup patch on
> a dual 2.8 GHz HT Xeon box. All hardirq and softirq threads are at their
> default priority.

Interesting, I'll have to try this on some more hardware and see if I can 
reproduce there.

>
>   How do you generate the network load you mention? Maybe I could try at
> least with the same load you're using.

I was simply copying a 60MB file to the test machine via scp, in a bash while 
loop.  I haven't been doing this on my most recent runs however, and they 
still fail.  So I don't believe the net load is directly related.

I am going to work with Ingo's trace-it.c today and report back.

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team

