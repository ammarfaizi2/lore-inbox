Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVFKUcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVFKUcB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVFKUcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:32:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:60322 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261821AbVFKUbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:31:40 -0400
Date: Sat, 11 Jun 2005 13:32:01 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611203201.GB1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610231647.GK1300@us.ibm.com> <20050610232628.GA23512@nietzsche.lynx.com> <20050611010755.GN1300@us.ibm.com> <20050611151646.GA5796@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611151646.GA5796@g5.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 05:16:46PM +0200, Andrea Arcangeli wrote:
> On Fri, Jun 10, 2005 at 06:07:55PM -0700, Paul E. McKenney wrote:
> > 	f.	Any code that manipulates hardware that can stall the
> > 		bus, delay interrupts, or otherwise interfere with
> > 		forward progress.  Note that it is also necessary to
> > 		inspect user-level code that directly manipulates such
> > 		hardware.
> > 
> > I added point "f".  Does that cover it?
> 
> Yes. F is really a bad problem if it really can cause DMA starvation on
> the memory bus on some arch as stated on this thread. Hopefully
> measurements are good enough to rule it out and there will be no corner
> cases triggering once in a while.

Agreed!

But who knows?  Maybe we can convince some HW manufacturers to make
their memory and I/O systems better.  So it might also be good to have
tests that forced the conditions as well as tests that avoid them.
Though such tests do sound horribly hardware dependent...

						Thanx, Paul
