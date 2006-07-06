Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWGFTPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWGFTPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGFTPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:15:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750713AbWGFTPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:15:54 -0400
Date: Thu, 6 Jul 2006 12:15:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <44AD5357.4000100@rtr.ca>
Message-ID: <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu>  <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu>  <20060705131824.52fa20ec.akpm@osdl.org> 
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>  <20060705204727.GA16615@elte.hu>
  <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>  <20060705214502.GA27597@elte.hu>
  <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>  <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
  <20060706081639.GA24179@elte.hu>  <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Mark Lord wrote:
>
> I'm still browsing a copy here, but so far have only really found this:
> 
>  A volatile declaration may be used to describe an object corresponding
>  to a memory-mapped input/output port or an object accessed by an
>  aysnchronously interrupting function.  Actions on objects so declared
>  shall not be "optimized out" by an implementation or reordered except
>  as permitted by the rules for evaluating expressions.

Note that the "reordered" is totally pointless.

The _hardware_ will re-order accesses. Which is the whole point. 
"volatile" is basically never sufficient in itself.

So the definition of "volatile" literally made sense three or four decades 
ago. It's not sensible any more.

			Linus
