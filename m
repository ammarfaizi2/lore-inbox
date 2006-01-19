Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161474AbWASW5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161474AbWASW5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWASW5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:57:31 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:16612 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161474AbWASW5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:57:30 -0500
Subject: RE: My vote against eepro* removal
From: Steven Rostedt <rostedt@goodmis.org>
To: kus Kusche Klaus <kus@keba.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1137697744.6762.106.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
	 <1137697744.6762.106.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 17:57:25 -0500
Message-Id: <1137711445.6762.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 14:09 -0500, Steven Rostedt wrote:
> On Thu, 2006-01-19 at 11:26 +0100, kus Kusche Klaus wrote:
> > > From: Lee Revell
> > > On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> > > > Last time I tested (around 2.6.12), eepro100 worked much better 
> > > > in -rt kernels w.r.t. latencies than e100:
> 
> Try the latest -rt kernel with e100 to see if it still is a delay.  You
> can also run in PREEMPT_DESKTOP so that the interrupt handlers are not
> threads and see if that shows up in the latency.

I just booted up 2.6.15-rt6 (PREEMPT_DESKTOP, regular soft and hard
irqs) on a 366 MHz UP machine with init=/bin/bash.  Loaded the e100
driver, setup the network. Then started to ping it from another box.  I
had a 80 usec latency, and that wasn't even from the network card.

So, e100 should not be a problem.  I did see the interrupts go off every
2 seconds too.

Check to see if you still get the latencies with e100 and the latest
kernel.

As Lee already said.  You notice something fishy __PLEASE__ report it.
Arjan's response was that this shows that we should only have one driver
for a certain task, otherwise people wont report a problem with one, if
the other satisfies their needs. And thus, the problem remains.

-- Steve

