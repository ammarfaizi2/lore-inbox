Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUJEDPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUJEDPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUJEDPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:15:31 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:31572 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268753AbUJEDOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:14:54 -0400
Message-ID: <416211A3.8060806@yahoo.com.au>
Date: Tue, 05 Oct 2004 13:14:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Chen@vger.kernel.org, Kenneth W <kenneth.w.chen@intel.com>,
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
>

Load balancing wants to know if a task is considered cache hot.


