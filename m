Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWINVbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWINVbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWINVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:31:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751220AbWINVbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:31:22 -0400
Date: Thu, 14 Sep 2006 14:31:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raw: return negative from raw_init()
Message-Id: <20060914143118.47d3bf62.akpm@osdl.org>
In-Reply-To: <20060912011918.GC5192@martell.zuzino.mipt.ru>
References: <20060912011918.GC5192@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 05:19:18 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

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
>  static void __exit raw_exit(void)

Rolf got there first.  Please review
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/return-better-error-codes-if-drivers-char-rawc-module-init-fails.patch
