Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbTE1HXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264615AbTE1HXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:23:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39079 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264614AbTE1HXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:23:02 -0400
Date: Wed, 28 May 2003 09:35:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Con Kolivas <kernel@kolivas.org>, manish <manish@storadinc.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528073544.GR845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de> <200305280930.48810.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305280930.48810.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Marc-Christian Petersen wrote:
> On Wednesday 28 May 2003 09:13, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > If you leave nr_requests as it is, I don't see why it should not boot
> > with batch_requests == 0.
> > I can't see in all of these mails whether backing out akpm's starvation
> > patch makes the problem go away. Does it?
> If you mean 

> "http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/block/ll_rw_blk.c@1.29?nav=index.html|ChangeSet@-2y|cset@1.160|hist/drivers/block/ll_rw_blk.c"
> 
> that one, the answer is YES.

That's the one, yes. Andrew, looks like your patch brought out some
really bad behaviour.

-- 
Jens Axboe

