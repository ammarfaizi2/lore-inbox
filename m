Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUKIWqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUKIWqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKIWpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:45:36 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:44759 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261756AbUKIWoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:44:39 -0500
Date: Tue, 9 Nov 2004 23:44:23 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041109224423.GC18366@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041109144607.2950a41a.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 02:46:07PM -0800, Andrew Morton wrote:
> > > Can you please run your workload which cause 0-order page allocation 
> > > failures with the following patch, pretty please? 
> > > 
> > > We will have more information on the free areas state when the allocation 
> > > fails.
> > > 
> > > Andrew, please apply it to the next -mm, will you?
> > 
> > here is the trace:
> >  klogd: page allocation failure. order:0, mode: 0x20
> >   [__alloc_pages+441/862] __alloc_pages+0x1b9/0x363
> >   [__get_free_pages+42/63] __get_free_pages+0x25/0x3f
> >   [kmem_getpages+37/201] kmem_getpages+0x21/0xc9
> >   [cache_grow+175/333] cache_grow+0xab/0x14d
> >   [cache_alloc_refill+376/537] cache_alloc_refill+0x174/0x219
> >   [__kmalloc+137/140] __kmalloc+0x85/0x8c
> >   [alloc_skb+75/224] alloc_skb+0x47/0xe0
> >   [e1000_alloc_rx_buffers+72/227] e1000_alloc_rx_buffers+0x44/0xe3
> >   [e1000_clean_rx_irq+402/1095] e1000_clean_rx_irq+0x18e/0x447
> >   [e1000_clean+85/202] e1000_clean+0x51/0xca
> 
> What kernel is in use here?
> 
> There was a problem related to e1000 and TSO which was leading to these
> over-aggressive atomic allocations.  That was fixed (within ./net/)
> post-2.6.9.

I use vanilla 2.6.9.

-- 
Luká¹ Hejtmánek
