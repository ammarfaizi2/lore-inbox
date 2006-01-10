Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWAJKLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWAJKLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWAJKLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:11:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57708 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751039AbWAJKLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:11:48 -0500
Date: Tue, 10 Jan 2006 11:13:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask
Message-ID: <20060110101346.GO3389@suse.de>
References: <200601092316.47938.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601092316.47938.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09 2006, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Add CDC-RAM to capability mask. This prevents udev incorrectly reporting RAM 
> capabilities for device.
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> - ---
> 
> - --- linux-2.6.15/drivers/ide/ide-cd.c.orig	2006-01-03 06:21:10.000000000 +0300
> +++ linux-2.6.15/drivers/ide/ide-cd.c	2006-01-09 00:31:32.000000000 +0300
> @@ -2905,6 +2905,8 @@ static int ide_cdrom_register (ide_drive
>  		devinfo->mask |= CDC_CLOSE_TRAY;
>  	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
>  		devinfo->mask |= CDC_MO_DRIVE;
> +	if (!CDROM_CONFIG_FLAGS(drive)->ram)
> +		devinfo->mask |= CDC_RAM;
>  
>  	devinfo->disk = info->disk;
>  	return register_cdrom(devinfo);

Thanks, patch is correct.

-- 
Jens Axboe

