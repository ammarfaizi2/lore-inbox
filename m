Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264756AbUFGPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbUFGPLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUFGPLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:11:02 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9193 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264756AbUFGPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:09:22 -0400
Date: Mon, 7 Jun 2004 08:09:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (urgent) ppc32: Fix CPUs with soft loaded TLB
Message-ID: <20040607150921.GV15195@smtp.west.cox.net>
References: <1086556255.1859.14.camel@gaston> <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org> <1086558161.10538.24.camel@gaston> <40C4186C.8000700@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C4186C.8000700@intracom.gr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 10:25:32AM +0300, Pantelis Antoniou wrote:

> Benjamin Herrenschmidt wrote:
> 
> >On Sun, 2004-06-06 at 16:20, Linus Torvalds wrote:
> >
> >>On Sun, 6 Jun 2004, Benjamin Herrenschmidt wrote:
> >>
> >>>The recent introduction of ptep_set_access_flags() with the optimisation
> >>>of not flushing the TLB unfortunately broke ppc32 CPUs with no hash 
> >>>table.
> >>>
> >>Makes sense, applied.
> >>
> >
> >ARGH. Missed one file. Here is an additional patch (missed tlbflush.h 
> >patch)
> >
> >Sorry.
> >
> >This adds the definiction of flush_tlb_page_nohash() that was missing
> >from the previous patch fixing SW-TLB loaded PPCs
> >
> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[snip]
> Hi
> 
> Unfortunately this is not enough for me on 8xx.
[snip]
> In order to fix this I now have to remove update_mmu_cache  by defining 
> it empty.
> 
> Please see the following patch.

But this now matches the way things are on 2.4, so is it really a
problem?

-- 
Tom Rini
http://gate.crashing.org/~trini/
