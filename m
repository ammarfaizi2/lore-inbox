Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbTCYD3b>; Mon, 24 Mar 2003 22:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbTCYD3b>; Mon, 24 Mar 2003 22:29:31 -0500
Received: from dp.samba.org ([66.70.73.150]:43748 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261406AbTCYD31>;
	Mon, 24 Mar 2003 22:29:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <linux@brodo.de>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] pcmcia (2/5): add bus_type pcmcia_bus_type 
In-reply-to: Your message of "Sat, 22 Mar 2003 20:33:06 -0800."
             <Pine.LNX.4.44.0303222030360.5588-100000@home.transmeta.com> 
Date: Tue, 25 Mar 2003 14:39:06 +1100
Message-Id: <20030325034037.0A4C02C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0303222030360.5588-100000@home.transmeta.com> you wri
te:
> 
> On Sat, 22 Mar 2003, Dominik Brodowski wrote:
> >
> > Register a bus_type pcmcia_bus_type. This means the initialization of
> > the ds module needs to be done in two levels: one quite early
> > (subsys_initcall) so that drivers may use the bus_type; the other one
> > must stay that late (late_initcall). As only one initcall can be
> > specified within one module, some tweaking is needed.
> 
> Hmm.. We should fix the module interface instead. 
> 
> I've applied this patch, but there's no reall reason why modules 
> shouldn't be able to have multiple initcalls.

Sure, it's been asked for before (dwmw2 IIRC).

We need a new interface though, like:

	init_and_cleanup(init1, cleanup1);

Because you have to unroll them when one fails.

But of course, you thought of that before you asked, right?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
