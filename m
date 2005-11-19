Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVKSVpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVKSVpP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVKSVpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:45:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62954
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750874AbVKSVpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:45:14 -0500
Date: Sat, 19 Nov 2005 13:41:14 -0800 (PST)
Message-Id: <20051119.134114.115024780.davem@davemloft.net>
To: wli@holomorphy.com
Cc: hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] unpaged: unifdefed PageCompound
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051119205557.GO6916@holomorphy.com>
References: <20051117.154323.10862063.davem@davemloft.net>
	<Pine.LNX.4.61.0511192003060.2846@goblin.wat.veritas.com>
	<20051119205557.GO6916@holomorphy.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 19 Nov 2005 12:55:57 -0800

> On Thu, 17 Nov 2005, David S. Miller wrote:
> >> I think this is a good change regardless of the VM_RESERVED issues.
> >> I've been wanting to use this facility in some sparc64 bits in
> >> the past, for example.  But since it was HUGETLB guarded that
> >> wasn't possible.
> 
> On Sat, Nov 19, 2005 at 08:15:13PM +0000, Hugh Dickins wrote:
> > I've only just found that we have to supply the __GFP_COMP flag to get
> > this working.  And one of the routes through snd_dma_alloc_pages goes
> > to sbus_alloc_consistent.  Would you be happy for me to send Andrew a
> > patch with sparc and sparc64 sbus_alloc_consistent including __GFP_COMP?
> > Ought I to do the same in the sparc and sparc64 pci_alloc_consistent??
> 
> I usually end up deferring to Dave on the driver issues, but this time
> I can independently agree in an informed manner.

What is it needed for in this case?  We never try to use those
pci_alloc_consistent() pages independantly, ie. freeing up
individual pages from a non-zero order allocation.

Just curious. :-)

