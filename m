Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUIAD5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUIAD5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUIAD5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:57:50 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:30833 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267746AbUIAD5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:57:49 -0400
Date: Tue, 31 Aug 2004 20:53:50 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jim Houston <jim.houston@comcast.net>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
Subject: Re: [RFC&PATCH] Alternative RCU implementation
Message-ID: <20040901035350.GH1241@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m3brgwgi30.fsf@new.localdomain> <20040830004322.GA2060@us.ibm.com> <1093886020.984.238.camel@new.localdomain> <20040830185223.GF1243@us.ibm.com> <1093922569.1003.159.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093922569.1003.159.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 11:22:49PM -0400, Jim Houston wrote:
> On Mon, 2004-08-30 at 14:52, Paul E. McKenney wrote: 
> > How does the rest of the kernel work with all interrupts to
> > a particular CPU shut off?  For example, how do you timeslice?
> 
> It's a balancing act.  In some cases we just document the
> missing functionality.  If the local timer is disabled on a cpu,
> all processes are SCHED_FIFO.  In the case of Posix timers, we
> move timers to honor the procesor shielding an the process affinity.

I have to ask...  When you say that you move the timers, you mean that
non-realtime CPU 1 managers timers for realtime CPU 0, so that CPU 1
is (effectively) taking CPU 0's timer interrupts?

							Thanx, Paul
