Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbVJTGkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbVJTGkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbVJTGkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:40:10 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:18868 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751773AbVJTGkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:40:09 -0400
Date: Thu, 20 Oct 2005 02:39:55 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Daniel Walker <dwalker@mvista.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.64.0510190816380.30406@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.58.0510200238390.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <Pine.LNX.4.64.0510190816380.30406@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Oct 2005, Daniel Walker wrote:

> On Wed, 19 Oct 2005, Steven Rostedt wrote:
>
> >
> > Hi Thomas,
> >
> > I switched my custom kernel timer to use the ktimers with the prio of -1
> > as you mentioned to me offline.  I set up the timer to be monotonic and
> > have a requirement that the returned time is always greater or equal to
> > the last time returned from do_get_ktime_mono.
> >
> > Now here's the results that I got between two calls of do_get_ktime_mono
> >
> > 358.069795728 secs then later 355.981483177.  Should this ever happen?
>
> Are you running NTP ?
>

Yes, but that shouldn't make a difference.  NTP can slow down or speed up
the clock, but it should never make it go backwards. Especially for a
monotonic clock (as the name suggests).

-- Steve

