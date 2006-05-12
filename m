Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWELOn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWELOn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWELOn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:43:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:62946 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932105AbWELOnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:43:25 -0400
Date: Fri, 12 May 2006 16:43:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, markh@compro.net,
       LKML <linux-kernel@vger.kernel.org>, dwalker@mvista.com,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
Message-ID: <20060512144305.GA4683@elte.hu>
References: <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com> <20060512092159.GC18145@elte.hu> <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com> <20060512071645.6b59e0a2.akpm@osdl.org> <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com> <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Use this patch instead.  It needs an irq disable.  But, believe it or 
> not, on SMP this is actually better.  If the irq is shared (as it is 
> in Mark's case), we don't stop the irq of other devices from being 
> handled on another CPU (unfortunately for Mark, he pinned all 
> interrupts to one CPU).
> 
> Andrew,
> 
> should this be changed in mainline too?
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

yeah, would be nice to have this upstream too. It's not urgent so can go 
post-2.6.17. I've added it to the -rt tree.

	Ingo
