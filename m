Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUIIXRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUIIXRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIIXRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:17:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:18382 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265971AbUIIXRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:17:03 -0400
Date: Thu, 9 Sep 2004 16:20:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-Id: <20040909162048.602ef511.akpm@osdl.org>
In-Reply-To: <20040909214113.GB5723@logos.cnet>
References: <20040909163929.GA4484@logos.cnet>
	<20040909154906.57f9391b.akpm@osdl.org>
	<20040909214113.GB5723@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > I think the patch make sense, but I'm very sceptical about the benchmarks
> > ;)
> 
> Why's that? You think changing to the number of pages in the pagevec to "15" instead
> "16" is the cause?

Nope.  I wouldn't have expected to see a significant (or even measurable)
change in performance as a result of this patch.

After all, these structures are always stack-allocated, and top-of-stack is
most always in L1 cache.

I'd suspect that benchmark variability is the cause here.
