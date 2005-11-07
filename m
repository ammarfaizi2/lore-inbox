Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965564AbVKGXGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965564AbVKGXGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965586AbVKGXGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:06:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:20895 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965564AbVKGXGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:06:13 -0500
Message-ID: <436FDDE2.4000708@us.ibm.com>
Date: Mon, 07 Nov 2005 17:06:10 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org, mbligh@mbligh.org, slpratt@us.ibm.com,
       anton@samba.org
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

>   If I am understanding the data you posted, it looks like you are 
> useing sched_yield extensivly in your database. 

Yes, I've seen problems in the past with workloads that use sched_yield 
heavily.

But bear in mind, the ~2700 sched_yields shown in the schedstats 
occurred over a 9 minute period. 
That means that sched_yield is being called at a rate of around 5 per 
second -- this is not a heavy user of sched_yield.

To put this into a broader perspective, this workload has around 270 
tasks, and the context switch rate is around
45,000 per second.



