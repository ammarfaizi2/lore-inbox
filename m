Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWILDeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWILDeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWILDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:34:23 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:52784 "EHLO
	asav14.insightbb.com") by vger.kernel.org with ESMTP
	id S964894AbWILDeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:34:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAB7GBUWBT4oKLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] raw: return negative from raw_init()
Date: Mon, 11 Sep 2006 23:34:19 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060912011918.GC5192@martell.zuzino.mipt.ru>
In-Reply-To: <20060912011918.GC5192@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112334.19998.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 21:19, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/char/raw.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/char/raw.c
> +++ b/drivers/char/raw.c
> @@ -312,7 +312,7 @@ static int __init raw_init(void)
>  
>  error:
>  	printk(KERN_ERR "error register raw device\n");
> -	return 1;
> +	return -1;
>  }
>  

How about reworking it a bit to pass true error code from the failed
call? Additionally class_device_create call is not checked for errors
there.  

-- 
Dmitry
