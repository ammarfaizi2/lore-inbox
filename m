Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131846AbRAPCHh>; Mon, 15 Jan 2001 21:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131999AbRAPCH2>; Mon, 15 Jan 2001 21:07:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17413 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131846AbRAPCHR>;
	Mon, 15 Jan 2001 21:07:17 -0500
Date: Tue, 16 Jan 2001 03:07:13 +0100
From: Jens Axboe <axboe@suse.de>
To: David Michael Norris <norrisd@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre3 kernel oops from kmem_cache_create(...)
Message-ID: <20010116030713.B614@suse.de>
In-Reply-To: <20010115210433.A1799@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010115210433.A1799@purdue.edu>; from norrisd@purdue.edu on Mon, Jan 15, 2001 at 09:04:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15 2001, David Michael Norris wrote:
> During boot of the 2.4.1-pre3 kernel, I received this oops:
> 
> BUG() in slab.c:804
> EIP:	0010:[<c01251df>]
> Code:	0f 0b 83 c4 0c 8b 1b 81 fb 7c 52 27 c0 75 c2 a1 7c 52 27 c0

module_init marks loop_init __init, and ll_rw_blk:blk_dev_init calls
it too. So just remove the latter loop_init() call and it should be
fine.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
