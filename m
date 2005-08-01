Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVHANQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVHANQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 09:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVHANQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 09:16:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2196 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262044AbVHANPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 09:15:49 -0400
Date: Mon, 1 Aug 2005 15:17:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master] block: fix cfq_find_next_crq
Message-ID: <20050801131750.GD22569@suse.de>
References: <20050726132706.GC23916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726132706.GC23916@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26 2005, Tejun Heo wrote:
>  Hi,
> 
>  In cfq_find_next_crq(), when determining rbnext, if
> rb_next(&last->rb_node) is NULL, rb_first() is used without checking
> if it equals last.  If it equals last, rbnext should be NULL not last.
> This bug is masked by duplicate calls to cfq_find_next_crq which ends
> up clearing cfqq->next_crq as, on the second call, last isn't on rb
> tree.
> 
>  This patch fixes cfq_find_next_crq() and removes extra calls to
> cfq_update_next_crq().

Thanks, looks good!

-- 
Jens Axboe

