Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTFJPas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFJPaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:30:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21979 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263250AbTFJP2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:28:49 -0400
Date: Tue, 10 Jun 2003 17:42:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop 6/9 remove LO_FLAGS_BH_REMAP
Message-ID: <20030610154227.GE17164@suse.de>
References: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain> <Pine.LNX.4.44.0306101633450.2285-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101633450.2285-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10 2003, Hugh Dickins wrote:
> Jonah Sherman <jsherman@stuy.edu> pointed out back in February how
> LO_FLAGS_BH_REMAP is never actually set, since loop_init_xfer only calls
> the init for non-0 encryption type.  Fix that or scrap it?  Let's scrap
> it for now, that path (hacking values in bio instead of copying data)
> seems never to have been tested, and adds to the number of paths through
> loop: leave that optimization to some other occasion.

I agree with scrapping it, it's only really interesting for non-transfer
block direct remaps which can be done with dm or similar.

-- 
Jens Axboe

