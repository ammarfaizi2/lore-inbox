Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSGVNsz>; Mon, 22 Jul 2002 09:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSGVNs3>; Mon, 22 Jul 2002 09:48:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57567 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317309AbSGVNrA>;
	Mon, 22 Jul 2002 09:47:00 -0400
Date: Mon, 22 Jul 2002 15:49:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722144626.D2838@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221546320.9136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Russell King wrote:

> > i'm not so sure about flags_t. 'unsigned long' worked pretty well so far,
> > and i do not see the need for a more complex (or more opaque) irqflags
> > type.
> 
> A feature request then.  Type checking.  Too many people try to stuff
> the value into an int or signed long.

the next portion of the quote deals with this:

> > It's not that we confuse flags with some other flag all that
> > frequently that would necessiate some structure-based more abstract
> > protection of these variables.

are you sure type-checking is really needed? Sure people can mess up the
flags variable, but 64-bit archs could do a sizeof at compile-time.

	Ingo

