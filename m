Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbTEGEhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTEGEhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:37:24 -0400
Received: from ns.suse.de ([213.95.15.193]:20755 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262842AbTEGEhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:37:23 -0400
Subject: Re: [PATCH][RFC] fixing the irqwcpustat mess
From: Andi Kleen <ak@suse.de>
To: David.Mosberger@acm.org
Cc: Christoph Hellwig <hch@lst.de>, davidm@mostang.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <16056.35787.271296.678842@panda.mostang.com>
References: <20030505212546.A24006@lst.de>
	<1052281495.18422.48.camel@averell> 
	<16056.35787.271296.678842@panda.mostang.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 May 2003 06:49:55 +0200
Message-Id: <1052282996.18422.50.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 06:30, David Mosberger-Tang wrote:
> >>>>> On 07 May 2003 06:24:54 +0200, Andi Kleen <ak@suse.de> said:
> 
>   Andi> On Mon, 2003-05-05 at 21:25, Christoph Hellwig wrote:
>   >>  +#ifndef __ARCH_IRQ_STAT irq_cpustat_t irq_stat[NR_CPUS]
>   >> ____cacheline_aligned; +EXPORT_SYMBOL(irq_stat); +#endif
> 
>   Andi> Shouldn't this be per_cpu_data ?
> 
> That's what we do on ia64.  Though we actually end up putting it in
> the cpuinfo structure, for historical reasons but also to ensure that
> it's close to some other stuff that's used on the irq path.

x86-64 does the same (putting it into the PDA). Was just commenting
generically for the other ports.

-Andi


