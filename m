Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVANKrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVANKrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVANKrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:47:41 -0500
Received: from colin2.muc.de ([193.149.48.15]:36103 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261948AbVANKre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:47:34 -0500
Date: 14 Jan 2005 11:47:32 +0100
Date: Fri, 14 Jan 2005 11:47:32 +0100
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: clameter@sgi.com, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview II
Message-ID: <20050114104732.GB72915@muc.de>
References: <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com> <20050114043944.GB41559@muc.de> <m14qhkr4sd.fsf_-_@muc.de> <1105678742.5402.109.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105678742.5402.109.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a question for the x86 gurus. We're currently using the lock
> prefix for set_64bit. This will lock the bus for the RMW cycle, but
> is it a prerequisite for the atomic 64-bit store? Even on UP?

An atomic 64bit store doesn't need a lock prefix. A cmpxchg will
need to though. Note that UP kernels define LOCK to nothing.

-Andi
