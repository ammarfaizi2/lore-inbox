Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWDQXVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWDQXVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDQXVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:21:44 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:23486 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751336AbWDQXVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:21:43 -0400
Message-ID: <44442305.9010201@bigpond.net.au>
Date: Tue, 18 Apr 2006 09:21:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing
 outcomes
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com> <443EFFD2.4080400@bigpond.net.au> <20060414112750.A21908@unix-os.sc.intel.com> <44404455.8090304@bigpond.net.au> <20060417095920.A19931@unix-os.sc.intel.com>
In-Reply-To: <20060417095920.A19931@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 17 Apr 2006 23:21:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Apr 15, 2006 at 10:54:45AM +1000, Peter Williams wrote:
>> Yes, there are problems with the active/expired arrays but they're no 
>>> The only special check in find_busiest_group() helping MT/MC balancing
>>> is pwr_now and pwr_move calculations..
>> What about the very messy code I had to put in so that 
>> find_busiest_group() would return a group even if there were no queues 
>> in the group with more than one task.  Similar for find_busiest_queue().
> 
> Thats messy for sure and that was introduced by you to fix an imabalance
> issue for a simple DP system(with out breaking HT systems). I will post a fix
> for that.

By moving the active load balance trigger out of load_balance() and 
providing an independent trigger that does not require sub optimal 
normal load balancing, I hope?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
