Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTDXHoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTDXHoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:44:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31713 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261449AbTDXHoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:44:19 -0400
Date: Thu, 24 Apr 2003 09:56:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (4/4)
Message-ID: <20030424075618.GC8775@suse.de>
References: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl> <Pine.SOL.4.30.0304231939410.10502-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0304231939410.10502-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> diff -uNr linux-2.5.67-ac2-dtf3/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
> --- linux-2.5.67-ac2-dtf3/drivers/ide/ide-taskfile.c	Wed Apr 23 15:44:36 2003
> +++ linux/drivers/ide/ide-taskfile.c	Wed Apr 23 16:22:12 2003
> @@ -1054,6 +1054,25 @@
> 
>  EXPORT_SYMBOL(ide_raw_taskfile);
> 
> +/*
> + * Comments to ide_diag_taskfile() apply here as well.
> + */
> +static int ide_bio_taskfile (ide_drive_t *drive, ide_task_t *args,
> +			     request_queue_t *q, struct bio *bio)
> +{

any reason you are passing q seperately instead of using &drive->queue?

-- 
Jens Axboe

