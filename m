Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVFJVGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVFJVGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFJVGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:06:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42562
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261209AbVFJVGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:06:19 -0400
Date: Fri, 10 Jun 2005 23:06:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610210614.GD6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118436338.6423.48.camel@mindpipe>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:45:38PM -0400, Lee Revell wrote:
> AFAICT even RTAI would be affected, because X lets userspace drivers
> talk directly to the hardware including wedging the PCI bus.

Yes, I made the usb example exactly to show how latency bugs can be
longstanding in the kernel too without requiring X or hardware bugs
(this usb thing breaks kernel latency for years and yet nobody fixed it
simply because it just works fine in practice, I noticed because
apparently my PIT or tsc goes out of sync over time, and in turn my
system time was going into the future pretty quick with HZ=1000, or I
would have never noticed, of course I'm compiling the kernel with HZ=100
on that system to work around it). Those latency issues can showup in
random drivers all the time, and this one was of an extreme magnitude in
the millisecond range. The smaller the magnitude of the latency impact,
the more frequently you should find it in drivers.
