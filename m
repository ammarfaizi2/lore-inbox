Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWCUKvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWCUKvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWCUKvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:51:33 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:61391 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S965022AbWCUKvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:51:32 -0500
Date: Tue, 21 Mar 2006 11:51:22 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Balbir Singh <balbir@in.ibm.com>
cc: 7eggert@gmx.de, Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
In-Reply-To: <20060321032520.GB8954@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0603211137170.3292@be1.lrz>
References: <5Ssjj-314-69@gated-at.bofh.it> <5Sv7o-7l5-23@gated-at.bofh.it>
 <5Svh9-7xW-61@gated-at.bofh.it> <5SvK8-88q-41@gated-at.bofh.it>
 <E1FLPjT-0000o9-Sy@be1.lrz> <20060321032520.GB8954@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Balbir Singh wrote:

> > > Ok, please keep the interface - build kmem_cache_zalloc() on top of
> > > what I suggest.
> > 
> > The benefit of using *zalloc is the ability to skip the memset by using
> > pre-zeroed memory or to use more efficient ways of zeroing a page.
> > Having to check the value of a parameter wouldn't help.
> 
> Hmm... the current patch directly does a memset(). Are you talking about
> possible optimizations to kmem_cache_zalloc()?

Yes. At least that's what I understand from the whole zalloc process.
-- 
Top 100 things you don't want the sysadmin to say:
4. This won't affect what you're doing.
