Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVLMDYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVLMDYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVLMDYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:24:40 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:36513 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932402AbVLMDYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:24:39 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, matthew@wil.cx,
       arjan@infradead.org, hch@infradead.org, akpm@osdl.org,
       torvalds@osdl.org, David Howells <dhowells@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134435458.22269.11.camel@localhost.localdomain>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <1134435458.22269.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 22:23:48 -0500
Message-Id: <1134444228.24145.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 16:57 -0800, Daniel Walker wrote:
> On Mon, 2005-12-12 at 23:45 +0000, David Howells wrote:
> 
> >  (1) Provides a simple xchg() based semaphore as a default for all
> >      architectures that don't wish to override it and provide their own.
> > 
> >      Overriding is possible by setting CONFIG_ARCH_IMPLEMENTS_MUTEX and
> >      supplying asm/mutex.h
> > 
> >      Partial overriding is possible by #defining mutex_grab(), mutex_release()
> >      and is_mutex_locked() to perform the appropriate optimised functions.
> 
> Your code is really similar to the RT mutex, which does everything that
> your mutex does at least ? Assuming you've reviewed the RT mutex, why
> would we want to use yours over it?

Maybe this would be the better !PREEMPT_RT version.  But the true mutex
that Ingo is making would be used for the PREEMPT_RT side.

This code at least brings down the over head of semaphores where they
are not really needed.  Looking at the code slightly (I must admit, I
spent maybe 30 seconds looking at it), it does seem a little similar to
Ingo's.  Could just be coincidence, since the methods are pretty much
what multiple people would come up with.  But you both work for RedHat,
hmm.

-- Steve


