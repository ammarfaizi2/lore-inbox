Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVH3X4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVH3X4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVH3X4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:56:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56786
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932290AbVH3X4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:56:45 -0400
Date: Tue, 30 Aug 2005 16:56:31 -0700 (PDT)
Message-Id: <20050830.165631.122559296.davem@davemloft.net>
To: ak@suse.de
Cc: tony.luck@intel.com, clameter@engr.sgi.com, rusty@linux.intel.com,
       rusty.lynch@intel.com, linux-mm@kvack.org, prasanna@in.ibm.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if
 KPROBES is configured.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508310138.09841.ak@suse.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A9A1@scsmsx401.amr.corp.intel.com>
	<200508310138.09841.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Date: Wed, 31 Aug 2005 01:38:08 +0200

> On Wednesday 31 August 2005 01:05, Luck, Tony wrote:
> > >Please do not generate any code if the feature cannot ever be
> > >used (CONFIG_KPROBES off). With this patch we still have lots of
> > >unnecessary code being executed on each page fault.
> >
> > I can (eventually) wrap this call inside the #ifdef CONFIG_KPROBES.
> 
> At least the original die notifiers were designed as a generic debugger
> interface, not a kprobes specific thing. So I don't think it's a good idea.

Me neither, I think a way too big deal is being made about
about this by the ia64 folks.  Just put the dang hook in
there unconditionally already :-)
