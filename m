Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129186AbQKPPvA>; Thu, 16 Nov 2000 10:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKPPuv>; Thu, 16 Nov 2000 10:50:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7950 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129186AbQKPPuq>;
	Thu, 16 Nov 2000 10:50:46 -0500
Date: Thu, 16 Nov 2000 16:20:27 +0100
From: Jens Axboe <axboe@suse.de>
To: John Cavan <johncavan@home.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Patch to fix lockup on ppa insert
Message-ID: <20001116162027.C597@suse.de>
In-Reply-To: <3A13D4BA.AD4A580B@home.com> <3A13D8D6.8C12E31A@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A13D8D6.8C12E31A@home.com>; from johncavan@home.com on Thu, Nov 16, 2000 at 07:53:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16 2000, John Cavan wrote:
> > Similar to the imm patch, it's working for me.
> > 
> > John
> 
> Again... not all screwed up...
> patch -ur linux.clean/drivers/scsi/ppa.h linux.current/drivers/scsi/ppa.h
> --- linux.clean/drivers/scsi/ppa.h	Thu Sep 14 20:27:05 2000
> +++ linux.current/drivers/scsi/ppa.h	Thu Nov 16 07:26:38 2000
> @@ -170,7 +170,7 @@
>  		eh_device_reset_handler:	NULL,			\
>  		eh_bus_reset_handler:		ppa_reset,		\
>  		eh_host_reset_handler:		ppa_reset,		\
> -		use_new_eh_code:		1,			\
> +		use_new_eh_code:		0,			\

Wouldn't it be more interesting to fix the reason the new error
handling code dies with imm and ppa?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
