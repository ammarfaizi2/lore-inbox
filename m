Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVGHUeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVGHUeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVGHUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:33:39 -0400
Received: from unused.mind.net ([69.9.134.98]:8877 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262835AbVGHUbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:31:33 -0400
Date: Fri, 8 Jul 2005 13:30:37 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-17
In-Reply-To: <20050708094531.GA5515@elte.hu>
Message-ID: <Pine.LNX.4.58.0507081314420.30549@echo.lysdexia.org>
References: <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507070120100.22287@echo.lysdexia.org>
 <20050708092343.GA32586@elte.hu> <20050708092928.GA4135@elte.hu>
 <20050708094531.GA5515@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Ingo Molnar wrote:

> > > ok, you are right, the edge case was mishandled - but i think it was 
> > > already mishandled upstream, we just never (or rarely) triggered it.  
> > > I've reworked this area based on your patch, could you check -51-15, 
> > > does it work for you?

I figured it would take a little reworking, especially with your recent
MSI changes.  This was just a 'works for me' patch.  Your end_irq() is
cleaner, IMHO.

> > if it doesnt work, could you disable CONFIG_X86_IOAPIC_FAST?
> 
> or rather, please try -51-16. One of my testsystems produced weird 
> interrupt storms, which were caused by the IOAPIC_POSTFLUSH 
> optimization. In -51-16 i've turned that optimization off, globally.  
> Maybe this explains some of the other lockups reported.

OK.  Running -51-17 on the Athlon box.  CONFIG_X86_IOAPIC_FAST is still
enabled.  No lockups.  No jack xruns.  Max wakeup-latency is 27us (so far)  
on the debug config.  Nothing out of the ordinary logged except for the
new stack-footprint maximums during boot.

Any need to go back and check -51-16 as well?  Or -51-17 on a non-debug 
config?

--ww
