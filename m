Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWCUDZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWCUDZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 22:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCUDZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 22:25:58 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26573 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751480AbWCUDZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 22:25:57 -0500
Date: Tue, 21 Mar 2006 08:55:20 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: 7eggert@gmx.de
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
Message-ID: <20060321032520.GB8954@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <5Ssjj-314-69@gated-at.bofh.it> <5Sv7o-7l5-23@gated-at.bofh.it> <5Svh9-7xW-61@gated-at.bofh.it> <5SvK8-88q-41@gated-at.bofh.it> <E1FLPjT-0000o9-Sy@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FLPjT-0000o9-Sy@be1.lrz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok, please keep the interface - build kmem_cache_zalloc() on top of
> > what I suggest.
> 
> The benefit of using *zalloc is the ability to skip the memset by using
> pre-zeroed memory or to use more efficient ways of zeroing a page.
> Having to check the value of a parameter wouldn't help.

Hmm... the current patch directly does a memset(). Are you talking about
possible optimizations to kmem_cache_zalloc()?

Balbir
