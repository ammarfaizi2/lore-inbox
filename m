Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132868AbRDXI73>; Tue, 24 Apr 2001 04:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132894AbRDXI7T>; Tue, 24 Apr 2001 04:59:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60680 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132868AbRDXI7J>;
	Tue, 24 Apr 2001 04:59:09 -0400
Date: Tue, 24 Apr 2001 10:58:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Kurt Garloff <kurt@garloff.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: read perf improved by mounting ext2?
Message-ID: <20010424105858.C9357@suse.de>
In-Reply-To: <20010424013150.A6892@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010424013150.A6892@garloff.etpnet.phys.tue.nl>; from kurt@garloff.de on Tue, Apr 24, 2001 at 01:31:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24 2001, Kurt Garloff wrote:
> I get it. But not over the whole disk.
> Doing a read speed measurement on /dev/hda, I constantly get ~16 MB/s.
> Not bad, but less than I'd expect. Measuring single partitions, some show
> the same, some show significantly more, 26MB/s--18MB/s, depending on the
> position of the partition on disk. Those look good!
> 
> There are enough partitions to see a clear pattern: Those with mounted ext2
> filesystems perform better. Umounting them does not harm, they just need to
> have been mounted once. reiser or (v)fat however don't improve anything.
> swap does, as does a ext2 over raid5.

You wouldn't happen to have 4kB ext2 filesystems on those? When ext2
mounts, it sets the soft blocksize to that then, I would expect this to
give at least some benefit over using 1kB blocks (as your IDE partition
otherwise would have).

-- 
Jens Axboe

