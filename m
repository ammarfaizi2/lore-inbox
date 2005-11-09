Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVKICSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVKICSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKICSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:18:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:61597 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965156AbVKICSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:18:10 -0500
Subject: Re: Posssible bug in kernel/irq/handle.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511081802160.3247@g5.osdl.org>
References: <1131496739.24637.12.camel@gaston>
	 <Pine.LNX.4.64.0511081651320.3247@g5.osdl.org>
	 <1131501021.24637.18.camel@gaston>
	 <Pine.LNX.4.64.0511081802160.3247@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 13:16:54 +1100
Message-Id: <1131502615.24637.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Be vewy vewy caweful when changing that code, though. If you end up with a 
> patch, please try to give it some nice stress-testing (both on ppc and 
> x86), and then post it for comments, ok? Maybe the arch mailing list and 
> Ingo (who else has touched that logic?)

Ok, I'll try to avoid touching that code. In a perfect world, we should
have proper handlers for those firmware interrupts anyway, it's just
that the "spec" says we should call the firmware for any interrupt we
don't handle...

I suppose it should be enough for us to test for desc->action before
calling __do_IRQ() and eventually do the firmware trick then, since I
doubt that if it matters at all, it will happen on shared interrupts...

Ben.


