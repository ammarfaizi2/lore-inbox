Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWAKMl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWAKMl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWAKMl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:41:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31237 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751420AbWAKMl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:41:27 -0500
Date: Fri, 6 Jan 2006 20:28:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][-mm]kedac not stopped at suspend
Message-ID: <20060106202824.GA2736@ucw.cz>
References: <1136862067.5435.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136862067.5435.4.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-01-06 11:01:01, Shaohua Li wrote:
> kedac thread doesn't stop at suspend time.
> http://bugzilla.kernel.org/show_bug.cgi?id=5849
> 
> Thanks,
> Shaohua
> ---
> 
>  linux-2.6.15-root/drivers/edac/edac_mc.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> diff -puN drivers/edac/edac_mc.c~edac drivers/edac/edac_mc.c
> --- linux-2.6.15/drivers/edac/edac_mc.c~edac	2006-01-09 09:47:18.000000000 +0800
> +++ linux-2.6.15-root/drivers/edac/edac_mc.c	2006-01-09 09:59:26.000000000 +0800
> @@ -2072,6 +2072,8 @@ static int edac_kernel_thread(void *arg)
>  		if(signal_pending(current))
>  			flush_signals(current);
>  
> +		try_to_freeze();
> +
>  		/* ensure we are interruptable */
>  		set_current_state(TASK_INTERRUPTIBLE);

Should be already fixed....

								Pavel
-- 
Thanks, Sharp!
