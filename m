Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUCYQyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUCYQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:54:17 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44928 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263188AbUCYQyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:54:14 -0500
Date: Thu, 25 Mar 2004 08:53:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, ricklind@us.ibm.com,
       anton@samba.org, lse-tech@lists.sourceforge.net
Subject: RE: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <78440000.1080233603@flay>
In-Reply-To: <7F740D512C7C1046AB53446D3720017301119907@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D3720017301119907@scsmsx402.sc.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have found some performance regressions (e.g. SPECjbb) with the
> scheduler on a large IA-64 NUMA machine, and we are debugging it. On SMP
> machines, we haven't seen performance regressions.

Is this the SPECjbb / Java thing that believes that sched_yield is a
stable locking primitive? If so, it needs to be ignored ;-) That's
the problem we had here, at least ...

M.
 
> Jun
> 
>> -----Original Message-----
>> From: Andi Kleen [mailto:ak@suse.de]
>> Sent: Wednesday, March 24, 2004 8:56 PM
>> To: Ingo Molnar
>> Cc: piggin@cyberone.com.au; linux-kernel@vger.kernel.org;
> akpm@osdl.org;
>> kernel@kolivas.org; rusty@rustcorp.com.au; Nakajima, Jun;
>> ricklind@us.ibm.com; anton@samba.org; lse-tech@lists.sourceforge.net;
>> mbligh@aracnet.com
>> Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
> sched-2.6.5-rc2-mm2-
>> A3
>> 
>> On Thu, 25 Mar 2004 09:28:09 +0100
>> Ingo Molnar <mingo@elte.hu> wrote:
>> 
>>> i've reviewed the sched-domains balancing patches for upstream
> inclusion
>>> and they look mostly fine.
>> 
>> The main problem it has is that it performs quite badly on Opteron NUMA
>> e.g. in the OpenMP STREAM test (much worse than the normal scheduler)
>> 
>> -Andi
> 
> 


