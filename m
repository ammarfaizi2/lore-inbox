Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbUCTQCv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbUCTQCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:02:51 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:27028 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S263455AbUCTQCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:02:49 -0500
Date: Sat, 20 Mar 2004 16:58:21 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040320154419.A6726@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com>
 <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Russell King wrote:

> Actually, ALSA is broken in that respect - it isn't portable as it
> stands.  It isn't the API which is broken - it's ALSA which is broken.
> Performing virt_to_page() on any non-direct mapped RAM page (which
> means the value returned from dma_alloc_coherent or pci_alloc_consistent)
> is undefined.
> 
> One of my current projects is fixing this crap in ALSA.

Yes, but if there's no API in the kernel code allowing to obtain page 
pointers using any value returned from dma_alloc_coherent(), then we 
cannot fix this problem.

So, it's not much subsystem (ALSA) problem, but kernel core is not matured
enough.

The same problem is for the cache coherency for mmaped pages.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
