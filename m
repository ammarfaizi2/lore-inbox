Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVASFXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVASFXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVASFXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:23:04 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:40915 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261588AbVASFWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:22:41 -0500
Date: Tue, 18 Jan 2005 21:21:19 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119052118.GA19591@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119050701.GA19542@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [050118 21:08]:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 20:22]:
> >
> > BTW. Is it possible, when entering the "idle" loop, to quickly know an
> > estimate of when the next tick shoud actually kick in ?
> 
> Yes, see next_timer_interrupt() for that.

Hmmm, or maybe you mean _quick_estimate_ instead of 
next_timer_interrupt()?

I don't think there's any faster way to estimate the skippable ticks
without going through the list like next_timer_interrupt already does.
Does anybody have any ideas for that?

Tony
