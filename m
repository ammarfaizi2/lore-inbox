Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUKPJVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUKPJVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUKPJVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:21:05 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:17838 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261951AbUKPJU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:20:59 -0500
Date: Tue, 16 Nov 2004 10:20:38 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __init and i386 timers
In-Reply-To: <1100545499.21267.29.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0411161019210.590@gockel.physik3.uni-rostock.de>
References: <20041113232203.GA23484@apps.cwi.nl> <1100545499.21267.29.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, john stultz wrote:

> On Sat, 2004-11-13 at 15:22, Andries Brouwer wrote:
> > The i386 timers use a struct timer_opts that has a field init
> > pointing at a __init function. The rest of the struct is not __init.
> > 
> > Nothing is wrong, but if we want to avoid having references to init stuff
> > in non-init sections, some reshuffling is needed.
> 
> Ugh. I understand the goal, but the resulting code indirection turns my
> stomach a bit. 
> 
> Although do take my criticism lightly, as right off I don't have a
> better suggestion other then to just yank the __init attribute from the
> initialization functions. I'm just not sure the savings is worth the
> added staple-gunned complexity. Might there be a better way?

I'd second. We already have too much complexity in the time related code.

Tim
