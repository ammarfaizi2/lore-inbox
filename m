Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVF1Ifs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVF1Ifs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVF1Ifq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:35:46 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:20434 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261995AbVF1Iex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:34:53 -0400
Date: Tue, 28 Jun 2005 04:34:29 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Daniel Walker <dwalker@mvista.com>, Chuck Harding <charding@llnl.gov>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <20050628081843.GA16455@elte.hu>
Message-ID: <Pine.LNX.4.58.0506280422250.24849@localhost.localdomain>
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net> <200506251039.14746.gene.heskett@verizon.net>
 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
 <1119902991.4794.5.camel@dhcp153.mvista.com> <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain>
 <20050628081843.GA16455@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Jun 2005, Ingo Molnar wrote:

> ah, indeed. I fixed this bug and have uploaded the -50-26 patch. Chuck,
> does this fix the APM problems for you?

The question is where the call to schedule happened. If it was between
the local_save_flags and irq_restore, then I believe the interrupts are
off and the schedule can take place.  But if it was afterwards, then this
is probably the fix since the irqrestore probably didn't restore it.

I guess we need to wait for Chuck to answer this.

-- Steve
