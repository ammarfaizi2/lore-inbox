Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVASJqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVASJqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVASJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:46:06 -0500
Received: from gprs215-241.eurotel.cz ([160.218.215.241]:38328 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261624AbVASJpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:45:53 -0500
Date: Wed, 19 Jan 2005 10:45:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119094526.GC25623@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com> <20050119052118.GA19591@atomide.com> <1106113466.4533.178.camel@gaston> <20050119062606.GA26932@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119062606.GA26932@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, that's fine, we already have to call it before entering the PM
> > state, so I'll just pass it along and, at the low level, decide how
> > deep to sleep based on that.
> > 
> > I think I should also add some stats on the amount of interrupts, since
> > it would be fairly inefficient to keep entering deep PM state on a
> > machine with typically little timer interrupts but high HW interrupt
> > (Rusty mentions case of packet forwarding routers or that kind of thing)
> 
> Maybe some HW timer interrupt mask could be used? Also it would be
> nice to check for file IO.

Well, you could mask those interrupts, but it would ruin your
packet-forwarding performance, so you probably do not want to do
that...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
