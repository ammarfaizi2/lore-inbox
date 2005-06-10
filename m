Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVFJXTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVFJXTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVFJXS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:18:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31376 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261436AbVFJXQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:16:25 -0400
Date: Fri, 10 Jun 2005 16:16:47 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610231647.GK1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118436338.6423.48.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:45:38PM -0400, Lee Revell wrote:
> On Fri, 2005-06-10 at 19:37 +0200, Andrea Arcangeli wrote:
> > You don't need to add it to the document, but as a further pratical
> > example of troublesome hardware besides VGA (could be a software issue
> > and not hardware issue though)  
> 
> The VGA problems were due to (X, not kernel!) driver bugs.  Recent
> versions of X are thought to be OK.
> 
> It's the exact same issue described in this paper, scroll down to
> section 4.5.
> 
> http://www.cs.utah.edu/~regehr/papers/hotos7/hotos7.html
> 
> There's absolutely nothing the kernel or PREEMPT_RT can do about this,
> AFAICT even RTAI would be affected, because X lets userspace drivers
> talk directly to the hardware including wedging the PCI bus.

Cute!

I suppose that Eric Piel's approach would avoid this problem if
implemented on a NUMA machine with all processes making use of video
being affinitied to the NUMA node containing the video card.  ;-)

Sounds like I need to add "antisocial hardware" to the list of
things that need to be inspected to validate realtime latencies.

						Thanx, Paul
