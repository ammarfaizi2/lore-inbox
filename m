Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTIJHLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbTIJHLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:11:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51590 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264851AbTIJHLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:11:31 -0400
Date: Wed, 10 Sep 2003 09:11:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gscd - get rid of warning.
Message-ID: <20030910071129.GF20800@suse.de>
References: <20030909152841.25f7181f.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909152841.25f7181f.shemminger@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09 2003, Stephen Hemminger wrote:
> Compiler warning on 2.6.0-test5 indicates a problem because of missing equal sign.
> 
> diff -Nru a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
> --- a/drivers/cdrom/gscd.c	Tue Sep  9 15:25:50 2003
> +++ b/drivers/cdrom/gscd.c	Tue Sep  9 15:25:50 2003
> @@ -965,7 +965,7 @@
>  
>  	gscd_queue = blk_init_queue(do_gscd_request, &gscd_lock);
>  	if (!gscd_queue) {
> -		ret -ENOMEM;
> +		ret = -ENOMEM;
>  		goto err_out3;
>  	}

No discussion, thanks :)

-- 
Jens Axboe

