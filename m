Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVJTQBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJTQBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJTQBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:01:32 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:32899 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932314AbVJTQBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:01:31 -0400
Date: Thu, 20 Oct 2005 12:01:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510201109170.30996@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510201159000.30996@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.58.0510201031270.30996@localhost.localdomain>
 <Pine.LNX.4.58.0510201109170.30996@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2005, Steven Rostedt wrote:

>
> On Thu, 20 Oct 2005, Steven Rostedt wrote:
> >
> > FYI, I just merged my changes with -rt13 and everything seems to be
> > working very smoothly.  I've been running my kernel over an hour without
> > showing the backward times. I haven't even added the change from cycle_t
> > to be 64 bits.
> >
> >
> > So, knock on wood, maybe one of the latest updates fixed the problem. Or
> > maybe as soon as I hit send, the machine will crash.
> >
> > I'll keep you all posted.
> >
>
> Spoke too soon ;-)
>
> About ten minutes after sending this, the clock went backwards, and once
> again by 2 seconds.
>
> now=5856:283756196 last_count=5858:436968526
>
> Where now is 5856.283756196 seconds and last count is 5858.436968526.
>

Pádraig sent me an email showing that this time difference is what it
would take a 2GHz machine to overflow a 32 bit number.  I'll go and switch
the cycle_t to 64 bits and see if this solves the problem.

-- Steve


