Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVFHOzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFHOzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFHOzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:55:05 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:49630 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261278AbVFHOyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:54:52 -0400
Date: Wed, 08 Jun 2005 10:54:49 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
In-reply-to: <20050608115956.GA7652@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Message-id: <200506081054.50001.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050607194119.GA11185@elte.hu>
 <200506080735.15530.gene.heskett@verizon.net> <20050608115956.GA7652@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 07:59, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> I just built this one, with RT but without the statistical stuff
>> enabled.  While rc6 works fine with tvtime-0.99, this gives a no
>> video blue screen, audio ok.
>
>could you check PREEMPT_DESKTOP too, with softirq/hardirq threading
>enabled/disabled?
>
> Ingo

Ok, next build with preempt mode 3, hard & softirq's theaded, as is 
RCU.

Kmix now normal, tvtime still fubar.

Build with mode 2 and it looks as if its all working:

[root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# grep PREEMPT .config
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT_DESKTOP is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
# CONFIG_PREEMPT_BKL is not set

Now, I note that going to the #2 mode (voluntary) turned off threaded 
RCU's, so I'm going to leave that off and try a mode 3 again. BRB.  

And that makes tvtime's video fail with a blue screen, audio ok..

Mode 2, FWIW, makes for quite jerky card motions while playing 
AisleRiot, the solitaire game.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
