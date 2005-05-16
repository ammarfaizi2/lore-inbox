Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVEPFeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVEPFeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 01:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVEPFeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 01:34:18 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:29866 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261377AbVEPFeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 01:34:13 -0400
Message-ID: <428830CE.6010602@yahoo.com.au>
Date: Mon, 16 May 2005 15:34:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: anton@samba.org, paulus@samba.org, linux-ia64@vger.kernel.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] improve SMP reschedule and idle routines
References: <42881FE2.2000302@yahoo.com.au>	<20050515.220455.59467677.davem@davemloft.net>	<42882D44.50302@yahoo.com.au> <20050515.222722.63128129.davem@davemloft.net>
In-Reply-To: <20050515.222722.63128129.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Date: Mon, 16 May 2005 15:19:00 +1000
> 
> 
>>The other obvious problem with sparc64 that I didn't tackle is
>>your secondary CPU bringup - those CPUs will be calling cpu_idle
>>with preempt enabled as was previously required, but now should
>>have preempt disabled (ie. arch/sparc64/kernel/trampoline.S:
>>call cpu_idle)
> 
> 
> And adding a preempt_disable() call to the end of
> arch/sparc64/kernel/smp.c:smp_callin() won't work
> because?
> 

No that looks like it should work. If that is the "right"
place to put it, then that's perfect. I'll resend the patch
to you privately.

