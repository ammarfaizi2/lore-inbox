Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936369AbWLAK6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936369AbWLAK6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936381AbWLAK6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:58:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27334 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S936379AbWLAK6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:58:36 -0500
Date: Fri, 1 Dec 2006 11:58:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       stable@kernel.org
Subject: Re: [PATCH] PM: Fix swsusp debug mode testproc
Message-ID: <20061201105807.GD1968@elf.ucw.cz>
References: <200612011145.12787.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612011145.12787.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-12-01 11:45:12, Rafael J. Wysocki wrote:
> The 'testproc' swsusp debug mode thaws tasks twice in a row, which is _very_
> confusing.  Fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> ---
>  kernel/power/disk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.19-rc6-mm2/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.19-rc6-mm2.orig/kernel/power/disk.c	2006-11-28 22:48:35.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/kernel/power/disk.c	2006-11-29 23:46:33.000000000 +0100
> @@ -153,7 +153,7 @@ int pm_suspend_disk(void)
>  		return error;
>  
>  	if (pm_disk_mode == PM_DISK_TESTPROC)
> -		goto Thaw;
> +		return 0;
>  
>  	suspend_console();
>  	error = device_suspend(PMSG_FREEZE);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
