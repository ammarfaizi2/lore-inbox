Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273999AbRIXQf4>; Mon, 24 Sep 2001 12:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRIXQfq>; Mon, 24 Sep 2001 12:35:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48652 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273992AbRIXQfh>;
	Mon, 24 Sep 2001 12:35:37 -0400
Date: Mon, 24 Sep 2001 18:35:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Ward Fenton <ward@amazingmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: block-highmem-all-15 has sym53c8xx.h glitch
Message-ID: <20010924183553.I1695@suse.de>
In-Reply-To: <Pine.LNX.4.21.0109241216390.10084-100000@bambam.amazingmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109241216390.10084-100000@bambam.amazingmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24 2001, Ward Fenton wrote:
> I wasn't able to compile 2.4.10 patched with Jens Axboe's latest zero
> bounce patch found below until fixing a small problem with
> drivers/scsi/sym53c8xx.h
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10/block-highmem-all-15
> 
> 
> --- v2.4.10/linux/drivers/scsi/sym53c8xx.h.orig	Mon Sep 24 12:12:29 2001
> +++ linux/drivers/scsi/sym53c8xx.h	Mon Sep 24 12:11:41 2001
> @@ -97,7 +97,7 @@
>  			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
>  			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
>  			max_sectors:    MAX_SEGMENTS*8,		\
> -			use_clustering: DISABLE_CLUSTERING},	\
> +			use_clustering: DISABLE_CLUSTERING,	\
>  			can_dma_32:	1,			\
>  			single_sg_ok:	1}

Thanks, but you're too late -- Marcus Alanen reported this 10 minutes
ago :-)

-- 
Jens Axboe

