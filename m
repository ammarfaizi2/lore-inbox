Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUDPTrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUDPTrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:47:31 -0400
Received: from nsmtp.pacific.net.th ([203.121.130.117]:52140 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263424AbUDPTr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:47:29 -0400
Date: Sat, 17 Apr 2004 03:45:05 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: ncunningham@users.sourceforge.net
Subject: Re: 2.4.26 intermittent kernel bug on boot.
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <opr6j9q0d54evsfm@smtp.pacific.net.th> <1082140624.19725.82.camel@laptop-linux.wpcb.org.au>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr6kehfsr4evsfm@smtp.pacific.net.th>
In-Reply-To: <1082140624.19725.82.camel@laptop-linux.wpcb.org.au>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004 04:37:05 +1000, Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:

> Hi.
>
> On Sat, 2004-04-17 at 04:02, Michael Frank wrote:
>> kernel BUG at slab.c:1238!
>
> That's a really strange oops to see. It's testing that the GFP flags
> match the slab's flags. To get an oops there, you'd have to have a
> non-dma slab (which makes sense), but you've called the kmem_cache_alloc
> routine with a DMA flag. Line 444 of kernel/signal.c clearly doesn't do
> that! Could the args be being corrupted while being passed?

I had sometimes hangs while calibrating delay loop with earlier kernels,
Alan Cox suggested SMI screwing things up. This bug is earlier and new.

> What does a backtrace look like?
>

Too bad, kdb not fully init, modules not loaded, so no BT command.

Michael
