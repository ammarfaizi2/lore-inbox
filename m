Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSIZIYj>; Thu, 26 Sep 2002 04:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262249AbSIZIYi>; Thu, 26 Sep 2002 04:24:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22219 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262248AbSIZIYh>;
	Thu, 26 Sep 2002 04:24:37 -0400
Date: Thu, 26 Sep 2002 10:29:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Pittman <daniel@rimspace.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926082925.GK12862@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <87k7l95f5a.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k7l95f5a.fsf@enki.rimspace.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26 2002, Daniel Pittman wrote:
> On Thu, 26 Sep 2002, Jens Axboe wrote:
> > On Wed, Sep 25 2002, Andrew Morton wrote:
> 
> [...]
> 
> > writes_starved. This controls how many times reads get preferred over
> > writes. The default is 2, which means that we can serve two batches of
> > reads over one write batch. A value of 4 would mean that reads could
> > skip ahead of writes 4 times. A value of 1 would give you 1:1
> > read:write, ie no read preference. A silly value of 0 would give you
> > write preference, always.
> 
> Actually, a value of zero doesn't sound completely silly to me, right
> now, since I have been doing a lot of thinking about video capture
> recently.
> 
> How much is it going to hurt a filesystem like ext[23] if that value is
> set to zero while doing large streaming writes -- something like
> (almost) uncompressed video at ten to twenty meg a second, for
> gigabytes?

You are going to stalll all reads indefinately :-)

> This is a situation where, for a dedicated machine, delaying reads
> almost forever is actually a valuable thing. At least, valuable until it
> stops the writes from being able to proceed.

Well 0 should achieve that quite fine

-- 
Jens Axboe

