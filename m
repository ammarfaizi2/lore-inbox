Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUIOUnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUIOUnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIOUlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:41:24 -0400
Received: from holomorphy.com ([207.189.100.168]:58014 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267413AbUIOUko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:40:44 -0400
Date: Wed, 15 Sep 2004 13:40:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Robert Love <rml@ximian.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915204019.GW9106@holomorphy.com>
References: <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192104.GB9106@holomorphy.com> <1095189593.16988.72.camel@localhost.localdomain> <1095207749.2406.36.camel@krustophenia.net> <20040915014610.GG9106@holomorphy.com> <1095213644.2406.90.camel@krustophenia.net> <20040915023611.GH9106@holomorphy.com> <41484558.6060301@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41484558.6060301@namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 06:36:24AM -0700, Hans Reiser wrote:
> Why bother?  It is V3, it should be left undisturbed except for 
> bugfixes.  Please, spend your efforts on reducing V4 latency and 
> measuring whether it fails to scale to multiple processors.  That would 
> be very useful to me if someone helped with that.  V4 has the 
> architecture for doing such things well, but there are always accidental 
> bottlenecks that testing can discover, and I am sure we will have a 
> handful of things preventing us from scaling well that are not hard to 
> fix.  It would be nice to fix those......
> The hard stuff for scalability, the locking of the tree, we did that.  
> We just haven't tested and evaluated and refined like we need to in V4.

It's not for scalability; it's for cleaning up the users, which are
universally buggy. My suggestion above would not, in fact, make reiser3
any more scalable; it would merely isolate the locking semantics it
couldn't live without into its own internals.


-- wli
