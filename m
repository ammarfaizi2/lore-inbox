Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFKPQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFKPQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVFKPQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:16:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54107
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261256AbVFKPQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:16:56 -0400
Date: Sat, 11 Jun 2005 17:16:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611151646.GA5796@g5.random>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610231647.GK1300@us.ibm.com> <20050610232628.GA23512@nietzsche.lynx.com> <20050611010755.GN1300@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611010755.GN1300@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 06:07:55PM -0700, Paul E. McKenney wrote:
> 	f.	Any code that manipulates hardware that can stall the
> 		bus, delay interrupts, or otherwise interfere with
> 		forward progress.  Note that it is also necessary to
> 		inspect user-level code that directly manipulates such
> 		hardware.
> 
> I added point "f".  Does that cover it?

Yes. F is really a bad problem if it really can cause DMA starvation on
the memory bus on some arch as stated on this thread. Hopefully
measurements are good enough to rule it out and there will be no corner
cases triggering once in a while.
