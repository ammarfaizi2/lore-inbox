Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTETIqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 04:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTETIqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 04:46:15 -0400
Received: from dp.samba.org ([66.70.73.150]:52910 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263638AbTETIqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 04:46:11 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>, mingo@elte.hu,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Tue, 20 May 2003 07:56:27 +0100."
             <20030520075627.A28002@infradead.org> 
Date: Tue, 20 May 2003 18:57:39 +1000
Message-Id: <20030520085911.90EE72C232@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030520075627.A28002@infradead.org> you write:
> On Tue, May 20, 2003 at 08:27:03AM +0200, Ingo Molnar wrote:
> > yes, but the damage has been done already, and now we've got to start the
> > slow wait for the old syscall to flush out of our tree.
> 
> Actually it should go away before 2.6.0.  sys_futex never was part of a
> released stable kernel so having the old_ version around is silly.

Hmm, in that case I'd say "just break it", and I'd be all in favour of
demuxing the syscall.

But I think vendors have backported and released futexes, which is why
Ingo did this...

(Although you might be right about "by the time 2.6 is out" 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
