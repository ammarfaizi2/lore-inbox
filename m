Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbTIAS6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTIAS6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:58:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45230 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261822AbTIAS6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:58:12 -0400
Date: Mon, 1 Sep 2003 16:00:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
In-Reply-To: <20030830154137.GK24409@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0309011553210.6008-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Aug 2003, Andrea Arcangeli wrote:

> On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> > 
> > > You need to integrate with -aa on the VM.  It has been hard enough for
> > > Andrea to get his stuff in, I doubt you will fair any better.
> > 
> > Thats because I never received separate patches which make sense one by
> > one.  Most of Andreas changes are all grouped into few big patches that
> > only he knows the mess. That is not the way to merge things.
> > 
> > I want to work out with him after I merge other stuff to address that.
> 
> that's true for only one patch, the others are pretty orthogonal after
> Andrew helped splitting them:
> 
> 
> 05_vm_03_vm_tunables-4
> 05_vm_05_zone_accounting-2
> 05_vm_06_swap_out-3
> 05_vm_07_local_pages-4
> 05_vm_08_try_to_free_pages_nozone-4
> 05_vm_09_misc_junk-3
> 05_vm_10_read_write_tweaks-3
> 05_vm_13_activate_page_cleanup-1
> 05_vm_15_active_page_swapout-1
> 05_vm_16_active_free_zone_bhs-1
> 05_vm_17_rest-10

Can you please split the watermark changes from 05_vm_rest-10 and send me
that ? (no waitqueue changes, no page wakeup logic changes)

As I said previously, lets start with the page reclaiming logic changes 
first, which include:

05_vm_03_vm_tunables-4
05_vm_05_zone_accounting-2
05_vm_06_swap_out-3 

And the necessary (ONLY watermark stuff AFAICS) from 05_vm_rest-10. 

Right?

Thanks

> 05_vm_18_buffer-page-uptodate-1
> 05_vm_20_cleanups-3
> 05_vm_21_rt-alloc-1
> 05_vm_22_vm-anon-lru-1
> 05_vm_23_per-cpu-pages-3
> 05_vm_24_accessed-ipi-only-smp-1
> 05_vm_25_try_to_free_buffers-invariant-1
> 
> The "mess" one is only 05_vm_17_rest-10 as far as I can tell.
> 
> Andrea
> 


