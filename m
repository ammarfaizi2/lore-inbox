Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWEaS0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWEaS0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWEaS0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:26:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751779AbWEaS0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:26:47 -0400
Date: Wed, 31 May 2006 11:26:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <20060531181312.GA29535@suse.de>
Message-ID: <Pine.LNX.4.64.0605311121390.24646@g5.osdl.org>
References: <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
 <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <Pine.LNX.4.64.0605310755210.24646@g5.osdl.org>
 <20060531181312.GA29535@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 May 2006, Jens Axboe wrote:
> 
> Anyway, the point I wanted to make is that this was never driven by
> scheduler activity. So there!

Heh. I confused tq_disk and tq_scheduler, methinks.

And yes, "run_task_queue(&tq_disk)" was in lock_page(), not the scheduler.

			Linus
