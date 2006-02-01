Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWBANWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWBANWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWBANWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:22:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27578 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964972AbWBANWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:22:32 -0500
Date: Wed, 1 Feb 2006 14:20:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201132054.GA31156@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0B342.6090700@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >Once we've gone to the trouble of deciding which tasks to move and how
> >many (and the estimate should be very conservative), and locked the source
> >and destination runqueues, it is a very good idea to follow up with our
> >threat of actually moving the tasks rather than bail out early.
> 
> Oh, I forgot: Ingo once introduced some code to bail early (though for 
> different reasons and under different conditions), and this actually 
> was found to cause significant regressions in some database workloads.

well, we both did changes with that effect - pretty much any change in 
this area can cause a regression on _some_ workload ;) So there wont be 
any silver bullet.

> So it is not a nice thing to tinker with unless there is good reason.

unbound latencies with hardirqs off are obviously a good reason - but i 
agree that the solution is not good enough, yet.

	Ingo
