Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTKKQ2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTKKQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:28:13 -0500
Received: from dp.samba.org ([66.70.73.150]:38560 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264311AbTKKQ2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:28:12 -0500
Date: Wed, 12 Nov 2003 03:25:23 +1100
From: Anton Blanchard <anton@samba.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031111162523.GN930@krispykreme>
References: <20031110215844.GC21632@sgi.com> <20031111082915.GC1130@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111082915.GC1130@llm08.in.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The answer to this is probably alloc_percpu for the counters.
> right now this might not possible because irq_desc_t table might be used very
> early, and alloc_percpu uses slab underneath.  alloc_percpu will have to be 
> made to work early enough for this....

Also keep in mind the memory bloat with high NR_IRQS and NR_IRQS.

Anton
