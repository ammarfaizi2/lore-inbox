Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUGBN0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUGBN0j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGBN0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:26:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9098 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264503AbUGBN0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:26:25 -0400
Date: Fri, 2 Jul 2004 15:26:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Can't open CDROM device for writing
Message-ID: <20040702132604.GT1114@suse.de>
References: <m2eknw3qqp.fsf@best.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2eknw3qqp.fsf@best.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01 2004, Peter Osterlund wrote:
> Opening a CDROM device for writing no longer works, because
> cdrom_open() returns -EROFS even if cdrom_open_write() succeeds. This
> patch for 2.6.7-bk13 fixes it.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> 
> ---
> 
>  linux-petero/drivers/cdrom/cdrom.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN drivers/cdrom/cdrom.c~cdrom-write-fix drivers/cdrom/cdrom.c
> --- linux/drivers/cdrom/cdrom.c~cdrom-write-fix	2004-07-01 13:16:27.772595136 +0200
> +++ linux-petero/drivers/cdrom/cdrom.c	2004-07-01 13:17:34.380469200 +0200
> @@ -901,6 +901,7 @@ int cdrom_open(struct cdrom_device_info 
>  				goto err;
>  			if (cdrom_open_write(cdi))
>  				goto err;
> +			ret = 0;
>  		}
>  	}

Indeed, thanks.

-- 
Jens Axboe

