Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286804AbSABHcz>; Wed, 2 Jan 2002 02:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286807AbSABHco>; Wed, 2 Jan 2002 02:32:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34058 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286804AbSABHc2>;
	Wed, 2 Jan 2002 02:32:28 -0500
Date: Wed, 2 Jan 2002 08:32:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel BUG at scsi_merge.c:83
Message-ID: <20020102083223.J16092@suse.de>
In-Reply-To: <m2zo3xr0qu.fsf@pengo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zo3xr0qu.fsf@pengo.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02 2002, Peter Osterlund wrote:
> Hi!
> 
> While doing some stress testing on the 2.5.2-pre5 kernel, I am hitting
> a kernel BUG at scsi_merge.c:83, followed by a kernel panic. The
> problem is that scsi_alloc_sgtable fails because the request contains
> too many physical segments. I think this patch is the correct fix:

Correct, ll_rw_blk default is ok now. I missed this when killing
scsi_malloc/scsi_dma, thanks.

-- 
Jens Axboe

