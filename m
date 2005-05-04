Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVEDA2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVEDA2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVEDA2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:28:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32234 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261946AbVEDA20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:28:26 -0400
Message-ID: <42781724.3010703@us.ibm.com>
Date: Tue, 03 May 2005 17:28:20 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: dino@in.ibm.com, Paul Jackson <pj@sgi.com>,
       Simon Derr <Simon.Derr@bull.net>, lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
References: <20050501190947.GA5204@in.ibm.com> <4277F52B.8040908@us.ibm.com> <42781286.7080801@yahoo.com.au>
In-Reply-To: <42781286.7080801@yahoo.com.au>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Matthew Dobson wrote:
> 
>> Dinakar Guniguntala wrote:
>>
>>> +    lock_cpu_hotplug();
>>> +    rebuild_sched_domains(span1, span2);
>>> +    unlock_cpu_hotplug();
>>> +}
>>
>>
>>
>> Nitpicky, but span1 and span2 could do with better names.
>>
> 
> As could rebuild_sched_domains while we're at it.
> 
> partition_disjoint_sched_domains(partition1, partition2);
> ?
> 
> Dunno. That isn't really great, but maybe better? Pretty
> long, but it'll only ever be called in one or two places.

build_disjoint_sched_domains(partition1, partition2)?  Or just
partition_sched_domains(partition1, partition2)?  Partition and disjoint
seem mildly redundant to me, for varying definitions of partition... ;)

-Matt
