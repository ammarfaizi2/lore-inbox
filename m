Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSKDJk6>; Mon, 4 Nov 2002 04:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSKDJk6>; Mon, 4 Nov 2002 04:40:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63131 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262354AbSKDJk5>;
	Mon, 4 Nov 2002 04:40:57 -0500
Date: Mon, 4 Nov 2002 10:47:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [Oops] 2.5.45-mcp2 BUG at mm/highmem.c
Message-ID: <20021104094720.GG13587@suse.de>
References: <20021104045949.GG20069@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104045949.GG20069@squish.home.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Paul wrote:
> 	Hi;
> 
> 	Testing on a system that was LVM1 based. One oops from a
> gcc3.2 compiled kernel, the other from a gcc2.95.3 compiled
> kernel. (I wish it was vanilla, but it doesnt compile with device
> mapper, needed -mcp2) [compilation failure posted by others]
> [using latest device mapper and LVM2 tools from sistina]
> 	hda and hdc, who both work with DMA under 2.4.19,

It's a generic kernel bug exposed by the device mapper. Well actually
it's a trigger I put in long ago, blk_queue_bounce() needs a few fixes
before bouncing a cloned bio works. I'll see if I can't get that done
today.

-- 
Jens Axboe

