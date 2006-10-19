Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161436AbWJSPB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbWJSPB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161437AbWJSPB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:01:56 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:30717 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161436AbWJSPBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:01:55 -0400
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mingo@elte.hu, tglx@linutronix.de
In-Reply-To: <200610191650.25678.ak@suse.de>
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net>
	 <200610191626.10662.ak@suse.de> <45379031.601@yahoo.com.au>
	 <200610191650.25678.ak@suse.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:01:53 -0700
Message-Id: <1161270113.11264.23.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 16:50 +0200, Andi Kleen wrote:
> On Thursday 19 October 2006 16:48, Nick Piggin wrote:
> > Andi Kleen wrote:
> > >>An SMP kernel can boot on UP hardware, in which case I think
> > >>num_possible_cpus() will be 1, won't it?
> > > 
> > > 
> > > 0 was a typo, i meant 1 for UP of course. 0 would be nonsensical.
> > 
> > Sure, I realised that. For a UP kernel, the test will compile away.
> > 
> > But Daniel seems to say there is dead code that could be compiled
> > out for SMP kernels. I just don't think that is possible because the
> > SMP kernel can boot a UP system where num_possible_cpus() is 1.
> 
> I thought he meant !CONFIG_SMP kernels.

definitely CONFIG_SMP=y . The code block I quoted would disable the PIT
clocksource w/ more than one cpu. So the pit clocksource is just dead
weight on SMP systems. However, like Nick was saying it's possible to
boot CONFIG_SMP on a UP system, but removing the pit in that situation
may not hurt anything.

Daniel 

