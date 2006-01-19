Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWASH3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWASH3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWASH3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:29:07 -0500
Received: from gold.veritas.com ([143.127.12.110]:10173 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1161081AbWASH3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:29:06 -0500
Date: Thu, 19 Jan 2006 07:29:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in exit_mmap->free_pgtables
In-Reply-To: <1137634961.626.2.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0601190717180.6003@goblin.wat.veritas.com>
References: <1135726300.22744.25.camel@mindpipe> 
 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
 <1137634961.626.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2006 07:29:06.0109 (UTC) FILETIME=[077AAED0:01C61CCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Lee Revell wrote:
> On Wed, 2005-12-28 at 22:59 +0000, Hugh Dickins wrote:
> > 
> > On my list to work on; but the TLB always needs great care, and this
> > goes down into architectural divergences, with truncation of a mapped
> > file adding further awkward constraints.  I imagine 2.6.16-rc1 is only
> > a couple of weeks away, so it's unlikely to be fixed in 2.6.16 either.
> 
> Is this believed to be fixed in 2.6.16-rc1?

Not at all, I'm afraid.  Do you think I ought to try to persuade Linus
and Andrew to take that ugly free_pgtables #ifdef CONFIG_PREEMPT patch
in the interim before we've the proper latency fix there?  (I doubt the
mmu_gather rewrite in 2.6.17 too, but perhaps a reasonable compromise.)

Hugh
