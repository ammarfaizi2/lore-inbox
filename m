Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSGVOFZ>; Mon, 22 Jul 2002 10:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGVOFZ>; Mon, 22 Jul 2002 10:05:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23453 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317429AbSGVOFI>;
	Mon, 22 Jul 2002 10:05:08 -0400
Date: Mon, 22 Jul 2002 16:07:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <3D3C0FF8.1040301@evision.ag>
Message-ID: <Pine.LNX.4.44.0207221606000.9963-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Marcin Dalecki wrote:

> > i'm hesitant for a number of reasons. Eg. irq_save_off(flags) has to be a
> > macro, otherwise we move the assignment into the irqs-off section.  
> > Compare:
> > 
> > 	flags = irq_save_off();
> > 
> > with:
> > 	irq_flags_off(flags);
> > 
> > sure, it could be written as:
> > 
> > 	flags = irq_save();
> > 	irq_off();
> > 
> > but then again the macro form is more compact.
> 
> By 2 characters. [...]

and a full line ...

> [...] And hiding the side-effect. We don't have the notion of var
> argument passing like in pascal or C++ here.

well, it's a well-known side effect on the other hand.

	Ingo

