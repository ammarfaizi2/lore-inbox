Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbVJTGUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbVJTGUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbVJTGUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:20:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24248 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751769AbVJTGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:20:15 -0400
Date: Thu, 20 Oct 2005 02:19:41 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <1129734626.19559.275.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0510200216150.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Thomas Gleixner wrote:

> On Wed, 2005-10-19 at 10:59 -0400, Steven Rostedt wrote:
>
> The ktimer code itself calls the timeofday code, which provides the
> monotonic clock. I have no idea what might go wrong.
>
> Is this reproducible ?
>

Right now I'm compiling for the -rt kernel without my updates, to see if
it is reproducible there.  It is reproducible with my customizations.  One
thing that my kernel does is take the CPU from all other processes
(including tasklet threads) for long periods of time.  I'll see if I can
trigger this with the hackbench of highest priority on -rt, which does the
same thing.

-- Steve

