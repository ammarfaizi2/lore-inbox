Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263756AbSJHUmE>; Tue, 8 Oct 2002 16:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbSJHUkm>; Tue, 8 Oct 2002 16:40:42 -0400
Received: from bitmover.com ([192.132.92.2]:24544 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263135AbSJHTBW>;
	Tue, 8 Oct 2002 15:01:22 -0400
Date: Tue, 8 Oct 2002 12:07:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       mau@oscar.prima.de, linux-kernel@vger.kernel.org
Subject: Re: LMbench results for 2.5.40
Message-ID: <20021008120700.C7160@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
	"David S. Miller" <davem@redhat.com>, mau@oscar.prima.de,
	linux-kernel@vger.kernel.org
References: <20021001163757.J13270@work.bitmover.com> <Pine.LNX.3.96.1021008144209.5056D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1021008144209.5056D-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Oct 08, 2002 at 02:55:01PM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 02:55:01PM -0400, Bill Davidsen wrote:
> On Tue, 1 Oct 2002, Larry McVoy wrote:
> 
> > By the way, the place you will probably see variance in LMbench is in the
> > context switch benchmarks, it's almost certainly due to randomness in 
> > cache layout and there isn't a thing we can do about it.  You can run a
> > zillion runs to get an average but please realize that is an *average*.
> > The context switch number are accurate, the low ones represent no cache
> > collisions and the high ones represent lots of cache collisions.
> > 
> > FYI.  I don't like it either.
> 
> Thank you, that explains some things I've seen in my context switching
> benchmark as well, which uses a bunch of different services to transfer
> tiny data from on process to another.
> 
> Time for some statistical jiggery-pokery, dust off deviant mean or some
> such.

I personally think that you should try a scatter plot and you should
get something sort of like http://www.bitmover.com/disks/sek.gif which
is read latency times scatter plotted nicely showing the effect of seeks
and the effects of rotational delay.  The height of the band is what I'd
expect to see in the context switch results - there should be an even
distribution between the min and the max assuming that you can vary the
pages which get allocated when you run the tests.

The average is a misleading number, you really want a min/max style number.
I'd be quite interested if someone were to go off and do this.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
