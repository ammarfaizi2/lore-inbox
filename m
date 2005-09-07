Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVIGQrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVIGQrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVIGQrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:47:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5297 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932174AbVIGQrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:47:01 -0400
Date: Wed, 7 Sep 2005 08:42:22 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: torvalds@osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       hugh@veritas.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Hugh's alternate page fault scalability approach on 512p Altix
In-Reply-To: <20660000.1126103324@[10.10.2.4]>
Message-ID: <Pine.LNX.4.62.0509070838240.21170@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com>
 <20660000.1126103324@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2005, Martin J. Bligh wrote:

> > Anticipatory prefaulting raises the highest fault rate obtainable three-fold
> > through gang scheduling faults but may allocate some pages to a task that are
> > not needed.
> 
> IIRC that costed more than it saved, at least for forky workloads like a
> kernel compile - extra cost in zap_pte_range etc. If things have changed
> substantially in that path, I guess we could run the numbers again - has
> been a couple of years.

Right. The costs come about through wrong anticipations installing useless 
mappings. The patches that I posted have this feature off by default. Gang 
scheduling can be enabled by modifying a value in /proc. But I guess the 
approach is essentially dead unless others want this feature too. The 
current page fault scalability approach should be fine for a couple of 
years and who knows what direction mmu technology has taken then.







