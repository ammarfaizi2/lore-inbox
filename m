Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTE1GSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTE1GSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 02:18:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33424 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264549AbTE1GSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 02:18:34 -0400
Date: Wed, 28 May 2003 08:31:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy the tag_map
Message-ID: <20030528063144.GK845@suse.de>
References: <200305280629.h4S6TLUY027859@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305280629.h4S6TLUY027859@sullivan.realtime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Milton Miller wrote:
> 
> Hi Jens
> 
> saw this on checkin ...
> 
> milton
> 
> ===== drivers/block/ll_rw_blk.c 1.171 vs edited =====
> --- 1.171/drivers/block/ll_rw_blk.c	Tue May 27 15:21:00 2003
> +++ edited/drivers/block/ll_rw_blk.c	Wed May 28 00:43:33 2003
> @@ -553,7 +553,7 @@
>  
>  	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
>  	bits = max_depth / BLK_TAGS_PER_LONG;
> -	memcpy(bqt->tag_map, bqt->tag_map, bits * sizeof(unsigned long));
> +	memcpy(bqt->tag_map, tag_map, bits * sizeof(unsigned long));

Ah thanks, yes obvious typo there! I'll send your fix on.

-- 
Jens Axboe

