Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUCYAss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUCYAqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:46:04 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:57576 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S262711AbUCYAnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:43:07 -0500
Date: Wed, 24 Mar 2004 16:43:02 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Arjan van de Ven <arjanv@redhat.com>,
       tiwai@suse.de, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040325004302.GF1301@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random> <20040324200208.GA1301@us.ibm.com> <20040324233629.GK2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324233629.GK2065@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 12:36:29AM +0100, Andrea Arcangeli wrote:
> On Wed, Mar 24, 2004 at 12:02:08PM -0800, Paul E. McKenney wrote:
> > If the "nice" value does not matter, this seems reasonable, at least for
> > some value of 10.  ;-)
> 
> the nice value should no matter for this.

I agree that there would not likely be any differences except in
corner-case OOM situations, and that we would probably not want
to rely on such differences in any case.

> btw, (just to avoid misunderstanding) the number 10 is
> MAX_SOFTIRQ_RESTART.

Ah!  Thank you for the clarification -- I thought you were
talking about the number of RCU callbacks to be executed in each
rcu_do_batch() invocation.  And, yes, after MAX_SOFTIRQ_RESTART,
ksoftirqd does re-enable preemption.

						Thanx, Paul
