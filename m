Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267871AbUHFW3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267871AbUHFW3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUHFW3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:29:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:52412 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267871AbUHFW3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:29:04 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@linuxmail.org, David Brownell <david-b@pacbell.net>,
       Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040806212909.GI30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
	 <1091592870.5226.80.camel@gaston>  <20040806212909.GI30518@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091831227.9271.254.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 07 Aug 2004 08:27:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Very easy... with the current code, just use state 4 for the round
> > of suspend callbacks, ide-disk will then avoid spinning down.
> 
> There are some network drivers that test for "4" and fails suspend
> with something like "invalid suspend state" :-(.

Easily fixed. Again, i'm not afraid of fixing driver, few enough of
them care at all at this point. I'll send some patches this week-end
to patrick for his bk tree adding the basic ppc support and renumbering
the PM callbacks, I havne't changed the type yet though, that's a more
tedious work and I'm a lazy guy ;)

I have taken care of various fbdev's too, though for some like atyfb,
I'm blocked until the new rewritten version gets upstream. I'm trying
to get it to -mm at least, news soon on this front.

I'll do other drivers asap.

Ben.

