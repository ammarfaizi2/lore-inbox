Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVBXVtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVBXVtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVBXVtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:49:36 -0500
Received: from mail.tmr.com ([216.238.38.203]:24072 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262507AbVBXVsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:48:53 -0500
Date: Thu, 24 Feb 2005 16:37:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Folkert van Heusden <folkert@vanheusden.com>
cc: Rog?rio Brito <rbrito@ime.usp.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
In-Reply-To: <20050224164407.GC5138@vanheusden.com>
Message-ID: <Pine.LNX.3.96.1050224163358.16192A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Folkert van Heusden wrote:

> > >>My linux laptop says:
> > >>irq 5: nobody cared!
> > >(...)
> > >>Does anyone care? :-)
> > >Well, I'm getting similar stack traces with my system and those are sure
> > >scary, but it seems that my e-mails to the list are simply ignored,
> > >unfortunately.
> > I posted a similar thing, but the problem is not that you get the 
> > message. It means your hardware generated an unexpected interrupt. The 
> > kernel is reporting that fact as it should.
> > The problem I had (not resolved) is that after the message
> >   DISABLING IRQ NN
> > I continued to get interrupts! So the logic to disable the IRQ is not 
> > working correctly.
> 
> In my case, the interrupt should NOT be disabled as my WIFI-interface is
> behind it (via ndiswrappers).

Well, that's debatable. The warnings mean that either the WiFi driver
isn't catching them as it should, or that something else is generating the
same (shared) IRQ.

But what bothers me is that the kernel is trying to disable the IRQ and
not doing it. I think that's an issue, since on my hardware that meant the
system did nothing but write wrror messages to the log.

> 
> > as you note, because the hardware is generating the condition, no one 
> > seems to care, even though there clearly is a problem in the disable 
> > logic. I found a way to fix my hardware thanks to some pointers I got, 
> > so I'm running, but I haven't heard that the base problem is fixed.
> 
> Aight.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

