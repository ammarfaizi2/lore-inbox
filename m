Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVDKGPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVDKGPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDKGPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:15:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13023 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261344AbVDKGPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:15:46 -0400
Date: Mon, 11 Apr 2005 08:12:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/ll_rw_blk.c: possible cleanups
Message-ID: <20050411061233.GW22988@suse.de>
References: <20050410181321.GE4204@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410181321.GE4204@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10 2005, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global functions:
>   - blkdev_scsi_issue_flush_fn

Kill the function completely, it is not used anymore.

>   - __blk_attempt_remerge

Normally I would say leave that since it's part of the API, but lets
just kill it. I don't envision any further users of the remerging
attempts.

> - remove the following unused EXPORT_SYMBOL's:
>   - blk_phys_contig_segment
>   - blk_hw_contig_segment
>   - blkdev_scsi_issue_flush_fn
>   - __blk_attempt_remerge
> 
> Please review which of these changes make sense.

Looks fine to me, thanks. Can you send a new patch that kills
blkdev_scsi_issue_flush_fn()?

-- 
Jens Axboe

