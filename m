Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUJNXnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUJNXnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUJNXjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:39:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20129 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267807AbUJNXgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:36:17 -0400
Date: Thu, 14 Oct 2004 18:47:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: per-process shared information
Message-ID: <20041014214711.GF6899@logos.cnet>
References: <20041013231042.GQ17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013231042.GQ17849@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrea!

No useful comments on the statm reporting issue.

> Ps. if somebody like Hugh volunteers implementing it, you're very
> welcome, just let me know (I'll eventually want to work on the oom
> handling too, which is pretty screwed right now, 

Yes, we've got reports of bad OOM killing behaviour (is that what you're
talking about?) 

One thing is the removal of "if (nr_swap_pages > 0) goto out" from oom_kill() 
causes problems (spurious oom kill). 

We need to throttle more, on page reclaiming progress I think.

Take a look at 

http://marc.theaimsgroup.com/?l=linux-mm&m=109587921204602&w=2

What else you're seeing?

> I've plenty of bugs
> open on that area and the lowmem zone protection needs a rewrite too to
> be set to a sane default value no matter the pages_lows etc..).

Nick has been working on that lately I think. What is the problem?



