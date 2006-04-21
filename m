Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDUCGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDUCGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWDUCGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:06:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:43694 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbWDUCGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:06:16 -0400
To: piet@bluelane.com
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
References: <20060419200001.fe2385f4.diegocg@gmail.com>
	<Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
	<20060420145041.GE4717@suse.de>
	<20060420.122647.03915644.davem@davemloft.net>
	<20060420193430.GH4717@suse.de>
	<1145569031.25127.64.camel@piet2.bluelane.com>
From: Andi Kleen <ak@suse.de>
Date: 21 Apr 2006 04:05:50 +0200
In-Reply-To: <1145569031.25127.64.camel@piet2.bluelane.com>
Message-ID: <p73bquv3cox.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet Delaney <piet@bluelane.com> writes:
> 
> FreeBSD folks developed a ZERO_COPY_SOCKET facility that uses COW; 
> code looked great.

Linux had patches many years ago (in 2.3.x), but it was never merged
because it is inherently unscalable on MP. Classical BSD sockets really 
don't work well for zero copy - you need a new interface (like POSIX aio) 
that allows the kernel/user to tell each other when use of data is
finished and buffers can be reused.

-Andi
