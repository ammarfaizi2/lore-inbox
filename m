Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272977AbTHEVXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272978AbTHEVXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:23:04 -0400
Received: from hockin.org ([66.35.79.110]:43527 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S272977AbTHEVXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:23:00 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200308052105.h75L5iN22702@www.hockin.org>
Subject: Re: [PATCH] Export touch_nmi_watchdog
To: torvalds@osdl.org (Linus Torvalds)
Date: Tue, 5 Aug 2003 14:05:44 -0700 (PDT)
Cc: arjanv@redhat.com (Arjan van de Ven), ak@colin2.muc.de (Andi Kleen),
       akpm@osdl.org (Andrew Morton), ak@muc.de (Andi Kleen),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0308051402300.2835-100000@home.osdl.org> from "Linus Torvalds" at Aug 05, 2003 02:07:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  - either fix the driver
> > > or
> > >  - disable the watchdog entirely.
> > 
> > In principle you are soooo right. Just that it sometimes is HARD to fix
> > such long delays...
> 
> That's why I said "disable the watchdog".

> But since the whole _point_ of watchdogging is to find places like this, 
> when you paper over _these_ symptoms, you end up killing the whole idea.
> 
> Which is why I'd suggest making it a more conscious decision: just turn
> off watchdog support. And if somebody needs watchdog support with a broken 
> driver, maybe, just _maybe_, he'll find the energy to fix the frigging 
> thing.

We had the same situation a while back (2.2.x, early 2.4.x era) with systems
that had (have, they still exist) a 1 second WD tied to the hard RESET line.
1 second with interrupts off == reboot.  Let me tell you, we found a LOT of
places where there were problems.  Network drivers, routing stuff, SCSI,
etc.  We fixed some, and hacked around some in this same manner.

Now, if I have a chance to port Cobalt crap to 2.6, we'll see how many of
our changes were merged, in concept or in code.

Tim
