Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVEKSNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVEKSNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVEKSNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:13:33 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:62442 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261242AbVEKSN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:13:26 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 11 May 2005 11:12:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andi Kleen <ak@suse.de>
Cc: Len Brown <len.brown@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Asit K Mallick <asit.k.mallick@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, trenn@suse.de
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050511181214.GH15479@atomide.com>
References: <20050429172605.A23722@unix-os.sc.intel.com> <20050502163821.GE7342@wotan.suse.de> <20050502101631.A4875@unix-os.sc.intel.com> <20050502190850.GN7342@wotan.suse.de> <1115271213.7637.126.camel@d845pe> <20050505121924.GN28441@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505121924.GN28441@wotan.suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [050505 05:21]:
> On Thu, May 05, 2005 at 01:33:33AM -0400, Brown, Len wrote:
> > Re: no idle tick
> > 
> > Idle power savings does not by itself justify HZ=0.
> > We'll get the same idle power consumption with HZ=1.
> 
> 
> Power consumption is not the only reason for no tick in idle.
> The other big one is virtualization. If you have lots
> of virtual machines running on a hypervisor you really
> dont want them to wake up regularly even when idle.

Yes, and although this is x86/x86_64 thread, I'd like to point out
that embedded systems can benefit from skipping ticks for several
seconds at a time.

There's no need for ticks on embedded systems until some event,
such as an interrupt happens.

Cheers,

Tony
