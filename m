Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbUKXPch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbUKXPch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKXPak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:30:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:48835 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262685AbUKXNZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:25:29 -0500
Date: Wed, 24 Nov 2004 14:24:50 +0100
From: Jens Axboe <axboe@suse.de>
To: "Christopher S. Aker" <caker@theshore.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7 - Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
Message-ID: <20041124132449.GD13847@suse.de>
References: <001301c4d1f6$941d1370$0201a8c0@hawk> <20041124130139.GC13847@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124130139.GC13847@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Jens Axboe wrote:
> On Wed, Nov 24 2004, Christopher S. Aker wrote:
> > Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
> >  [<c025eed4>] cfq_put_request+0xcc/0x119
> >  [<c0252520>] elv_put_request+0x25/0x27
> >  [<c02553a5>] __blk_put_request+0x66/0xab
> >  [<c0256647>] end_that_request_last+0x6a/0x10b
> >  [<c029d836>] scsi_end_request+0xbf/0xe6
> >  [<c029db11>] scsi_io_completion+0x117/0x4b6
> >  [<c029b2e2>] scsi_delete_timer+0x1a/0x66
> >  [<c02a9290>] sd_rw_intr+0x89/0x30f
> >  [<c0114472>] rebalance_tick+0xac/0xbb
> >  [<c0298e8a>] scsi_finish_command+0x85/0xd9
> >  [<c0298d9d>] scsi_softirq+0xb7/0xdd
> >  [<c011cba7>] __do_softirq+0xb7/0xc6
> >  [<c011cbe3>] do_softirq+0x2d/0x2f
> >  [<c01046b6>] do_IRQ+0x1e/0x24
> >  [<c0102db2>] common_interrupt+0x1a/0x20
> >  [<c01005da>] mwait_idle+0x31/0x48
> >  [<c01005a0>] cpu_idle+0x33/0x3c
> >  [<c046aa49>] start_kernel+0x175/0x1b1
> >  [<c046a4bd>] unknown_bootoption+0x0/0x1ab
> 
> It's a known issue, just not fixed yet... You can ignore the warning,
> cfq recovers the condition.

Is this an SMP machine, btw?

-- 
Jens Axboe

