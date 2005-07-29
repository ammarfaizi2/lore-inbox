Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVG2DIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVG2DIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVG2DIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:08:00 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:28039 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262126AbVG2DH3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:07:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TSBlrJD0wzw8Z+TsykbZ4inuCQsOLqZr8GaGY0ZgjILDKgCxU3M2AqNTWXdu0dIlrp6BNiB1JZYcy/lIFPDaMWH7JJov/UTDPr2FYdHuqqA+72L2PV4RcsC0DJlf4g57K+MCWmKhEJH+/cysiPVWL4LKCQSaNX0/Audo0fw9Ogw=
Message-ID: <2cd57c9005072820073091864@mail.gmail.com>
Date: Fri, 29 Jul 2005 11:07:27 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: linux-kernel@vger.kernel.org
Subject: Re: include-linux-blkdevh-extern-inline-static-inline.patch added to -mm tree
Cc: bunk@stusta.de, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200507290229.j6T2T6MP003818@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507290229.j6T2T6MP003818@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/05, akpm@osdl.org <akpm@osdl.org> wrote:
> 
> The patch titled
> 
>      include/linux/blkdev.h: "extern inline" -> "static inline"
> 
> has been added to the -mm tree.  Its filename is
> 
>      include-linux-blkdevh-extern-inline-static-inline.patch
> 

...

> 
> 
> From: Adrian Bunk <bunk@stusta.de>
> 
> "extern inline" doesn't make much sense.

"extern inline" does make sense, and it does make sense here. please
backout this patch. Hint: the address of block_size() is referenced.

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  include/linux/blkdev.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN include/linux/blkdev.h~include-linux-blkdevh-extern-inline-static-inline include/linux/blkdev.h
> --- devel/include/linux/blkdev.h~include-linux-blkdevh-extern-inline-static-inline      2005-07-28 19:28:05.000000000 -0700
> +++ devel-akpm/include/linux/blkdev.h   2005-07-28 19:28:05.000000000 -0700
> @@ -727,7 +727,7 @@ static inline unsigned int blksize_bits(
>         return bits;
>  }
> 
> -extern inline unsigned int block_size(struct block_device *bdev)
> +static inline unsigned int block_size(struct block_device *bdev)
>  {
>         return bdev->bd_block_size;
>  }



-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
