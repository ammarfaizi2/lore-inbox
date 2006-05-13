Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWEMXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWEMXBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWEMXBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:01:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44996 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750800AbWEMXBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:01:41 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Sat, 13 May 2006 16:01:31 -0700
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605131106.16864.dvhltc@us.ibm.com> <1147544472.6535.294.camel@mindpipe>
In-Reply-To: <1147544472.6535.294.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605131601.31880.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 May 2006 11:21, Lee Revell wrote:
> On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> >      1 [softirq-timer/0]
>
> What happens if you set the softirq-timer threads to 99?
>

After setting all 4 softirq-timer threads to prio 99 I seemed to get only 2 
failures in 100 runs. #51 slept too long (10ms too long!), the latency 
appeared after the sleep in #90 (nearly 483ms worth).  Those latencies seem 
huge to me.

ITERATIONS 0-50 Passed

ITERATION 51
-------------------------------
Scheduling Latency
-------------------------------

Running 10000 iterations with a period of 5 ms
Expected running time: 50 s

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------
     7000     10197         10197        1

PERIOD MISSED!
     scheduled delta:     4079 us
        actual delta:    14263 us
             latency:    10183 us
---------------------------------------
      previous start: 35010197 us
                 now: 35011117 us
     scheduled start: 35005000 us
next scheduled start is in the past!


Start Latency:  114 us: FAIL
Min Latency:      9 us: PASS
Avg Latency:      7 us: PASS
Max Latency:   10197 us: FAIL
Failed Iterations: 1

ITERATIONS 52-89 Passed

ITERATION 90
-------------------------------
Scheduling Latency
-------------------------------

Running 10000 iterations with a period of 5 ms
Expected running time: 50 s

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------
     2747         9            20        0

PERIOD MISSED!
     scheduled delta:     4072 us
        actual delta:     4079 us
             latency:        6 us
---------------------------------------
      previous start: 13735009 us
                 now: 14218183 us
     scheduled start: 13740000 us
next scheduled start is in the past!


Start Latency:  112 us: FAIL
Min Latency:      8 us: PASS
Avg Latency:      2 us: PASS
Max Latency:     20 us: PASS
Failed Iterations: 0

ITERATIONS 91-99 Passed

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
