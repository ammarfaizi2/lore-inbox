Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTAFDw3>; Sun, 5 Jan 2003 22:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTAFDw2>; Sun, 5 Jan 2003 22:52:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31680 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265895AbTAFDw1>; Sun, 5 Jan 2003 22:52:27 -0500
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <108220000.1041744901@titus>
References: <200211061734.42713.efocht@ess.nec.de>
	<200212021629.39060.efocht@ess.nec.de><200212181721.39434.efocht@ess.nec.de>
	 <200212311429.04382.efocht@ess.nec.de> <1041645514.21653.29.camel@kenai> 
	<108220000.1041744901@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Jan 2003 19:58:46 -0800
Message-Id: <1041825533.21653.41.camel@kenai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 21:35, Martin J. Bligh wrote:
> >> Here comes the minimal NUMA scheduler built on top of the O(1) load
> >> balancer rediffed for 2.5.53 with some changes in the core part. As
> >> suggested by Michael, I added the cputimes_stat patch, as it is
> >> absolutely needed for understanding the scheduler behavior.
> >
> > Thanks for this latest patch.  I've managed to cobble together
> > a 4 node NUMAQ system (16 700 MHZ PIII procs, 16GB memory) and
> > ran kernbench and schedbench on this, along with the 2.5.50 and
> > 2.5.52 versions.  Results remain fairly consistent with what
> > we have been obtaining on earlier versions.
> >
> > Kernbench:
> >                         Elapsed       User     System        CPU
> >              sched50     29.96s   288.308s    83.606s    1240.8%
> >              sched52    29.836s   285.832s    84.464s    1240.4%
> >              sched53    29.364s   284.808s    83.174s    1252.6%
> >              stock50    31.074s   303.664s    89.194s    1264.2%
> >              stock53    31.204s   306.224s    87.776s    1263.2%
> 
> Not sure what you're correllating here because your rows are all named
> the same thing. However, the new version seems to be much slower
> on systime (about 7-8% for me), which roughly correllates with your
> last two rows above. Me no like.

Sorry, I forgot to include a bit better description of what the
row labels mean.  

sched50 = linux 2.5.50 with the NUMA scheduler
sched52 = linux 2.5.52 with the NUMA scheduler
sched53 = linux 2.5.53 with the NUMA scheduler
stock50 = linux 2.5.50 without the NUMA scheduler
stock53 = linux 2.5.53 without the NUMA scheduler

Thus, this shows that the NUMA scheduler drops systime by ~5.5 secs,
or roughly 8%.  So, my testing is not showing an increase in systime
like you apparently are seeing.  

               Michael
-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

