Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVLNBNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVLNBNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbVLNBNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:13:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51634 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932631AbVLNBNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:13:00 -0500
Date: Wed, 14 Dec 2005 02:12:53 +0100
From: Andi Kleen <ak@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Keith Owens <kaos@sgi.com>, Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051214011253.GB23384@wotan.suse.de>
References: <20051213162027.GA14158@us.ibm.com> <17158.1134512861@ocs3.ocs.com.au> <20051213225059.GD14158@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213225059.GD14158@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 02:50:59PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 14, 2005 at 09:27:41AM +1100, Keith Owens wrote:
> > On Tue, 13 Dec 2005 08:20:27 -0800, 
> > "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> > >If the variable p references MMIO rather than normal memory, then
> > >wmb() and rmb() are needed instead of smp_wmb() and smp_rmb().
> > 
> > mmiowb(), not wmb().  IA64 has a different form of memory fence for I/O
> > space compared to normal memory.  MIPS also has a non-empty form of
> > mmiowb().
> 
> New one on me!

Didn't it make only a difference on the Altix or something like that? 
I suppose they added it only on the drivers for devices supported by SGI.

-Andi
