Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVBZBRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVBZBRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVBZBOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:14:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:49613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261174AbVBZBNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 20:13:34 -0500
Date: Fri, 25 Feb 2005 17:13:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Darren Hart <dvhltc@us.ibm.com>,
       hugh@veritas.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
Message-ID: <20050226011319.GE15867@shell0.pdx.osdl.net>
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net> <20050225220543.GC15867@shell0.pdx.osdl.net> <421FA61B.9050705@us.ibm.com> <20050225233806.GD15867@shell0.pdx.osdl.net> <20050226005620.GN20715@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226005620.GN20715@opteron.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> The object of the merge is to save memory, and to reduce the size of the
> rbtree that might payoff during other operations (with a smaller tree,
> lookups will be faster too). If you only measure the time of creating
> and removing a mapping then it should be normal that you see a slowdown
> since merging involves more work than non-merging. The payoff is
> supposed to be in the other operations.

I agree, that test is pathological worst case.

> The reason mlock doesn't merge is that nobody asked for it yet, but it
> was originally supposed to merge too (I stopped at mremap since mlock
> wasn't high prio to fixup). But the long term plan was to eventually add
> merging to mlock too and it's good that you're optimizing it now.

Do you support merging this patch?  Or did you mean further optimizations?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
