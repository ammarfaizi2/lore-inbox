Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTEGFMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTEGFMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:12:22 -0400
Received: from verein.lst.de ([212.34.181.86]:3090 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262872AbTEGFMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:12:21 -0400
Date: Wed, 7 May 2003 07:24:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andi Kleen <ak@suse.de>
Cc: davidm@mostang.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] fixing the irqwcpustat mess
Message-ID: <20030507072452.A6841@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, Andi Kleen <ak@suse.de>,
	davidm@mostang.com, linux-kernel@vger.kernel.org
References: <20030505212546.A24006@lst.de> <1052281495.18422.48.camel@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1052281495.18422.48.camel@averell>; from ak@suse.de on Wed, May 07, 2003 at 06:24:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:24:54AM +0200, Andi Kleen wrote:
> On Mon, 2003-05-05 at 21:25, Christoph Hellwig wrote:
> 
> >  
> > +#ifndef __ARCH_IRQ_STAT
> >  irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
> > +EXPORT_SYMBOL(irq_stat);
> > +#endif
> 
> Shouldn't this be per_cpu_data ?

Yes, it should.  I have a patch for this but it' a separate issue.
