Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUIGRJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUIGRJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268231AbUIGQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:53:13 -0400
Received: from verein.lst.de ([213.95.11.210]:45724 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268148AbUIGQw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:52:29 -0400
Date: Tue, 7 Sep 2004 18:52:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make kmem_find_general_cachep static in slab.c
Message-ID: <20040907165221.GA11383@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040907143632.GA8480@lst.de> <413DE6C9.5050402@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413DE6C9.5050402@colorfullife.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:50:17PM +0200, Manfred Spraul wrote:
> Why?
> It's intended for users that want to kmalloc always the same amount of 
> memory.
> For example the network layer could call kmem_find_general_cachep once 
> for dev->mtu and then just call kmem_cache_alloc instead of kmalloc. The 
> loop in kmalloc often needs more cpu cycles than the actual alloc.

Because there's no single user, and for constant size arguments kmalloc
already optimizes very well, so I rather doubt people are ever going to
use this one.

Is the basic don't design APIs for a maybe future scheme.
