Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWFFQDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWFFQDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWFFQDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:03:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751020AbWFFQDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:03:10 -0400
Date: Tue, 6 Jun 2006 09:02:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: 2.6.18 -mm merge plans
Message-Id: <20060606090258.004e6f5f.akpm@osdl.org>
In-Reply-To: <20060606145337.GC29798@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060606145337.GC29798@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 16:53:37 +0200
Ingo Molnar <mingo@elte.hu> wrote:

>
> [ lockdep ]
>
> So unless something unexpected happens in -mm, i'd like to see this 
> merged into 2.6.18 too.

Well, we _could_, and I guess that we'd get things acceptably sorted out in
time for release.  But it'll be pretty chaotic and we don't want chaos
happening in Linus's tree.


I don't think there's any rush here - the code is only now reaching
sort-of-ready-for-mm status.  And..

- I think we still have a problem with the raid/bdev changes in
  block_dev.c.

- the changes to block_dev.c _do_ impact non-lockdep kernels

- we need to take a second look to see which other
  dont-affect-non-lockdep-kernels patches are in fact affecting non-lockdep
  kernels

- the changes to block_dev.c were pretty awful anyway

- did the various review comments I sent get disposed of in some fashion?


My overarching concern is the rate at which false-positive workaround
patches are piling up.  At some point we need to step back and decide
whether the goodness justifies the badness.  I expect we'll be OK, but I
don't think we're yet in a position to know that for sure.


(I'm actually quite surprised at how few real bugs this checker has
revealed.  We must rock, or something).

