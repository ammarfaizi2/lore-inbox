Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292290AbSBBOqU>; Sat, 2 Feb 2002 09:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292291AbSBBOqR>; Sat, 2 Feb 2002 09:46:17 -0500
Received: from brick.kernel.dk ([195.249.94.204]:59540 "EHLO
	burns.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S292290AbSBBOpI>; Sat, 2 Feb 2002 09:45:08 -0500
Date: Sat, 2 Feb 2002 15:44:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Roger Larsson <roger.larsson@norran.net>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Errors in the VM - detailed
Message-ID: <20020202154449.D4934@suse.de>
In-Reply-To: <200202011847.g11Ilwa14845@maila.telia.com> <Pine.LNX.4.30.0202021543310.10436-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0202021543310.10436-100000@mustard.heime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02 2002, Roy Sigurd Karlsbakk wrote:
> > Jens said earlier "Roy, please try and change
> > the queue_nr_requests assignment in ll_rw_blk:blk_dev_init() to
> > something like 2048." - Roy have you tested this too?
> 
> No ... Where do I change it?

drivers/block/ll_rw_blk.c:blk_dev_init()
{
	queue_nr_requests = 64;
	if (total_ram > MB(32))
		queue_nr_requests = 256;

Change the 256 to 2048.

-- 
Jens Axboe

