Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVGMO2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVGMO2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVGMO2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:28:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15086 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262658AbVGMO2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:28:45 -0400
Date: Wed, 13 Jul 2005 07:29:18 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Attempted summary of "RT patch acceptance" thread, take 2
Message-ID: <20050713142918.GA1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050711145552.GA1489@us.ibm.com> <1121098272.7050.13.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050711164322.GD1304@us.ibm.com> <1121100589.7050.24.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050711171910.GE1304@us.ibm.com> <1121102728.7050.29.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121102728.7050.29.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 10:25:28AM -0700, Daniel Walker wrote:
> On Mon, 2005-07-11 at 10:19 -0700, Paul E. McKenney wrote:
> 
> > OK, interesting point, though this would apply only to interrupt latency,
> > not to scheduling latency or to latency for any other system services,
> > right?
> 
> Only for interrupt latency, that I know of. 
> 
> > Do you believe that the 50-us delay measured by Kristian and Karim was
> > due to APM or due to hardware (as Karim suspected)?  If the latter,
> > any guesses as to the cause of the holdup?  50 us is a -really- long
> > time for ~100 instructions on today's hardware, even if each instruction
> > misses the cache!
> 
> There are ~100 interrupt off critical sections. Those sections can be
> variable numbers of instructions. I would imagine that whatever maximum
> latency that Kristian and Karim found is the maximum for their hardware.

Does your ~100-instruction estimate include scheduler_tick() interrupt?
>From another thread, I gather that it runs with hardware interrupts
disabled.

						Thanx, Paul
