Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbTAFF7O>; Mon, 6 Jan 2003 00:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTAFF7O>; Mon, 6 Jan 2003 00:59:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:50641 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266270AbTAFF7N>; Mon, 6 Jan 2003 00:59:13 -0500
Date: Sun, 05 Jan 2003 22:07:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Erich Focht <efocht@ess.nec.de>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
Message-ID: <234590000.1041833252@titus>
In-Reply-To: <1041825533.21653.41.camel@kenai>
References: <200211061734.42713.efocht@ess.nec.de><200212021629.39060.efocht@ess.nec.de><200212181721.39434.efocht@ess.nec.de> <200212311429.04382.efocht@ess.nec.de> <1041645514.21653.29.camel@kenai> <108220000.1041744901@titus> <1041825533.21653.41.camel@kenai>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Kernbench:
>> >                         Elapsed       User     System        CPU
>> >              sched50     29.96s   288.308s    83.606s    1240.8%
>> >              sched52    29.836s   285.832s    84.464s    1240.4%
>> >              sched53    29.364s   284.808s    83.174s    1252.6%
>> >              stock50    31.074s   303.664s    89.194s    1264.2%
>> >              stock53    31.204s   306.224s    87.776s    1263.2%
>>
>> Not sure what you're correllating here because your rows are all named
>> the same thing. However, the new version seems to be much slower
>> on systime (about 7-8% for me), which roughly correllates with your
>> last two rows above. Me no like.
>
> Sorry, I forgot to include a bit better description of what the
> row labels mean.
>
> sched50 = linux 2.5.50 with the NUMA scheduler
> sched52 = linux 2.5.52 with the NUMA scheduler
> sched53 = linux 2.5.53 with the NUMA scheduler
> stock50 = linux 2.5.50 without the NUMA scheduler
> stock53 = linux 2.5.53 without the NUMA scheduler
>
> Thus, this shows that the NUMA scheduler drops systime by ~5.5 secs,
> or roughly 8%.  So, my testing is not showing an increase in systime
> like you apparently are seeing.

Sorry, the row names weren't that bad if I actually read them carefully ;-)

I was doing a slightly different test - Erich's old sched code vs the new
both on 2.5.54, and seem to have a degredation.

M.

