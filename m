Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUC3HOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUC3HOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:14:47 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:17765 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262136AbUC3HOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:14:45 -0500
Message-ID: <40691E58.2080500@yahoo.com.au>
Date: Tue, 30 Mar 2004 17:14:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <20040325162121.5942df4f.ak@suse.de>	<20040325193913.GA14024@elte.hu>	<20040325203032.GA15663@elte.hu>	<20040329084531.GB29458@wotan.suse.de>	<4068066C.507@yahoo.com.au>	<20040329080150.4b8fd8ef.ak@suse.de>	<20040329114635.GA30093@elte.hu>	<20040329221434.4602e062.ak@suse.de>	<4068B692.9020307@yahoo.com.au>	<20040330083450.368eafc6.ak@suse.de>	<20040330064015.GA19036@elte.hu> <20040330090716.67d2a493.ak@suse.de>
In-Reply-To: <20040330090716.67d2a493.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, 30 Mar 2004 08:40:15 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Andi Kleen <ak@suse.de> wrote:
>>
>>
>>>>So both -mm5 and Ingo's sched.patch are much worse than
>>>>what 2.4 and 2.6 get?
>>>
>>>Yes (2.6 vanilla and 2.4-aa at that, i haven't tested 2.4-vanilla)
>>>
>>>Ingo's sched.patch makes it a bit better (from 1x CPU to 1.5-1.7xCPU),
>>>but still much worse than the max of 3.7x-4x CPU bandwidth.
>>
>>Andi, could you please try the patch below - this will test whether this
>>has to do with the rate of balancing between NUMA nodes. The patch
>>itself is not correct (it way overbalances on NUMA), but it tests the
>>theory.
> 
> 
> This works much better, but wildly varying (my tests go from 2.8xCPU to 
> ~3.8x CPU for 4 CPUs. 2,3 CPU cases are ok). A bit more consistent 
> results would be better though.
> 

Oh good, thanks Ingo. Andi you probably want to lower your minimum
balance time too then, and maybe try with an even lower maximum.
Maybe reduce cache_hot_time a bit too.
