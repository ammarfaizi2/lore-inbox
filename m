Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTERF60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 01:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTERF60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 01:58:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44432 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261993AbTERF6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 01:58:25 -0400
Date: Sun, 18 May 2003 08:11:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode, #2
Message-ID: <20030518061121.GD812@suse.de>
References: <20030516113309.GY812@suse.de> <20030517164733.B10850@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517164733.B10850@schatzie.adilger.int>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17 2003, Andreas Dilger wrote:
> On May 16, 2003  13:33 +0200, Jens Axboe wrote:
> > +	if (block_dump)
> > +		printk("%s: %s block %lu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", bh->b_rsector, count, kdevname(bh->b_rdev));
> 
> This should be changed to KERN_DEBUG or similar, since if you are logging
> kernel messages to disk you get stuck in an infinite loop with block_dump:
> 
> kjournald: WRITE block 67416/8 on 03:05
> kjournald: WRITE block 67424/8 on 03:05
> kjournald: WRITE block 67432/8 on 03:05
> kjournald: WRITE block 548144/8 on 03:05
> kjournald: WRITE block 67440/8 on 03:05
> kjournald: WRITE block 67448/8 on 03:05
> kjournald: WRITE block 67456/8 on 03:05

Or just stop syslog, I did mention you had to be careful with it.

-- 
Jens Axboe

