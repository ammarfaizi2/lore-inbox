Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVHRMeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVHRMeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVHRMeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:34:20 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37860 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932158AbVHRMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:34:19 -0400
Subject: Re: PROBLEM: mmap_kmem()
From: Steven Rostedt <rostedt@goodmis.org>
To: Valentin Rabinovich <vrabin@cs.joensuu.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124355224.43044c984be40@wwwmail.joensuu.fi>
References: <1124355224.43044c984be40@wwwmail.joensuu.fi>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 08:34:09 -0400
Message-Id: <1124368449.5186.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 11:53 +0300, Valentin Rabinovich wrote:
> Bug in mmap_kmem(), drivers/char/mem.c.
> When mapping the kmem, page alingning seems to mess the address:
> 
>   unsigned long long val;
>   val = (u64)vma->vm_pgoff << PAGE_SHIFT;
>   vma->vm_pgoff = ((unsigned long)val >> PAGE_SHIFT) - PAGE_OFFSET;
>   vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;
> 
> Subtracting 0xc0000000 and shifting is made in wrong order.
> Kernel: 2.6.12.3, 2.6.12.4

This is already fixed in 2.6.13-rc6-git9, so you need to wait for it in
the 2.6.13 release, or better yet, download and test the git release.

-- Steve


