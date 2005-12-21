Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVLUTSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVLUTSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVLUTSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:18:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59088 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751175AbVLUTSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:18:46 -0500
Date: Wed, 21 Dec 2005 13:18:43 -0600
From: Mark Maule <maule@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 3/4] per-platform IA64_{FIRST,LAST}_DEVICE_VECTOR definitions
Message-ID: <20051221191843.GJ9920@sgi.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184353.5003.87888.74327@attica.americas.sgi.com> <20051221190916.GE2361@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221190916.GE2361@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:09:16PM -0700, Matthew Wilcox wrote:
> On Wed, Dec 21, 2005 at 12:42:46PM -0600, Mark Maule wrote:
> >  #ifndef CONFIG_X86_IO_APIC
> >  int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
> > -u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
> > +u8 irq_vector[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS - 1 ] = 0 };
> 
> Isn't this just a very complicated way of saying:
> 
> u8 irq_vector[NR_IRQ_VECTORS];
> 
> ?

Ok.  Was just following the lead of this:

static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };

So arrays are always init'd to zero?

Mark
