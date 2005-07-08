Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVGHOFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVGHOFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVGHODP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:03:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50938 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262671AbVGHOAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:00:55 -0400
Subject: Re: 'sleeping function called from invalid context' bug when
	mounting an IDE device
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050708134346.GA4890@elte.hu>
References: <20050708162846.54de783d.vwool@ru.mvista.com>
	 <20050708134346.GA4890@elte.hu>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 07:00:42 -0700
Message-Id: <1120831242.19225.3.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 15:43 +0200, Ingo Molnar wrote:
> * Vitaly Wool <vwool@ru.mvista.com> wrote:
> 
> > Hi Ingo,
> > 
> > I've come across the following problem during the debugging of IDE 
> > driver for Philips PNX0105 ARM9 platform in RT mode 
> > (CONFIG_PREEMPT_RT). When I mount/unmount a device, the following 
> > error is printed out to a terminal:
> 
> could you send me the full backtrace?
> 
> > So, the problem is in the generic IDE code, namely, in ide_intr() 
> > taking ide_lock.
> 
> which version did you try, and does this happen with the latest patch 
> too?

Interrupts should be enabled unconditionally for threaded interrupt
handlers. Or at least the generics work that way.

Daniel

