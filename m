Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWARSNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWARSNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWARSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:13:39 -0500
Received: from fmr20.intel.com ([134.134.136.19]:10924 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964900AbWARSNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:13:38 -0500
Message-ID: <43CE854E.4060703@ichips.intel.com>
Date: Wed, 18 Jan 2006 10:13:34 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <iod00d@hp.com>
CC: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] RE: [PATCH 2/5] [RFC] Infiniband: connection
 abstraction
References: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com> <ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com> <20060118020342.GB3740@esmail.cup.hp.com> <43CE7EDB.7030201@ichips.intel.com> <20060118180243.GD6818@esmail.cup.hp.com>
In-Reply-To: <20060118180243.GD6818@esmail.cup.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
>>>Is this code going to get invoked very often?
>>
>>In practice, it would be invoked when matching any listen requests 
>>originating from the CMA (RDMA connection abstraction).
> 
> hrm..I'm not sure how to translate your answer into a workload.
> e.g. which netperf or netpipe test would excercise this alot?
> Or would it take something like MPI or specweb/ttcp?

The code will be invoked at least once for every connection that is established.

>>>e.g something like:
>>>	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE/sizeof(unsigned 
>>>	long);
>>>									i++)
>>>		((unsigned long *)dst)[i] = ((unsigned long *)src)[i] 
>>>						& ((unsigned long *)mask)[i];
>>
>>Yes - something like this should work.  Thanks.
> 
> 
> Do you need a patch?
> I can submit one but it will be untested.

I will incorporate the change with the next set of updates.  Someone else 
pointed out that I'd need to make sure that there won't be any alignment issues.

- Sean
