Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264870AbUEPXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbUEPXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 19:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbUEPXxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 19:53:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42968
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264870AbUEPXxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 19:53:12 -0400
Date: Mon, 17 May 2004 01:53:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, adi@bitmover.com,
       scole@lanl.gov, support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040516235310.GZ3044@dualathlon.random>
References: <200405132232.01484.elenstev@mesatop.com> <200405161519.03834.elenstev@mesatop.com> <20040516142916.7d07c9f3.akpm@osdl.org> <200405161611.17688.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405161611.17688.elenstev@mesatop.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 04:11:16PM -0600, Steven Cole wrote:
> On Sunday 16 May 2004 03:29 pm, Andrew Morton wrote:
> > Steven Cole <elenstev@mesatop.com> wrote:
> > >
> > > Anyway, although the regression for my particular machine for this
> > >  particular load may be interesting, the good news is that I've seen
> > >  none of the failures which started this whole thread, which are relatively
> > >  easily reproduceable with PREEMPT set.  
> > 
> > So...  would it be correct to say that with CONFIG_PREEMPT, ppp or its
> > underlying driver stack
> > 
> > a) screws up the connection and hangs and
> > 
> > b) scribbles on pagecache?
> > 
> > Because if so, the same will probably happen on SMP.
> > 
> Perhaps someone has the hardware to test this.
> 
> To summarize my experience with the past 24 hours of testing:
> Without PREEMPT , everything is rock solid. 

so we've two separate problems: the first is the ppp instability with
preempt, the second is a regresion in the vm heuristics between 2.6.3
and 2.6.5.

> and I (cringes at the thought) may repeat some bk pulls with
> PREEMPT set.

I've heard other reports of preempt being unstable with some sound
stuff, just in case are you using sound drivers at all during that
workload?
