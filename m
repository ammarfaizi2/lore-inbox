Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVF0R3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVF0R3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVF0R3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 13:29:23 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:6345 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261283AbVF0R3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 13:29:16 -0400
Date: Mon, 27 Jun 2005 13:29:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050627081712.GB15096@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506271329.14562.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
 <200506270143.47690.gene.heskett@verizon.net> <20050627081712.GB15096@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 04:17, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> In the FWIW category, I booted 50-23 about an hour & a half ago,
>> same mode 3, no hardirq's, everything seems to be working fine
>> except for kmails total lack of threading causeing composer hangs
>> while a mail fetch/spamassassin run is in progress.  But thats not
>> anything new to this patchset, its an equal opportunity annoyer.
>
>does the patch below make the kmail starvation go away?
>
I put in the comment and its building now.  I rather doubt its going 
to make a huge diff though as its probably the single most repeated 
bitch on the kmail lists, and has been for a long, very long as in 
years, time.  From hints dropped here and there, it might finally be 
fixed with kde-3.5.  But we'll give this a shot nontheless.  I'll add 
more after I reboot to test.

Now rebooted.

I don't think its made a noticable difference, I'm still getting the 
hangs of up to 30 seconds but I'll let it run the rest of the 
afternoon so I get a better feel for it.  It doesn't often miss a 
keystroke, they will eventually be echoed back to the screen.

> Ingo
>
>Index: kernel/sched.c
>===================================================================
>--- kernel/sched.c.orig
>+++ kernel/sched.c
>@@ -1055,7 +1055,7 @@ static int try_to_wake_up(task_t * p, un
>  /*
>   * sync wakeups can increase wakeup latencies:
> 	 */
>-	if (rt_task(p))
>+//	if (rt_task(p))
> 		sync = 0;
> #endif
> 	rq = task_rq_lock(p, &flags);

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
