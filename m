Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRBYVAq>; Sun, 25 Feb 2001 16:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRBYVAh>; Sun, 25 Feb 2001 16:00:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129741AbRBYVAb>;
	Sun, 25 Feb 2001 16:00:31 -0500
Date: Sun, 25 Feb 2001 21:59:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Steve Whitehouse <Steve@ChyGwyn.com>, torvalds@transmeta.com,
        pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010225215949.L7830@suse.de>
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com> <20010225215550.B19168@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010225215550.B19168@athlon.random>; from andrea@suse.de on Sun, Feb 25, 2001 at 09:55:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Andrea Arcangeli wrote:
> On Sun, Feb 25, 2001 at 07:57:29PM +0000, Steve Whitehouse wrote:
> > The bug fix in ll_rw_blk.c prevents hangs when using block devices which
> > don't have plugging functions,
> 
> It looks the right fix (better than 2.4.0 that didn't had such bug but
> that was recalling the request_fn at every inserction in the queue).

Indeed, the removal was too quick and forgot private plugs.

-- 
Jens Axboe

