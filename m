Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWASUCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWASUCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWASUCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:02:33 -0500
Received: from mail.suse.de ([195.135.220.2]:53948 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030300AbWASUCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:02:32 -0500
Date: Thu, 19 Jan 2006 21:02:26 +0100
From: Nick Piggin <npiggin@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       David Miller <davem@davemloft.net>
Subject: Re: [patch 3/3] mm: PageActive no testset
Message-ID: <20060119200226.GA1756@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <20060118024139.10241.73020.sendpatchset@linux.site> <20060118141346.GB7048@dmt.cnet> <20060119145008.GA20126@wotan.suse.de> <20060119165222.GC4418@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119165222.GC4418@dmt.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 02:52:22PM -0200, Marcelo Tosatti wrote:
> On Thu, Jan 19, 2006 at 03:50:08PM +0100, Nick Piggin wrote:
> 
> > The test-set / test-clear operations also kind of imply that it is
> > being used for locking or without other synchronisation (usually).
> 
> Non-atomic versions such as __ClearPageLRU()/__ClearPageActive() are 
> not usable, though.
> 

Correct. Although I was able to use them in a couple of other places
in a subsequent patch in the series. I trust you don't see a problem
with those usages?

Thanks,
Nick

