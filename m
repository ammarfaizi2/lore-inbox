Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVHKOJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVHKOJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVHKOJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:09:15 -0400
Received: from [194.90.237.34] ([194.90.237.34]:64200 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750765AbVHKOJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:09:14 -0400
Date: Thu, 11 Aug 2005 17:11:43 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <glebn@voltaire.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050811141143.GB19686@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com> <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com> <20050810083943.GM16361@minantech.com> <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com> <20050810132611.GP16361@minantech.com> <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com> <20050811080205.GR16361@minantech.com> <Pine.LNX.4.61.0508111446030.10888@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508111446030.10888@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Hugh Dickins <hugh@veritas.com>:
> Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
> 
> On Thu, 11 Aug 2005, Gleb Natapov wrote:
> > What about the idea that was floating around about new VM flag that will
> > instruct kernel to copy pages belonging to the vma on fork instead of mark
> > them as cow?
> 
> It's a pretty good idea, and thanks for reminding us of it.
> 
> It suffers from the general difficulty with fixes within get_user_pages,
> that we need down_write(&mm->mmap_sem) to split_vma, and even just to
> update vm_flags, whereas get_user_pages is entered with down_read.

No, the idea is to let the application (or a library that it loades)
change this flag by means of some system call.
Something like MADV_COPYONFORK, in addition to MADV_DONTCOPY.


-- 
MST
