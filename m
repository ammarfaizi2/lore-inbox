Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWDUGrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWDUGrW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWDUGrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:47:22 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:6 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751227AbWDUGrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:47:21 -0400
Subject: Re: Linux 2.6.17-rc2
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andi Kleen <ak@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, diegocg@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <p73bquv3cox.fsf@bragg.suse.de>
References: <20060419200001.fe2385f4.diegocg@gmail.com>
	 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
	 <20060420145041.GE4717@suse.de>
	 <20060420.122647.03915644.davem@davemloft.net>
	 <20060420193430.GH4717@suse.de>
	 <1145569031.25127.64.camel@piet2.bluelane.com>
	 <p73bquv3cox.fsf@bragg.suse.de>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Thu, 20 Apr 2006 23:47:10 -0700
Message-Id: <1145602031.5901.7.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2006 06:47:14.0614 (UTC) FILETIME=[6C83F560:01C6650F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 04:05 +0200, Andi Kleen wrote:
> Piet Delaney <piet@bluelane.com> writes:
> > 
> > FreeBSD folks developed a ZERO_COPY_SOCKET facility that uses COW; 
> > code looked great.
> 
> Linux had patches many years ago (in 2.3.x), but it was never merged
> because it is inherently unscalable on MP. Classical BSD sockets really 
> don't work well for zero copy - you need a new interface (like POSIX aio) 
> that allows the kernel/user to tell each other when use of data is
> finished and buffers can be reused.

Right, back when I was working on zero copy for 2.4 I noticed that 
2.6 seemed to support aio in the socket code, passing the kiocb 
pointer as I recall, and support in the socket  code for for sendpage
seemed enhanced. I was also wondering about using 2.6 and aio for zero
copy instead of tokens via sendmsg() and recvmsg() cmsghdr structures.

-piet

> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
---
piet@bluelane.com

