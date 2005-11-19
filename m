Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVKSU4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKSU4r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVKSU4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:56:47 -0500
Received: from holomorphy.com ([66.93.40.71]:47278 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1750826AbVKSU4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:56:46 -0500
Date: Sat, 19 Nov 2005 12:55:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] unpaged: unifdefed PageCompound
Message-ID: <20051119205557.GO6916@holomorphy.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171931400.4563@goblin.wat.veritas.com> <20051117.154323.10862063.davem@davemloft.net> <Pine.LNX.4.61.0511192003060.2846@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511192003060.2846@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, David S. Miller wrote:
>> I think this is a good change regardless of the VM_RESERVED issues.
>> I've been wanting to use this facility in some sparc64 bits in
>> the past, for example.  But since it was HUGETLB guarded that
>> wasn't possible.

On Sat, Nov 19, 2005 at 08:15:13PM +0000, Hugh Dickins wrote:
> I've only just found that we have to supply the __GFP_COMP flag to get
> this working.  And one of the routes through snd_dma_alloc_pages goes
> to sbus_alloc_consistent.  Would you be happy for me to send Andrew a
> patch with sparc and sparc64 sbus_alloc_consistent including __GFP_COMP?
> Ought I to do the same in the sparc and sparc64 pci_alloc_consistent??

I usually end up deferring to Dave on the driver issues, but this time
I can independently agree in an informed manner.


-- wli
