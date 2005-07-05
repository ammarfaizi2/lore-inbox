Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVGEHq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVGEHq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 03:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVGEHq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 03:46:56 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:34265 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261384AbVGEHqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 03:46:53 -0400
Message-ID: <42CA3AEA.3020204@bigpond.net.au>
Date: Tue, 05 Jul 2005 17:46:50 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.1 for 2.6.11 and 2.6.12
References: <42B65525.1060308@bigpond.net.au> <200506201541.29668.kernel@kolivas.org> <42B65FAC.4090400@bigpond.net.au>
In-Reply-To: <42B65FAC.4090400@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 5 Jul 2005 07:46:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Con Kolivas wrote:
> 
>> On Mon, 20 Jun 2005 15:33, Peter Williams wrote:
>>
>>> PlugSched-5.2.1 is available for 2.6.11 and 2.6.12 kernels.  This
>>> version applies Con Kolivas's latest modifications to his "nice" aware
>>> SMP load balancing patches.
>>
>>
>>
>> Thanks Peter.
>> Any word from your own testing/testers on how well smp nice balancing 
>> is working for them now? 
> 
> 
> No, they got side tracked onto something else but should start working 
> on it again soon.  I'll give them a prod :-)

Con,
	We've done some more testing with this with results that are still 
disappointing.  We think that one reason for this is that move_tasks() 
doesn't take "nice" into account.  I'm going to look at modifying it so 
that it moves a certain amount of niceness rather than a specified 
number of tasks.
	A second (more difficult to solve) issue is that we think it would work 
better if both queue lengths and "nice" loads were kept approximately 
equal between the queues.  It's hard to see how this can be managed 
without considerable overhead.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
