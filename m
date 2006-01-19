Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWASRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWASRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWASRi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:38:26 -0500
Received: from ns.suse.de ([195.135.220.2]:37031 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161044AbWASRiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:38:25 -0500
Date: Thu, 19 Jan 2006 18:38:15 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, David Miller <davem@davemloft.net>
Subject: Re: [patch 0/4] mm: de-skew page refcount
Message-ID: <20060119173815.GA6564@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org> <20060118170558.GE28418@wotan.suse.de> <Pine.LNX.4.64.0601181122120.3240@g5.osdl.org> <20060119140039.GA958@wotan.suse.de> <Pine.LNX.4.64.0601190756390.3240@g5.osdl.org> <20060119170656.GA9904@wotan.suse.de> <Pine.LNX.4.64.0601190917271.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601190917271.3240@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 09:27:14AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 19 Jan 2006, Nick Piggin wrote:
> > 
> > Hmm... this is what the de-skew patch _did_ (although it was wrapped
> > in a function called get_page_unless_zero), in fact the main aim was
> > to prevent this twiddling and the de-skewing was just a nice side effect
> > (I guess the patch title is misleading).
> > 
> > So I'm confused...
> 
> The thing I minded was the _other_ changes, namely the de-skewing itself. 
> It seemed totally unnecessary to what you claimed was the point of the 
> patch.
> 
> So I objected to the patch on the grounds that it did what you claimed 
> badly. All the _optimization_ was totally independent of that de-skewing, 
> and the de-skewing was a potential un-optimization.
> 

No longer confused...

> But if you do the optimizations as one independent set of patches, and 
> _then_ do the counter thing as a "simplify logic" patch, I don't see that 
> as a problem.
> 
> Side note: I may be crazy, but for me when merging, one of the biggest 
> things is "does this pass my 'makes sense' detector". I look less at the 
> end result, than I actually look at the _change_. See?
> 
> That's why two separate patches that do the same thing as one combined 
> patch may make sense, even if the _combined_ one does not (it could go the 
> other way too, obviously).
> 

I agree, and the patches really are cleaner this way too, so again,
thanks for the input on them.

I'll resend soonish (with a trimmed cc list).

Nick
