Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSGVO0q>; Mon, 22 Jul 2002 10:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSGVO0p>; Mon, 22 Jul 2002 10:26:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38047 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317433AbSGVO0l>;
	Mon, 22 Jul 2002 10:26:41 -0400
Date: Mon, 22 Jul 2002 16:28:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: martin@dalecki.de, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722152750.G2838@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221627200.10733-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Russell King wrote:

> If "other means" means knowing that its located in a certain place on
> the stack, that's actually bogus.  Any user space task started via exec
> from a kernel thread has extra junk on the kernel stack.  Been there
> already. ;(

no, i've added it to the irq descriptor structure, where it can be
accessed in normal ways by the driver. [the stack position thing doesnt
fly with vm86 tasks either.]

	Ingo

