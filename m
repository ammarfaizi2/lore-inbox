Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVHXHZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVHXHZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVHXHZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:25:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55743 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750708AbVHXHZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:25:10 -0400
Date: Wed, 24 Aug 2005 09:25:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824072501.GA27992@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824171931.H4209301@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24 2005, Nathan Scott wrote:
> On Wed, Aug 24, 2005 at 09:08:10AM +0200, Jens Axboe wrote:
> > ...
> > This isn't msec precision, it's usec. sched_clock() is in ns! I already
> > decided that msec is too coarse, but usec _should_ be enough.
> 
> Right you are (I was thinking m-for-micro, not m-for-milli in my head ;)
> - but still, there doesn't seem to be any reason for that divide-by-1000
> and reducing the precision in the kernel rather than in userspace, does
> there?  Doing it the other way means you wont ever have to worry about
> whether it is/isn't sufficient precision for all possible block devices,
> and the precision the tool displays will just be a userspace decision.

I was just worried about wrapping of ->time, but I did make it a 64-bit
unit. So I guess we could go to nsec granularity, there should be plenty
[*] of space. I'll change that too, I'll post an update version later.

* I probably should not make such a statement :-)

-- 
Jens Axboe

