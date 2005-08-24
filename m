Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVHXHTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVHXHTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVHXHTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:19:38 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45470 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750702AbVHXHTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:19:37 -0400
Date: Wed, 24 Aug 2005 17:19:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824171931.H4209301@wobbly.melbourne.sgi.com>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050824070809.GA27956@suse.de>; from axboe@suse.de on Wed, Aug 24, 2005 at 09:08:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 09:08:10AM +0200, Jens Axboe wrote:
> ...
> This isn't msec precision, it's usec. sched_clock() is in ns! I already
> decided that msec is too coarse, but usec _should_ be enough.

Right you are (I was thinking m-for-micro, not m-for-milli in my head ;)
- but still, there doesn't seem to be any reason for that divide-by-1000
and reducing the precision in the kernel rather than in userspace, does
there?  Doing it the other way means you wont ever have to worry about
whether it is/isn't sufficient precision for all possible block devices,
and the precision the tool displays will just be a userspace decision.

cheers.

-- 
Nathan
