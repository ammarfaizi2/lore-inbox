Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWGHIkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWGHIkt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGHIkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 04:40:49 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:9476 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750751AbWGHIks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 04:40:48 -0400
Message-ID: <44AF6F89.8040806@argo.co.il>
Date: Sat, 08 Jul 2006 11:40:41 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mark Lord <lkml@rtr.ca>, Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jul 2006 08:40:47.0104 (UTC) FILETIME=[354BF000:01C6A26A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 6 Jul 2006, Mark Lord wrote:
>
> >
> > I'm still browsing a copy here, but so far have only really found this:
> >
> >  A volatile declaration may be used to describe an object corresponding
> >  to a memory-mapped input/output port or an object accessed by an
> >  aysnchronously interrupting function.  Actions on objects so declared
> >  shall not be "optimized out" by an implementation or reordered except
> >  as permitted by the rules for evaluating expressions.
>
> Note that the "reordered" is totally pointless.
>
> The _hardware_ will re-order accesses. Which is the whole point.
> "volatile" is basically never sufficient in itself.
>
> So the definition of "volatile" literally made sense three or four 
> decades
> ago. It's not sensible any more.            
>

It could be argued that gcc's implementation of volatile is wrong, and 
that gcc should add the appropriate serializing instructions before and 
after volatile accesses.

Of course, that would make volatile even more suboptimal, but at least 
correct.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

