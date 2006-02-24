Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWBXMWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWBXMWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWBXMWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:22:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:38548 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932133AbWBXMWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:22:33 -0500
From: Andi Kleen <ak@suse.de>
To: Andres Salomon <dilinger@debian.org>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Date: Fri, 24 Feb 2006 13:22:27 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1140777679.5073.17.camel@localhost.localdomain> <200602241147.03041.ak@suse.de> <1140780552.5073.26.camel@localhost.localdomain>
In-Reply-To: <1140780552.5073.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241322.28389.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 12:29, Andres Salomon wrote:

> That would be nice.  Unfortunately, I'm trying to figure out why my dual
> opteron box likes to push the load up to 15 and then hang while doing
> i/o to the 3ware 9500S-8 card.  Looks like the load/d-state processes
> are caused by a whole lot (well, MAX_PDFLUSH_THREADS) of pdflush
> processes spinning on base->lock in lock_timer_base(); not sure if
> that's intentional or not, but it seems rather odd.  Whether the hanging
> is related to the high load remains to be seen.

Sounds like some timer handler is broken. You have to find out which
one it is.
 

> I don't see why this is a problem.  Other architectures have done this
> for ages, without problems.  I suspect most people get their backtraces
> from either serial console or logs, as copying them down from the screen
> or taking a picture of the panic is a rather large pain.  It seems like
> you're penalizing everyone for a few select use cases.

People submitting jpegs of photographed oopses or even badly scribbled
down oopses is quite common. Serial consoles are only used by a small
elite.

-Andi
