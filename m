Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269453AbUINRK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbUINRK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269458AbUINREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:04:15 -0400
Received: from holomorphy.com ([207.189.100.168]:61332 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269516AbUINQqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:46:06 -0400
Date: Tue, 14 Sep 2004 09:45:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914164557.GV9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random> <200409140916.48786.jbarnes@engr.sgi.com> <20040914163143.GQ4180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914163143.GQ4180@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 06:31:43PM +0200, Andrea Arcangeli wrote:
> per-cpu certainly sounds simple enough conceptually, so if you can
> notice any slowdown even with idle loop ruled out, per-cpu is sure
> better.
> This bouncing is likely to hurt smaller SMP too (but once the cpu is
> idle normally it's not a too bad thing since it only hurted reschedule
> latency, since we remain stuck in the timer irq for a bit longer than we
> should), but duplicating the ram of the array there doesn't look as nice
> as it would be on the altix, not all SMP have tons of ram. So an
> intermediate solution for this problem still sound worthwhile for the
> normal smp case.

Could you clarify whether you deem the per-cpu hashtable -based
amortization acceptable or whether this refers to per-cpu profile
buffers? I devised the hashtables to address space footprint concerns,
so I'm in a pickle if both have pending objections.

Thanks.


-- wli
