Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbUCYWmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUCYWlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:41:11 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11672 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263698AbUCYWie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:38:34 -0500
Date: Thu, 25 Mar 2004 14:38:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <25070000.1080254284@flay>
In-Reply-To: <200403251630.16485.habanero@us.ibm.com>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325215908.GA19313@elte.hu> <200403251630.16485.habanero@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For Opteron simply placing all cpus in the same sched domain may solve all of 
> this, since we will have balancing frequency of the default scheduler.  Is 
> there any reason this cannot be done for Opteron?

That seems like a good plan to me - they really don't want that cross-node
balancing. It might be cleaner to implement it by just tweaking the 
cross-balance paramters for that system to have the same effect, but it
probably doesn't matter much (I'm thinking of some future case when they
decide to do multi-chip on die or SMT, so just keying off 1 cpu per node
doesn't really fix it).

M.

