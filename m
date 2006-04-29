Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWD2Gdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWD2Gdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 02:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWD2Gdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 02:33:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbWD2Gdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 02:33:42 -0400
Date: Fri, 28 Apr 2006 23:31:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: rtc-dev tweak for 64-bit kernel
Message-Id: <20060428233152.4da54d33.akpm@osdl.org>
In-Reply-To: <20060429.012519.126141613.anemo@mba.ocn.ne.jp>
References: <20060429.012519.126141613.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> Make rtc-dev more friendly to 64-bit platforms with 32-bit userland.
> This tweak is came from genrtc driver.

Please define "friendly".  It's not clear what this patch does...

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
> index b1e3e61..ae6adc4 100644
> --- a/drivers/rtc/rtc-dev.c
> +++ b/drivers/rtc/rtc-dev.c
> @@ -58,7 +58,7 @@ rtc_dev_read(struct file *file, char __u
>  	unsigned long data;
>  	ssize_t ret;
>  
> -	if (count < sizeof(unsigned long))
> +	if (count != sizeof (unsigned int) && count < sizeof (unsigned long))

We normally omit the space between "sizeof" and "(".

