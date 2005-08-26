Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbVHZOSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbVHZOSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbVHZOSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:18:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37362 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751583AbVHZOSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:18:05 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125038597.20120.147.camel@tglx.tec.linutronix.de>
References: <20050825062651.GA26781@elte.hu>
	 <1125012596.14592.12.camel@dhcp153.mvista.com>
	 <1125015724.20120.143.camel@tglx.tec.linutronix.de>
	 <1125018945.14592.15.camel@dhcp153.mvista.com>
	 <1125038597.20120.147.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:17:41 -0700
Message-Id: <1125065862.7896.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 08:43 +0200, Thomas Gleixner wrote:
> On Thu, 2005-08-25 at 18:15 -0700, Daniel Walker wrote:
> > On Fri, 2005-08-26 at 02:22 +0200, Thomas Gleixner wrote:
> > > On Thu, 2005-08-25 at 16:29 -0700, Daniel Walker wrote:
> > > > Devastating latency on a 3Ghz xeon .. Maybe the raw_spinlock in the
> > > > timer base is creating a unbounded latency?
> > > 
> > > The lock is only held for really short periods. The only possible long
> > > period would be migration of timers from a dead hotplug cpu to another.
> > > I guess thats not the case.
> > > 
> > > Do you have HIGH_RES_TIMERS enabled ?
> > 
> > No. The cascade has a very long worst case.
> 
> You mean the cascading from the outer to the inner wheels ? That should
> only happen with tons of active timers.

Right .. 

Daniel

