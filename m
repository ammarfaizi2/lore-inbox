Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVI0WkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVI0WkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVI0WkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:40:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30005 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965216AbVI0WkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:40:11 -0400
Date: Wed, 28 Sep 2005 00:40:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate@namesys.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] block cleanups: Fix iosched module refcount leak
Message-ID: <20050927224024.GJ2811@suse.de>
References: <4339C595.3080308@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4339C595.3080308@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27 2005, Nate Diller wrote:
> If the requested I/O scheduler is already in place, elevator_switch simply 
> leaves the queue alone, and returns.  However, it forgets to call 
> elevator_put, so
> 
> 'echo [current_sched] > /sys/block/[dev]/queue/scheduler'
> 
> will leak a reference, causing the current_sched module to be permanently 
> pinned in memory.
> 
> This patchset is against 2.6.14-rc2-mm1, but should apply to anything 
> recent.

Thanks, looks good.

Signed-off-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

