Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUJBXyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUJBXyV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUJBXyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:54:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:55208 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267638AbUJBXyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:54:11 -0400
Message-ID: <415F3F1A.7060304@watson.ibm.com>
Date: Sat, 02 Oct 2004 19:51:54 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu> <415ED4A4.1090001@watson.ibm.com> <20041002105305.2caf97ae.pj@sgi.com> <415EF069.7090902@watson.ibm.com> <415F39E3.3080406@bigpond.net.au>
In-Reply-To: <415F39E3.3080406@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Williams wrote:

> Hubertus Franke wrote:
> 
>>
>>
>> Paul Jackson wrote:

>> A minimal quote from your website :-)
>>
>> "CpuMemSets provides a new Linux kernel facility that enables system 
>> services and applications to specify on which CPUs they may be 
>> scheduled, and from which nodes they may allocate memory."
>>
>> Since I have addressed the cpu section it seems obvious that
>> in order to ISOLATE different workloads, you associate them onto
>> non-overlapping cpusets, thus technically they are physically isolated
>> from each other on said chosen CPUs.
>>
>> Given that cpuset hierarchies translate into cpu-affinity masks,
>> this desired isolation can result in lost cycles globally.
> 
> 
> This argument if followed to its logical conclusion would advocate the 
> abolition of CPU affinity masks completely.
> 

No, why is that. One can restrict memory on a task and by doing so waste 
  cycles in paging. That does not mean we should get ride of memory 
restrictions or a like.
Loosing cycles is simply an observation of what could happen.

As in any system, over constraining a given workload (wrt to affinity, 
cpu limits, rate control) can lead to suboptimal utilization of 
resources. That does not mean there is no rational for the constraints 
in the first place and hence they should never be allowed in the first 
place.

Cheers ..


