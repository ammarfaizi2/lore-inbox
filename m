Return-Path: <linux-kernel-owner+w=401wt.eu-S1751586AbXALEqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbXALEqn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbXALEqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:46:43 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60372 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbXALEqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:46:42 -0500
Date: Thu, 11 Jan 2007 20:46:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <45A70EF9.40408@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> 
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> 
 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com> 
 <20070110220603.f3685385.akpm@osdl.org>  <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
  <20070110225720.7a46e702.akpm@osdl.org>  <45A5E1B2.2050908@yahoo.com.au>
 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
 <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com> <45A70EF9.40408@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2007, Nick Piggin wrote:
>
> We are talking about about fragmentation. And limiting pagecache to try to
> avoid fragmentation is a bandaid, especially when the problem can be solved
> (not just papered over, but solved) in userspace.

It's not clear that the problem _can_ be solved in user space.

It's easy enough to say "never allocate more than a page". But it's often 
not REALISTIC.

Very basic issue: the perfect is the enemy of the good. Claiming that 
there is a "proper solution" is usually a total red herring. Quite often 
there isn't, and the "paper over" is actually not papering over, it's 
quite possibly the best solution there is.

		Linus
