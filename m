Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbSKXMNI>; Sun, 24 Nov 2002 07:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbSKXMNI>; Sun, 24 Nov 2002 07:13:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58271 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267203AbSKXMNH>;
	Sun, 24 Nov 2002 07:13:07 -0500
Date: Sun, 24 Nov 2002 13:20:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc3
Message-ID: <20021124122009.GX11884@suse.de>
References: <4.3.2.7.2.20021123131000.00b50100@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021123131000.00b50100@pop.t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23 2002, Margit Schubert-While wrote:
> Is this patch (rc2-rc3) correct ?
> 
> diff -urN linux-2.4.20-rc2/drivers/scsi/scsi_merge.c 
> linux-2.4.20-rc3/drivers/scsi/scsi_merge.c
> --- linux-2.4.20-rc2/drivers/scsi/scsi_merge.c  Fri Nov 22 12:14:23 2002
> +++ linux-2.4.20-rc3/drivers/scsi/scsi_merge.c  Fri Nov 22 12:14:32 2002
> @@ -835,7 +835,7 @@
>          * case.
>          */
>         if (count == 1 && !SCpnt->host->highmem_io) {
> -               this_count = req->current_nr_sectors;
> +               this_count = req->nr_sectors;
>                 goto single_segment;
>         }

Yes it is correct, why do you ask? See discussion on this list last week
between Steve Lord and myself.

-- 
Jens Axboe

