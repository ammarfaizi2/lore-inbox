Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUHEAAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUHEAAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 20:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHEAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 20:00:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16516 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267518AbUHEAAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:00:20 -0400
Date: Wed, 04 Aug 2004 16:59:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Rick Lindsley <ricklind@us.ibm.com>
cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <239380000.1091663979@flay>
In-Reply-To: <411174C6.2020109@bigpond.net.au>
References: <6560000.1091632215@[10.10.2.4]> <7480000.1091632378@[10.10.2.4]> <20040804122414.4f8649df.akpm@osdl.org> <411174C6.2020109@bigpond.net.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, August 05, 2004 09:44:06 +1000 Peter Williams <pwil3058@bigpond.net.au> wrote:

> Andrew Morton wrote:
>> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>>> SDET 8  (see disclaimer)
>>>                            Throughput    Std. Dev
>>>                     2.6.7       100.0%         0.2%
>>>                 2.6.8-rc2       100.2%         1.0%
>>>             2.6.8-rc2-mm2       117.4%         0.9%
>>> 
>>> SDET 16  (see disclaimer)
>>>                            Throughput    Std. Dev
>>>                     2.6.7       100.0%         0.3%
>>>                 2.6.8-rc2        99.5%         0.3%
>>>             2.6.8-rc2-mm2       118.5%         0.6%
>> 
>> 
>> hum, interesting.  Can Con's changes affect the inter-node and inter-cpu
>> balancing decisions, or is this all due to caching effects, reduced context
>> switching etc?
> 
> One candidate for the cause of this improvement is the replacement of the active/expired array mechanism with a single array.  I believe that one of the short comings of the active/expired array mechanism is that it can lead to excessive queuing (possibly even starvation) of tasks that aren't considered "interactive".

Rick showed me schedstats graphs of the two ... it seems to have lower
latency, does less rebalancing, fewer pull_tasks, etc, etc. Everything
looks better ... he'll send them out soon, I think (hint, hint).

M.

