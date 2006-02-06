Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWBFVLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWBFVLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWBFVLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:11:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750843AbWBFVLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:11:07 -0500
Date: Mon, 6 Feb 2006 22:07:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH] block: undeprecate ll_rw_block()
Message-ID: <20060206210705.GC5276@suse.de>
References: <1139254591.17774.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139254591.17774.5.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2006, Pekka Enberg wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch removes the DEPRECATED comment from ll_rw_block(). The function
> is still in active use and there isn't any real replacement for it.

It is still deprecated, so I think the comment should stay. There are
plenty ways to accomplish what ll_rw_block does (and more efficiently,
array of bh's is not very nice to say the least) and the buffer_head
isn't even an io unit anymore.

-- 
Jens Axboe

