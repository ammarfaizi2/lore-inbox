Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUJEFFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUJEFFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUJEFFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:05:38 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:28604 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S268762AbUJEFFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:05:36 -0400
Message-ID: <41622B9D.904@bigpond.net.au>
Date: Tue, 05 Oct 2004 15:05:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenneth W Chen <kenneth.w.chen@intel.com>
CC: Con Kolivas <kernel@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:activate_task()
References: <200410050216.i952Gb620657@unix-os.sc.intel.com> <cone.1096943670.717018.10082.502@pc.kolivas.org>
In-Reply-To: <cone.1096943670.717018.10082.502@pc.kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Chen, Kenneth W writes:
> 
>> Update p->timestamp to "now" in activate_task() doesn't look right
>> to me at all.  p->timestamp records last time it was running on a
>> cpu.  activate_task shouldn't update that variable when it queues
>> a task on the runqueue.
>>
>> This bug (and combined with others) triggers improper load balancing.
> 
> 
> The updated timestamp was placed there by Ingo to detect on-runqueue 
> time. If it is being used for load balancing then it is being used in 
> error.

The ZAPHOD scheduler (being trialled in 2.6.9-rc3-mm2) uses its own time 
stamp so as not to interfere with the use of timestamp by load balancing 
code so it should be OK to delete this line form activate_task() in 
2.6.9-rc3-mm2 without effecting ZAPHOD.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
