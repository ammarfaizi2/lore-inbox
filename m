Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTAGCP6>; Mon, 6 Jan 2003 21:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTAGCP6>; Mon, 6 Jan 2003 21:15:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:44795 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267275AbTAGCPy>; Mon, 6 Jan 2003 21:15:54 -0500
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <234590000.1041833252@titus>
References: <200211061734.42713.efocht@ess.nec.de><200212021629.39060.efocht@ess.nec.de>
	<200212181721.39434.efocht@ess.nec.de>
	<200212311429.04382.efocht@ess.nec.de> <1041645514.21653.29.camel@kenai>
	<108220000.1041744901@titus> <1041825533.21653.41.camel@kenai> 
	<234590000.1041833252@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 18:23:34 -0800
Message-Id: <1041906222.21653.50.camel@kenai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 22:07, Martin J. Bligh wrote:
> >> > Kernbench:
> >> >                         Elapsed       User     System        CPU
> >> >              sched50     29.96s   288.308s    83.606s    1240.8%
> >> >              sched52    29.836s   285.832s    84.464s    1240.4%
> >> >              sched53    29.364s   284.808s    83.174s    1252.6%
> >> >              stock50    31.074s   303.664s    89.194s    1264.2%
> >> >              stock53    31.204s   306.224s    87.776s    1263.2%
> >
> > sched50 = linux 2.5.50 with the NUMA scheduler
> > sched52 = linux 2.5.52 with the NUMA scheduler
> > sched53 = linux 2.5.53 with the NUMA scheduler
> > stock50 = linux 2.5.50 without the NUMA scheduler
> > stock53 = linux 2.5.53 without the NUMA scheduler
> 
> I was doing a slightly different test - Erich's old sched code vs the new
> both on 2.5.54, and seem to have a degredation.
> 
> M.

Martin,

I ran 2.5.54 with an older version of Erich's NUMA scheduler and
with the version sent out for 2.5.53.  Results were similar:

Kernbench:
                        Elapsed       User     System        CPU
             sched54    29.112s   283.888s     82.84s    1259.4%
          oldsched54    29.436s   286.942s    82.722s    1256.2%

sched54 = linux 2.5.54 with the 2.5.53 version of the NUMA scheduler
oldsched54 = linux 2.5.54 with an earlier version of the NUMA scheduler

The numbers for the new version are actually a touch better, but
close enough to be within a reasonable margin of error. 

I'll post numbers against stock 2.5.54 and include schedbench, tomorrow.

               Michael

-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

