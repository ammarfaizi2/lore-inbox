Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbUKRSoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUKRSoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUKRSmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:42:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40901 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262862AbUKRSlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:41:22 -0500
Date: Thu, 18 Nov 2004 19:40:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit LOG_SENSE and LOG_SELECT in SG_IO command table
Message-ID: <20041118184052.GN26240@suse.de>
References: <419CEB08.4010406@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419CEB08.4010406@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18 2004, Daniel Drake wrote:
> Hi,
> 
> This patch adds LOG_SENSE as a read-ok command. cdrecord-prodvd uses this.
> I also added LOG_SELECT as write-ok as this seems to fit in as well.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

Acked-by: Jens Axboe <axboe@suse.de>

> --- linux/drivers/block/scsi_ioctl.c.orig	2004-11-18 18:18:49.666216472 +0000
> +++ linux/drivers/block/scsi_ioctl.c	2004-11-18 18:22:50.271638888 +0000
> @@ -127,6 +127,7 @@ static int verify_command(struct file *f
>  		safe_for_read(INQUIRY),
>  		safe_for_read(MODE_SENSE),
>  		safe_for_read(MODE_SENSE_10),
> +		safe_for_read(LOG_SENSE),
>  		safe_for_read(START_STOP),
>  		safe_for_read(GPCMD_VERIFY_10),
>  		safe_for_read(VERIFY_16),
> @@ -169,6 +170,7 @@ static int verify_command(struct file *f
>  		safe_for_write(ERASE),
>  		safe_for_write(GPCMD_MODE_SELECT_10),
>  		safe_for_write(MODE_SELECT),
> +		safe_for_write(LOG_SELECT),
>  		safe_for_write(GPCMD_BLANK),
>  		safe_for_write(GPCMD_CLOSE_TRACK),
>  		safe_for_write(GPCMD_FLUSH_CACHE),


-- 
Jens Axboe

