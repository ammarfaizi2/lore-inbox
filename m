Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTISPpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTISPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 11:45:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:37848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbTISPpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 11:45:43 -0400
Subject: Re: [Linstab] Hackbench STP Results History for 2.5 mm/2.6 mm
From: Craig Thomas <craiger@osdl.org>
To: linux-kernel@vger.kernel.org, linstab@osdl.org
In-Reply-To: <20030918175842.A21411@osdlab.pdx.osdl.net>
References: <200309190012.h8J0ClU15905@mail.osdl.org>
	 <20030918170754.6164e770.akpm@osdl.org>
	 <20030918175842.A21411@osdlab.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1063986328.15868.70.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Sep 2003 08:45:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-18 at 17:58, Mark Wong wrote:
> On Thu, Sep 18, 2003 at 05:07:54PM -0700, Andrew Morton wrote:
> > markw@osdl.org wrote:
> > >
> > > More history from hackbench from STP from the 2.5 and 2.6 mm kernels.
> > 
> > This looks great, but tragically incomprehensible.
> > 
> > Could someone please provide some interpretation, tell us what hackbench
> > is, and what all the numbers mean?
> > 
> > Do we rock or do we suck?
> 
> Sorry, I was a bit hasty.
> 
> Hackbench is a test from Rusty Russel that's intended to test the scalability
> of the scheduler.  The results I gathered are from a test where 100 processes
> are started to send a message to another set of 100 processes.  This is
> repeated at least a few times and the time taken to complete each instance
> is averaged.  Anyone feel free to correct me as I learned this second hand.


Each individual test run executes the test for 20 processes, then 40,
then 60, 80, and finally 100 processes.  Each set of processes are 
executed 5 times, and an average time to complete the exercise is
given for each of the sets.  The test report (shown by the link) has
a graph of the averaged times for each of the sets.  In all cases, 
there is a very good linear correlation as the number of processes
increase.  The results for the previous email showd only the times
for the 100 process set.  

As you look again and compare the times against the 1-way, 2-way, 4-way
and 8-way systems, you see the times decrease as the number of
processors in a system increase.  This is also a good trend.  And it
seems to be a fairly good linear correlation as well, implying that
the scheduler has done a good job at scaling between processes within
one system increase, and a good job at scaling as the number of
processors increase. 

As stated in the reply above, as the kernel is evolving, continual 
improvements are being made to the scheduler, as shown by the decrease
in average times for the run of 100 set of processes with each
subsequent release of the kernel.

> 
> The general trend in the metric indicates everything has been improving, so I
> think we rock.
> _______________________________________________
> Linstab mailing list
> Linstab@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/linstab
-- 
Craig Thomas
craiger@osdl.org

