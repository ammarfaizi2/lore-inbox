Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261629AbSJBF3p>; Wed, 2 Oct 2002 01:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262971AbSJBF3p>; Wed, 2 Oct 2002 01:29:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5866 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261629AbSJBF3o>;
	Wed, 2 Oct 2002 01:29:44 -0400
Date: Wed, 2 Oct 2002 07:35:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20021002053500.GJ5755@suse.de>
References: <20020925172024.GH15479@suse.de> <20020930074519.B159@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020930074519.B159@toy.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Pavel Machek wrote:
> Hi!
> 
> > Due to recent "problems" (well the vm being just too damn good at keep
> > disks busy these days), it's become even more apparent that our current
> > io scheduler just cannot cope with some work loads. Repeated starvartion
> > of reads is the most important one. The Andrew Morton Interactive
> > Workload (AMIW) [1] rates the current kernel poorly, on my test machine
> > it completes in 1-2 minutes depending on your luck. 2.5.38-BK does a lot
> > better, but mainly because it's being extremely unfair. This deadline io
> > scheduler finishes the AMIW in anywhere from ~0.5 seconds to ~3-4
> > seconds, depending on the io load.
> 
> would it be possible to make deadlines per-process to introduce ionice?
> 
> ionice -n -5 mpg123 foo.mp3
> ionice make

Yes it would be possible, and at least for reads it doesn't require too
many changes to the deadline scheduler. There's even someone working on
it, expect something to play with soon. It bases the io priority on the
process nice levels.

-- 
Jens Axboe

