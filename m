Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLZJdI>; Thu, 26 Dec 2002 04:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLZJdI>; Thu, 26 Dec 2002 04:33:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:33197 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262813AbSLZJdI>;
	Thu, 26 Dec 2002 04:33:08 -0500
Message-ID: <3E0ACEBC.D06B1BAB@digeo.com>
Date: Thu, 26 Dec 2002 01:41:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: conman@kolivas.net
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.53-mm1 with contest
References: <200212261934.36086.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2002 09:41:16.0810 (UTC) FILETIME=[EFE39EA0:01C2ACC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.52 [3]              84.4    79      17      19      1.26
> 2.5.52-mm1 [7]          91.0    79      18      19      1.36
> 2.5.52-mm2 [7]          90.3    79      18      19      1.35
> 2.5.53 [7]              86.9    77      18      21      1.30
> 2.5.53-mm1 [7]          117.1   58      47      40      1.75
> Big change in the balance here in process_load. Probably a better balance
> really given that process_load runs 4*num_cpus processes, and the kernel
> compile is make -j (4*num_cpus)

Presumably the run-child-first change.  process_load is complex.  I
haven't looked into its dynamics and I'm not sure what, if anything,
we can conclude from this test.
 
> ...
> The SMP results seem to fluctuate too much between runs even with the average
> of 7 runs. I'm wondering whether I should even bother with them any more as
> they dont add any useful information as far as I can see. Comments on this
> would be appreciated. Andrew?

Well for the sorts of things which you are interested in, SMP is not the
target market, shall we say?

Is the variability seen in other kernels (especially 2.4)?  If not then
we'd need to find out what causes it.
