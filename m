Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbULCK6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbULCK6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbULCK6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:58:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53642 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262139AbULCK6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:58:09 -0500
Date: Fri, 3 Dec 2004 11:57:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Olivier RAMAT <olrt@ifrance.com>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Kernel 2.6.9 oops during data transfer to noname usb key
Message-ID: <20041203105732.GK10492@suse.de>
References: <0412030857.370100@th00.idoo.com> <20041203013254.55534ef8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203013254.55534ef8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Andrew Morton wrote:
> > Nov 10 07:47:40 darkstar kernel:  [<c0103f25>]
> > kernel_thread_helper+0x5/0x10
> > Nov 10 07:47:40 darkstar kernel: SCSI error : <0 0 0 0> return code =
> > 0x70000
> > Nov 10 07:47:40 darkstar kernel: end_request: I/O error, dev sda, sector
> > 348970
> > Nov 10 07:47:40 darkstar kernel: Buffer I/O error on device sda1,
> > logical block 348907
> > Nov 10 07:47:40 darkstar kernel: lost page write due to I/O error on
> > sda1
> > Nov 10 07:47:50 darkstar kernel: ------------[ cut here ]------------
> > Nov 10 07:47:50 darkstar kernel: kernel BUG at
> > /usr/src/linux-2.6.9/drivers/block/as-iosched.c:1853!
> 
> Ouch.  Haven't seen that before.  Maybe scsi error recovery screwed up the
> request queueing.  James, have we fixed anything in that area post-2.6.9?

Yes you have, it's the old bug of queue being cleaned up with requests
pending. It should be fixed in newer kernels.

-- 
Jens Axboe

