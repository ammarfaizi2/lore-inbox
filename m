Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUFECei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUFECei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 22:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUFECei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 22:34:38 -0400
Received: from ozlabs.org ([203.10.76.45]:62189 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264500AbUFECeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 22:34:37 -0400
Date: Sat, 5 Jun 2004 12:32:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-ID: <20040605023211.GA16084@krispykreme>
References: <20040605034356.1037d299.ak@suse.de> <40C12865.9050803@colorfullife.com> <20040605041813.75e2d22d.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605041813.75e2d22d.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> That's correct. It will only work for order 0 allocations.
> 
> But it sounds quite bogus anyways to move the complete hash tables
> to another node anyways. It would probably be better to use vmalloc() 
> and a interleaving mapping for it. Then you would get the NUMA bandwidth 
> benefit even for accessing single tables.

I posted some before and after numbers when we merged Manfreds patch,
it would be interesting to see the same thing with your patch applied.

Im not only worried about NUMA bandwidth but keeping the amount of
memory left in all the nodes reasonably even. Allocating all the big
hashes on node 0 will decrease that balance.

Anton
