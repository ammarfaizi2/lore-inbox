Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWD0Sfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWD0Sfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWD0Sfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:35:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:32193 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964950AbWD0Sfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:35:41 -0400
Subject: Re: [RFC: 2.6 patch] fs/read_write.c: unexport iov_shorten
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060427180331.GK3570@stusta.de>
References: <20060427180331.GK3570@stusta.de>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 11:36:37 -0700
Message-Id: <1146162997.8365.25.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 20:03 +0200, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(iov_shorten).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 23 Apr 2006
> 
> --- linux-2.6.17-rc1-mm3-full/fs/read_write.c.old	2006-04-23 15:51:52.000000000 +0200
> +++ linux-2.6.17-rc1-mm3-full/fs/read_write.c	2006-04-23 15:52:02.000000000 +0200
> @@ -436,8 +436,6 @@
>  	return seg;
>  }
>  
> -EXPORT_SYMBOL(iov_shorten);
> -
>  /* A write operation does a read from user space and vice versa */
>  #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)

While you are at it, why not move iov_shorten() to only file its
currently used from filemap.c, make it static and take it out from
uio.h ? (filemap.c may not be the right place for it, but ..)

Thanks,
Badari

