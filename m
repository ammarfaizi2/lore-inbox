Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSGVNZK>; Mon, 22 Jul 2002 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGVNZK>; Mon, 22 Jul 2002 09:25:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26521 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316430AbSGVNZJ>;
	Mon, 22 Jul 2002 09:25:09 -0400
Date: Mon, 22 Jul 2002 15:26:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722152645.A18695@lst.de>
Message-ID: <Pine.LNX.4.44.0207221526380.8286-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> > i agree mostly, but i do not agree with __irq_save() and irq_save().  
> > What's wrong with "flags_t irq_save_off()" - the name carries the proper
> > meaning, and it also harmonizes with irq_off().
> 
> but not with irq_restore :)  maybe irq_restore_on() although the on
> is implicit.

no, the on is not implicit at all. If you restore into a disabled state
then it will go from on to off.

	Ingo

