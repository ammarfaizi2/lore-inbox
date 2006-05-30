Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWE3BgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWE3BgH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWE3BbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932100AbWE3BaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:30:20 -0400
Date: Mon, 29 May 2006 18:34:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 21/61] lock validator: lockdep: add
 local_irq_enable_in_hardirq() API.
Message-Id: <20060529183428.0d12052e.akpm@osdl.org>
In-Reply-To: <20060529212452.GU3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212452.GU3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:52 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> introduce local_irq_enable_in_hardirq() API. It is currently
> aliased to local_irq_enable(), hence has no functional effects.
> 
> This API will be used by lockdep, but even without lockdep
> this will better document places in the kernel where a hardirq
> context enables hardirqs.

If we expect people to use this then we'd best whack a comment over it.

Also, trace_irqflags.h doesn't seem an appropriate place for it to live.

I trust all the affected files are including trace_irqflags.h by some
means.  Hopefully a _reliable_ means.  No doubt I'm about to find out ;)
