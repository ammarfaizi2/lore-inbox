Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWJGBxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWJGBxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 21:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWJGBxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 21:53:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422845AbWJGBxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 21:53:47 -0400
Date: Fri, 6 Oct 2006 18:53:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 00/10] -mm: generic clocksource API -v2
Message-Id: <20061006185328.6b57fa83.akpm@osdl.org>
In-Reply-To: <20061006185439.667702000@mvista.com>
References: <20061006185439.667702000@mvista.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 11:54:39 -0700
Daniel Walker <dwalker@mvista.com> wrote:

> This patch set is meant to modify the clocksource structure and API so that it
> can be used by more than just the timekeeping code. My motivation is mainly
> that I feel the current clocksource interface could be used for much more
> than just timekeeping. So if we keep the clocksource interface (which I think
> we should) then we should get everything out of it that we can.
> 
> This set modifies the API, then converts the time keeping code over to the new
> API. I also added a generic sched_clock() which just re-uses the clocksource
> interface to provide a high quality scheduling clock (assuming a good
> clocksource). Several ARM board just output nanoseconds based on jiffies which
> is still possible with the generic sched_clock().

Well it all applies on top of the hrtimer/dynticks stuff with only a bit of
fixing needed.  And then it compiles.

But there's been so much time-related work happening lately that I'm
inclined to park this work for a while, give the existing changes time to
settle in and get debugged.  And to give people time to review this new
material.  If that review is positive, we can bring this material into
-mm in a week or so.  OK?


