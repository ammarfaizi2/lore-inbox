Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVJTQJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVJTQJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVJTQJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:09:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58500 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932373AbVJTQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:09:57 -0400
Date: Thu, 20 Oct 2005 12:09:42 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <20051020155525.GA10360@elte.hu>
Message-ID: <Pine.LNX.4.58.0510201208460.30996@localhost.localdomain>
References: <1129747172.27168.149.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu>
 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu>
 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain> <20051020085955.GB2903@elte.hu>
 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain> <20051020155525.GA10360@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Ingo Molnar wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > I just switched cycle_t to u64 and hackbench no longer makes the time go
> > > backwards.
> > >
> > > John, would this cause any problems to keep cycle_t at s64?
> >
> > I mean at u64.
>
> ugh. There's both cycles_t and cycle_t. We should unify the two and it
> should be 64-bit. The faster systems get, the sooner the 32-bit counter
> overflows. 64-bit systems are keeping 32-bit compatibility for quite
> some time to come. So with an 8GHz CPU the 32-bit cycle_t would wrap in
> like 500 msecs, way too fast to rely on ... (even with a 4GHz CPUs it's
> only one second.)
>
> i've made cycle_t u64 and have uploaded -rt14.
>

Ingo,

I'm disappointed in you, I expected you to upload 2.6.14-rc5-rt1

;-)

-- Steve

