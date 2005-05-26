Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVEZJpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVEZJpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVEZJnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:43:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42388 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261289AbVEZJlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:41:52 -0400
Date: Thu, 26 May 2005 11:41:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: swsusp: ahd_dv_0 can't be stopped
Message-ID: <20050526094135.GD1925@elf.ucw.cz>
References: <1117090835.8059.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117090835.8059.3.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I suppose the driver wants to set PF_NOFREEZE? Anyway, setting PF_FREEZE
> isn't correct to me.

Applied, will push upstream soon.
									Pavel

>  linux-2.6.11-rc5-mm1-root/drivers/scsi/aic7xxx/aic79xx_osm.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/scsi/aic7xxx/aic79xx_osm.c~ahd_dv drivers/scsi/aic7xxx/aic79xx_osm.c
> --- linux-2.6.11-rc5-mm1/drivers/scsi/aic7xxx/aic79xx_osm.c~ahd_dv	2005-05-26 14:42:41.191427928 +0800
> +++ linux-2.6.11-rc5-mm1-root/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-05-26 14:43:10.396988008 +0800
> @@ -2488,7 +2488,7 @@ ahd_linux_dv_thread(void *data)
>  	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
>  #else
>  	daemonize("ahd_dv_%d", ahd->unit);
> -	current->flags |= PF_FREEZE;
> +	current->flags |= PF_NOFREEZE;
>  #endif
>  	unlock_kernel();
>  
> _
> 

-- 
