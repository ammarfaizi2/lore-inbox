Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbTIPJ1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTIPJ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:27:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261810AbTIPJ13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:27:29 -0400
Date: Tue, 16 Sep 2003 11:27:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jju@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config BLK_DEV_IDE_TCQ_DEPTH - text and real life don't match
Message-ID: <20030916092730.GC930@suse.de>
References: <Pine.LNX.4.56.0309160025510.6467@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309160025510.6467@jju_lnx.backbone.dif.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16 2003, Jesper Juhl wrote:
> 
> In drivers/ide/Kconfig you find the following help text for
> BLK_DEV_IDE_TCQ_DEPTH
> 
> "You probably just want the default of 32 here. If you enter an invalid
>  number, the default value will be used."
> 
> But the default is /not/ 32, the default is 8. The patch bellow changes
> the default to match the help text... An alternative is of course to
> change the text to match the current default of 8, but I opted for
> changing the default in this patch.
> 
> 
> Kind regards,
> 
> Jesper Juhl <jju@dif.dk>
> 
> 
> 
> diff -u linux-2.6.0-test5-orig/drivers/ide/Kconfig linux-2.6.0-test5/drivers/ide/Kconfig
> --- linux-2.6.0-test5-orig/drivers/ide/Kconfig  2003-09-08 21:50:03.000000000 +0200
> +++ linux-2.6.0-test5/drivers/ide/Kconfig       2003-09-16 00:30:20.000000000 +0200
> @@ -471,7 +471,7 @@
>  config BLK_DEV_IDE_TCQ_DEPTH
>         int "Default queue depth"
>         depends on BLK_DEV_IDE_TCQ
> -       default "8"
> +       default "32"
>         help
>           Maximum size of commands to enable per-drive. Any value between 1
>           and 32 is valid, with 32 being the maxium that the hardware supports.

Yes that is fine, thanks.

-- 
Jens Axboe

