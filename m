Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTIASX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTIASX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:23:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263562AbTIASXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:23:22 -0400
Date: Mon, 1 Sep 2003 15:26:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
In-Reply-To: <20030830154137.GK24409@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0309011521490.6008-100000@logos.cnet>
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

Two things: I will leave this local pages change to be applied later. I
want to see what it does by itself (apply swap_out() changes & friends now
and on another -pre local pages).

> 05_vm_08_try_to_free_pages_nozone-4

@@ -737,7 +737,6 @@ static void free_more_memory(void)
        balance_dirty();
        wakeup_bdflush();
        try_to_free_pages(GFP_NOIO);
-       run_task_queue(&tq_disk);
        yield();
 }


Whats the reason behind this? 

