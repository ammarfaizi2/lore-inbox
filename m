Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292163AbSBYTga>; Mon, 25 Feb 2002 14:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSBYTgV>; Mon, 25 Feb 2002 14:36:21 -0500
Received: from air-2.osdl.org ([65.201.151.6]:14721 "EHLO
	wookie-laptop.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S293453AbSBYTgK>; Mon, 25 Feb 2002 14:36:10 -0500
Subject: Re: [Lse-tech] NUMA scheduling
From: "Timothy D. Witham" <wookie@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Erich Focht <focht@ess.nec.de>, Mike Kravetz <kravetz@us.ibm.com>,
        Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020225110327.A22497@work.bitmover.com>
In-Reply-To: <Pine.LNX.4.21.0202251737420.30318-100000@sx6.ess.nec.de>
	<20940000.1014663303@flay>  <20020225110327.A22497@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 11:35:22 -0800
Message-Id: <1014665722.1236.66.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-25 at 11:03, Larry McVoy wrote:
 Snip
> 
> If you read the early hardware papers on SMP, they all claim "Symmetric
> Multi Processor", i.e., you can run any process on any CPU.  Skip forward
> 3 years, now read the cache affinity papers from the same hardware people.
> You have to step back and squint but what you'll see is that these papers
> could be summarized on one sentence:
> 
> 	"Oops, we lied, it's not really symmetric at all"
> 

  In the interests of historical accuracy.  It was a case of underlying
technology changes.  The original research was done with processors
with 8k caches (total) with the processors external and
internal bus speeds being the same and those equal to the backplane
bus speed.  Shift forward 4 years and you had 512 KB external caches,
and a ratio of the difference between the external processor cache
and main memory of over 20x.  This resulted in a very different 
set of optimizations resulting in the cache affinity schedulers. 

Tim
 
processor boards with 512K caches.  In  
> You should treat each CPU as a mini system and think of a process reschedule
> someplace else as a checkpoint/restart and assume that is heavy weight.  In
> fact, I'd love to see the scheduler code forcibly sleep the process for 
> 500 milliseconds each time it lands on a different CPU.  Tune the system
> to work well with that, then take out the sleep, and you'll have the right
> answer.
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

