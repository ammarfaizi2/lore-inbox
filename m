Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRGYKAj>; Wed, 25 Jul 2001 06:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbRGYKA3>; Wed, 25 Jul 2001 06:00:29 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:61197 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S266864AbRGYKAU>; Wed, 25 Jul 2001 06:00:20 -0400
Date: Wed, 25 Jul 2001 11:50:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Satish Kumar <m_satish@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bdev manipulation at block layer level
Message-ID: <20010725115055.D834@suse.de>
In-Reply-To: <20010725091716.71588.qmail@web11502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010725091716.71588.qmail@web11502.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25 2001, Satish Kumar wrote:
> Hi,
> 
> I have a host PC connected to a disk array with
> alternate paths to an end scsi disk. 
> I attempted load balancing across paths by changing
> the b_dev & b_rdev ib the bufer_head list in
> ll_rw_block function of ll_rw_blk.c (block layer), and
> was successful in load balancing with data integrity,
> on linux 2.2.16.
> However, when I try the same stunt with a linux 2.4 (
> &2.4.2) kernel, I am seeing corruption occasionally.
> Can anyone let me know if I am missing anything ?

You must not change b_dev, that will screw the cache! Just change b_rdev
to redirect the I/O and it should work.

-- 
Jens Axboe

