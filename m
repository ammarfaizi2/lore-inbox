Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755982AbWKVRAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbWKVRAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbWKVRAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:00:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34466 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755983AbWKVRAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:00:19 -0500
Date: Wed, 22 Nov 2006 09:01:31 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061122170131.GC1755@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061121230314.GH2013@us.ibm.com> <Pine.LNX.4.44L0.0611212116560.11777-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611212116560.11777-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 09:17:59PM -0500, Alan Stern wrote:
> On Tue, 21 Nov 2006, Paul E. McKenney wrote:
> 
> > > Things may not be quite as bad as they appear.  On many architectures the
> > > store-mb-load pattern will work as expected.  (In fact, I don't know which
> > > architectures it might fail on.)
> >
> > Several weak-memory-ordering CPUs.  :-/
> 
> Of the CPUs supported by Linux, do you know which ones will work with
> store-mb-load and which ones won't?

I have partial lists at this point.  I confess to not having made
much progress porting my memory-barrier torture tests to the relevant
architectures over the past few weeks (handling the lack of synchronized
lightweight fine-grained timers being the current obstacle), but will
let people know once I have gotten the tests working on the machines
that I have access to.

I don't have access to SMP Alpha or ARM machines (or UP either, for that
matter), so won't be able to test those.

						Thanx, Paul
