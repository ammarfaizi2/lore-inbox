Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVHRVcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVHRVcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHRVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:32:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:41377 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932466AbVHRVcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:32:42 -0400
Date: Thu, 18 Aug 2005 23:32:37 +0200
From: Andi Kleen <ak@suse.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: idle task's task_t allocation on NUMA machines
Message-ID: <20050818213236.GC3953@verdi.suse.de>
References: <20050818140829.GB8123@implementation.labri.fr> <4304A6DF.6040703@cosmosbay.com> <20050818194941.GH8822@bouh.labri.fr> <20050818200255.GI8822@bouh.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818200255.GI8822@bouh.labri.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 10:02:55PM +0200, Samuel Thibault wrote:
> Samuel Thibault, le Thu 18 Aug 2005 21:49:41 +0200, a ?crit :
> > Eric Dumazet, le Thu 18 Aug 2005 17:18:55 +0200, a ?crit :
> > > I believe IRQ stacks are also allocated on node 0, that seems more serious.
> > 
> > For the i386 architecture at least, yes: they are statically defined in
> > arch/i386/kernel/irq.c, while they could be per_cpu.
> 
> Hum, but the per_cpu areas for i386 are not numa-aware... I'm wondering:
> isn't the current x86_64 numa-aware implementation of per_cpu generic
> enough for any architecture?

Actually it's broken for many x86-64 configurations now that use SRAT because
we assign the nodes to CPUs only after this code runs. I was considering
to remove it.

-Andi
