Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbVHXGdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVHXGdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVHXGdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:33:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751472AbVHXGdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:33:16 -0400
Date: Wed, 24 Aug 2005 16:24:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824062459.GD1553@frodo>
References: <20050823123235.GG16461@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823123235.GG16461@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Tue, Aug 23, 2005 at 02:32:36PM +0200, Jens Axboe wrote:
> ...
> +	t.pid		= current->pid;
> ...
> +/*
> + * The trace itself
> + */
> +struct blk_io_trace {
> +	u32 magic;		/* MAGIC << 8 | version */
> +	u32 sequence;		/* event number */
> +	u64 time;		/* in microseconds */
> +	u64 sector;		/* disk offset */
> +	u32 bytes;		/* transfer length */
> +	u32 action;		/* what happened */
> +	u16 pid;		/* who did it */

Also, this field (pid) should probably be a u32.

cheers.

-- 
Nathan
