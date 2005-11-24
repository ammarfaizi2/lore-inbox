Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVKXU2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVKXU2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVKXU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:28:34 -0500
Received: from gold.veritas.com ([143.127.12.110]:50203 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932652AbVKXU2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:28:33 -0500
Date: Thu, 24 Nov 2005 20:28:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Matt Mackall <mpm@selenic.com>, akpm@osdl.org, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: + shut-up-warnings-in-ipc-shmc.patch added to -mm tree
In-Reply-To: <20051124174622.GC18971@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0511242012380.9406@goblin.wat.veritas.com>
References: <200511230413.jAN4DboR013036@shell0.pdx.osdl.net>
 <Pine.LNX.4.61.0511241235450.3504@goblin.wat.veritas.com>
 <20051124160012.GQ31287@waste.org> <20051124174622.GC18971@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2005 20:28:26.0381 (UTC) FILETIME=[9FA3F3D0:01C5F135]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Russell King wrote:
> On Thu, Nov 24, 2005 at 08:00:12AM -0800, Matt Mackall wrote:
> 
> It seems that ({0;}) is used when something is expected to return zero.
> However, if it is used in a void context, gcc 4 generates an annoying
> warning.

Annoying indeed.

> > mm.h:
> > #define shm_lock(a, b) empty_int()
> > 
> > The typechecking is nice in theory, but in practice I don't think it
> > really makes a difference for stubbing things out.

I'm with Matt on the typechecking here, and at first liked his proposal;
but then dreaded a long line of empty_int_0(), empty_long_minus1(), ...
I suppose we could pass the return value as argument, but I rather lose
interest...

> Depends if you end up with "blah is unused" warnings instead.  It's
> all round _far_ safer to use the inline function method from that
> point of view.
> 
> Not that I particularly care, I just wanted to squash some of the
> rediculous number of warnings in the kernel and decided to hit the
> easy ones.  However, they're turning out to be real pigs instead. 8(

I have nothing constructive suggest, and withdraw my objection to your
patch; though I do hope someone else comes up with a brilliant idea.
Or, does the next version of gcc decide it was all a wrong turning?

Hugh
