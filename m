Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269350AbRHTVGK>; Mon, 20 Aug 2001 17:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269387AbRHTVGB>; Mon, 20 Aug 2001 17:06:01 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:35946
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S269350AbRHTVFn>; Mon, 20 Aug 2001 17:05:43 -0400
Message-ID: <3B817BB0.1050507@fugmann.dhs.org>
Date: Mon, 20 Aug 2001 23:05:52 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
In-Reply-To: <20010818231704.A2388@ieee.org> <3B7FF06A.4090606@fugmann.dhs.org> <20010819013508.B2388@ieee.org> <3B81350C.E48FCF11@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



george anzinger wrote:
> 
> A simple example is the ../kernel/timer.c code.  The "run_task_list()"
> function is called from a tasklet.  "do_timer()" is called from
> interrupt and "mark_bh(TIMER_BH)" puts the tasklet in the queue. 
> "timer_bh()" (old names die hard) is the tasklet.
> 
mark_bh is the use of old BH's.
You want to use tasklet_schedule if a tasklet should be sheduled.
(_not_ tasklet_hi_schedule, those are the BH's)

Regards
Anders Fugmann

> George
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


