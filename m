Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbTCQFnj>; Mon, 17 Mar 2003 00:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbTCQFnj>; Mon, 17 Mar 2003 00:43:39 -0500
Received: from holomorphy.com ([66.224.33.161]:41432 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262800AbTCQFnj>;
	Mon, 17 Mar 2003 00:43:39 -0500
Date: Sun, 16 Mar 2003 21:54:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: Re: [Lse-tech] [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16 IOAPICs, 223 IRQs
Message-ID: <20030317055415.GM5891@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>,
	Mark Haverkamp <markh@osdl.org>
References: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 12:21:42AM -0500, Zwane Mwaikambo wrote:
> I've managed to put together a patch which allows a NUMAQ box with 
> more than 8 IOAPICs to boot, the current workaround is to force it to 8 
> or lower. This was achieved by setting up percpu idts thus allowing 
> us to implement per node vector spaces. The previous hurdle was running out 
> of vectors to assign, the current one is running out of irqs, something 
> which i'll further be looking at.
> Later on i'm planning to move to per node IDTs so that i can fix f00f 
> workaround and also save space on nodeless systems. To do this will 
> probably require early_cpu_to_node workalikes (or perhaps just use 
> logical_smp_processor_id and apic_to_node).
> Thanks to the folks at OSDL (and Mark for giving up his 4quad for so 
> long) for providing me access to the 8quad.

Running out of IRQ's? Simply jacking up NR_IRQS and HARDIRQ_BITS should
suffice if this is what I think it is.


-- wli
