Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUKIQLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUKIQLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKIQLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:11:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40888 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261563AbUKIQLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:11:47 -0500
Date: Tue, 9 Nov 2004 17:11:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm4
Message-ID: <20041109161112.GA3921@suse.de>
References: <20041109074909.3f287966.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109074909.3f287966.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09 2004, Andrew Morton wrote:
> +blk_sync_queue-updates.patch
> 
>  update an update to the md updates

I still don't think this is a good general export, it has very
specialized use. For example, from the description it looks like this
can be generally used on any block device and when it returns, we have
synced the queue. This simply isn't true, there are absolutely no
guarentees of that nature unless the block driver itself implements the
__make_request() functionality and has taken proper precautions to
prevent this already.

-- 
Jens Axboe

