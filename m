Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbSJCKuy>; Thu, 3 Oct 2002 06:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263234AbSJCKuy>; Thu, 3 Oct 2002 06:50:54 -0400
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:50694 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263230AbSJCKux>; Thu, 3 Oct 2002 06:50:53 -0400
Date: Thu, 3 Oct 2002 11:56:10 +0100
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: block device size in 2.5
Message-ID: <20021003105610.GA12071@fib011235813.fsnet.co.uk>
References: <20021003103414.GA11966@fib011235813.fsnet.co.uk> <Pine.GSO.4.21.0210030645200.13480-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210030645200.13480-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 06:46:30AM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 3 Oct 2002, Joe Thornber wrote:
> 
> > Why is the total size of a block device held in struct gendisk rather
> > than struct block_device ?
> 
> It is mirrored into bdev->bd_inode->i_size.  However, struct block_device
> is not persistent - persistent stuff lives in struct gendisk.

Thanks.

Is gendisk the right name for that structure now ?  Since all block
devices now have to use it.  I've always avoided using gendisk before,
arguing that dm produces block devices, not disks.  I don't need
partitions and I don't particularly want the devices to appear in
/proc/partitions.

Joe Thornber
