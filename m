Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTFDUya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTFDUya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:54:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:32783 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264147AbTFDUy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:54:29 -0400
Date: Wed, 4 Jun 2003 23:12:16 +0200
To: Andrew Morton <akpm@digeo.com>, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm4
Message-ID: <20030604211216.GA2436@hh.idb.hist.no>
References: <20030603231827.0e635332.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603231827.0e635332.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raid-1 seems to work in 2.5.70-mm4, but raid-0 still fail.

Trying to boot with raid-0 autodetect yields a long string of:
Slab error in cache_free_debugcheck
cache 'size-32' double free or
memory after object overwritten.
(Is this something "Page alloc debugging"may be used for?)
kfree+0xfc/0x330
raid0_run
raid0_run
printk
blk_queue_make_request
do_md_run
md_ioctl
dput
blkdev_ioctl
sys_ioctl
syscall_call

I get a ton of these, in between normal
initialization messages.  Then the thing
dies with a panic due to exception in interrupt.

This is a monolithic smp preempt kernel on a dual celeron.
The disks are scsi, the filesystems ext2.  There is one
raid-0 array and two raid-1 arrays, as well as some
ordinary partitions.  Root is on raid-1.

Helge Hafting

