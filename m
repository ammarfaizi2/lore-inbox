Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUJOSQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUJOSQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJOSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:16:48 -0400
Received: from mail4.utc.com ([192.249.46.193]:1735 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S268260AbUJOSQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:16:45 -0400
Message-ID: <41701401.5070403@cybsft.com>
Date: Fri, 15 Oct 2004 13:16:33 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
In-Reply-To: <20041015102633.GA20132@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -U3 PREEMPT_REALTIME patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> 

I have gotten a couple of interesting traces on my dual 2.6G Xeon 
workstation here at the office. These were both generated running tests 
on (oddly enough) my own trace buffer that I am working on for a client 
here. The test basically consists of 100 threads putting data into the 
trace buffer concurrently and then one reader thread draining it and 
populating a multi-dimensional array to make sure all of the data is 
accounted for and not corrupted. All threads are running at a normal 
priority since the test is for correctness not performance. The traces 
are here:

http://www.cybsft.com/testresults/26workstation/2.6.9-rc4-mm1-VP/

kr
