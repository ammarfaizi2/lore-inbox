Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTBPJXu>; Sun, 16 Feb 2003 04:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTBPJXu>; Sun, 16 Feb 2003 04:23:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19130 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266091AbTBPJXt>;
	Sun, 16 Feb 2003 04:23:49 -0500
Date: Sun, 16 Feb 2003 10:32:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] elv_former_request reversion
Message-ID: <20030216093244.GP26738@suse.de>
References: <20030215161236.67ce3f24.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215161236.67ce3f24.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15 2003, Andrew Morton wrote:
> 
> This morning's fix for elv_former_request() is causing oopses all over the
> place in the IO scheduler.
> 
> Jens, remember that I did try that fix a while ago, and the same happened.
> 
> I believe it has exposed a new problem at the
> __make_request/attempt_front_merge level: if attempt_front_merge()
> actually succeeds, the wrong request gets freed up in
> elv_merged_request().
> 
> It may be best to back this change out until it can be fixed up for
> real.

Yes agreed, I had forgotten about that point... Will fix.

-- 
Jens Axboe

