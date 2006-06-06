Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWFFKuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWFFKuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWFFKuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:50:54 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22222 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750815AbWFFKuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:50:54 -0400
Subject: Re: [PATCH -mm] misroute-irq: Don't call desc->chip->end because
	of edge interrupts
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060606080156.GA427@elte.hu>
References: <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
	 <1149438131.29652.5.camel@localhost.localdomain>
	 <1149456375.23209.13.camel@localhost.localdomain>
	 <1149456532.29652.29.camel@localhost.localdomain>
	 <20060604214448.GA6602@elte.hu>
	 <1149564830.16247.11.camel@localhost.localdomain>
	 <20060606080156.GA427@elte.hu>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 06:50:19 -0400
Message-Id: <1149591019.16247.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 10:01 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hit the following BUG with irqpoll.  The below patch fixes it.
> 
> > -		if (work)
> > +		if (work && disc->chip && desc->chip->end)
> >  			desc->chip->end(i);
> 
> typo - plus shouldnt this call ->eoi() as well if available?
> 

I saw Andrews replay and said, WTF I already fixed that. But then
noticed that it wasn't refreshed.

As for eio, could be.  This was part of my whole misroute thing which I
didn't have time to get to deep in.  I'm leaving today, where I won't
have any computers or Internet til next Wednesday or Thursday, so I'm
not going to be able to work on this further till then.

-- Steve

