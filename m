Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUEMS2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUEMS2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUEMS2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:28:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:44701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264379AbUEMS2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:28:48 -0400
Date: Thu, 13 May 2004 11:28:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.6-mm2
Message-Id: <20040513112816.1e2e2eaa.akpm@osdl.org>
In-Reply-To: <40A36C94.EB004C37@tv-sign.ru>
References: <40A36C94.EB004C37@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Hello.
> 
> Andrew Morton wrote:
> >
> > +yield_irq.patch
> >
> > From: Nick Piggin
> >
> > this_rq_lock does a local_irq_disable, and sched_yield()
> > needs to undo that.
> 
> I beleive it is safe to enter schedule() with interrupts
> disabled. schedule() does spin_lock_irq()->local_irq_disable()
> anyway.

True.

> Could you please explain, why it is needed?
> 

It was triggering false positives during debugging of the x86_64 gcc-3.3.3
problem and it's just a tidiness thing, really.
