Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVAWKgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVAWKgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVAWKfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:35:44 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:63797 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261272AbVAWKc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:32:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KMkGo0X8TBC3LSp/ik6cKk5R8c7CJl9HRC6qqbzeGc/ePtPsjLGEmGUn/QEYxOQxEI4Ns5SPU5yoF+bZeVklI6cBcU4qqEvan+HPHaUCipuQ1lbmYRSCazMPVaqRD/yQpUgNgm6CusGzFFQ+Q+Dof0K7Qpf3oACT1kBGMdl9iuM=
Message-ID: <aad1205e050123023214c4fa5c@mail.gmail.com>
Date: Sun, 23 Jan 2005 18:32:54 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] loop.c: make two functions static
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050123101710.GJ3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050123101710.GJ3212@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, adrian

i always see patches which set functions and variables to static.
what's the main difference between static and non-static things?

On Sun, 23 Jan 2005 11:17:10 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch makes two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/block/loop.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> This patch was already sent on:
> - 29 Nov 2004
> 
> --- linux-2.6.10-rc1-mm3-full/drivers/block/loop.c.old  2004-11-06 20:09:10.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/block/loop.c      2004-11-06 20:09:31.000000000 +0100
> @@ -1114,7 +1114,7 @@
>  EXPORT_SYMBOL(loop_register_transfer);
>  EXPORT_SYMBOL(loop_unregister_transfer);
> 
> -int __init loop_init(void)
> +static int __init loop_init(void)
>  {
>         int     i;
> 
> @@ -1189,7 +1189,7 @@
>         return -ENOMEM;
>  }
> 
> -void loop_exit(void)
> +static void loop_exit(void)
>  {
>         int i;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Yours andyliu
