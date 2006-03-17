Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWCQQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWCQQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCQQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:40:15 -0500
Received: from mx.pathscale.com ([64.160.42.68]:5826 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751427AbWCQQkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:40:14 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603170825540.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
	 <4419062C.6000803@yahoo.com.au>
	 <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
	 <441A04D0.3060201@yahoo.com.au>
	 <1142611861.28538.22.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.64.0603170825540.3618@g5.osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 17 Mar 2006 08:40:09 -0800
Message-Id: <1142613609.28538.47.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 08:28 -0800, Linus Torvalds wrote:

> kmalloc may be backed by a "struct page", but the point is that it does 
> not honor the page _count_, and as such it is totally unsuitable for any 
> VM usage.

That's fine.  We're not calling dma_free_coherent until after the page
count goes back down to one (the driver is once again the only user).
But this doesn't seem germane to what Nick brought up, anyway.

	<b

