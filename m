Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131760AbRBKCfx>; Sat, 10 Feb 2001 21:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbRBKCfp>; Sat, 10 Feb 2001 21:35:45 -0500
Received: from [194.73.73.176] ([194.73.73.176]:16047 "EHLO protactinium")
	by vger.kernel.org with ESMTP id <S131760AbRBKCff>;
	Sat, 10 Feb 2001 21:35:35 -0500
Date: Sun, 11 Feb 2001 02:33:48 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102100958090.1007-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.31.0102110227530.3652-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Mike Galbraith wrote:

> > > o	Rebalance the 2.4.1 VM				(Rik van Riel)
> This change makes my box swap madly under load.  It appears to be
> keeping more cache around than is really needed, and therefore
> having to resort to swap instead.  The result is MUCH more I/O than
> previous kernels while doing the same exact job.

I concur this, I watched a DVD tonight, and actually it got so bad
I had to reboot at one point as the it became too jerky to watch.
free output looked like this at this point...

             total       used       free     shared    buffers     cached
Mem:        254960     253252       1708          0      24116     174500
-/+ buffers/cache:      54636     200324
Swap:       248996      20848     228148

It appeared, that rather than free the cached buffers and reuse the
memory, it preferred to hit swap space. Streaming I/O performance seems
to have taken a hit lately.

(This was 2.4.1-ac9 btw)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
