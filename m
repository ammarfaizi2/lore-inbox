Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWAWKJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWAWKJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWAWKJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:09:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50214 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932439AbWAWKJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:09:52 -0500
Date: Mon, 23 Jan 2006 11:11:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060123101150.GD12773@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270355627D@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270355627D@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23 2006, Andy Chittenden wrote:
> > There's your problem, apparently both of these queues is 
> > being set to a
> > limit lower than blk_max_low_pfn which means the block layer 
> > will revert
> > to the isa dma bounce zone for that queue... There's room for
> > improvement in the logic that chooses what zone to allocate 
> > from.
> 
> So I presume that requires a source fix. Or can it be configured out?

It does, I'll see if I can get some time to generate one.

-- 
Jens Axboe

