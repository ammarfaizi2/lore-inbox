Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUA0Ckr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 21:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUA0Ckr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 21:40:47 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:28076 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261827AbUA0Cko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 21:40:44 -0500
Message-ID: <4015CF8A.6000006@cyberone.com.au>
Date: Tue, 27 Jan 2004 13:40:10 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: habanero@us.ibm.com
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
References: <20040125235431.7BC192C0FF@lists.samba.org> <200401261740.12657.habanero@us.ibm.com> <4015ABA8.3090202@cyberone.com.au> <200401262021.45885.habanero@us.ibm.com>
In-Reply-To: <200401262021.45885.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Theurer wrote:

>On Monday 26 January 2004 18:07, Nick Piggin wrote:
>
>>>>Well OK, this would require a per architecture function to handle
>>>>CPU hotplug. It could possibly just default to arch_init_sched_domains,
>>>>and just completely reinitialise everything which would be the simplest.
>>>>
>>>Call me crazy, but why not let the topology be determined via userspace at
>>>a more appropriate time?  When you hotplug, you tell it where in the
>>>scheduler to plug it.  Have structures in the scheduler which represent
>>>the nodes-runqueues-cpus topology (in the past I tried a node/rq/cpu
>>>structs with simple pointers), but let the topology be built based on
>>>user's desires thru hotplug.
>>>
>>Well isn't userspace's idea of topology just what the kernel tells it?
>>I'm not sure what it would buy you... but I guess it wouldn't be too
>>much harder than doing it in kernel, just a matter of making the userspace
>>API.
>>
>
>Sort of, the cpus to node is pretty much what the kernel says it is, but the 
>cpu to runqueue mapping IMO is not a clear cut thing.
>
>

But userspace still can't know more than the kernel tells it.
Apart from that, the SMT stuff in the sched domains patch means
SMT CPUs need not share runqueues.


