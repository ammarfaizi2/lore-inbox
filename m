Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWGHIvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWGHIvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 04:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWGHIvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 04:51:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750901AbWGHIvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 04:51:44 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AF6F89.8040806@argo.co.il>
References: <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
	 <44AF6F89.8040806@argo.co.il>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 10:51:36 +0200
Message-Id: <1152348696.3120.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 11:40 +0300, Avi Kivity wrote:
> Linus Torvalds wrote:
> > On Thu, 6 Jul 2006, Mark Lord wrote:
> >
> > >
> > > I'm still browsing a copy here, but so far have only really found this:
> > >
> > >  A volatile declaration may be used to describe an object corresponding
> > >  to a memory-mapped input/output port or an object accessed by an
> > >  aysnchronously interrupting function.  Actions on objects so declared
> > >  shall not be "optimized out" by an implementation or reordered except
> > >  as permitted by the rules for evaluating expressions.
> >
> > Note that the "reordered" is totally pointless.
> >
> > The _hardware_ will re-order accesses. Which is the whole point.
> > "volatile" is basically never sufficient in itself.
> >
> > So the definition of "volatile" literally made sense three or four 
> > decades
> > ago. It's not sensible any more.            
> >
> 
> It could be argued that gcc's implementation of volatile is wrong, and 
> that gcc should add the appropriate serializing instructions before and 
> after volatile accesses.
> 
> Of course, that would make volatile even more suboptimal, but at least 
> correct.

with PCI, and the PCI posting rules, there is no "one" serializing
instruction, you need to know the specifics of the device in question to
cause the flush. So at least there is no universal possible
implementation of volatile as you suggest ;-)


