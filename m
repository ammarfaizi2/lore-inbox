Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292295AbSBTUwZ>; Wed, 20 Feb 2002 15:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292302AbSBTUwW>; Wed, 20 Feb 2002 15:52:22 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:12939 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292295AbSBTUwE>; Wed, 20 Feb 2002 15:52:04 -0500
Message-ID: <XFMail.020220214017.pirx@minet.uni-jena.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20020220200135.GA706@petreley.com>
Date: Wed, 20 Feb 2002 21:40:17 +0100 (CET)
Reply-To: pirx@minet.uni-jena.de
From: 520042182928-0001@t-online.de (Martin Huenniger)
To: Nicholas Petreley <nicholas@petreley.com>
Subject: Re: patch to NVIDIA_kernel & kernel 2.5.5
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello 

Oh right this is an mistake (darn!!!) But it leads only ;-) to problems when
compiled for kernel < 2.5.0

On 20-Feb-02 Nicholas Petreley wrote:
> I think you may not have meant to do this part of the patch in nv.c:
> 
> +/*         
>              if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
> +*/
> +           if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
>                 return -EAGAIN;
> 
> 
> How about this instead:
> 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>              if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
>                   return -EAGAIN;
> +#else
> +            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> +                 return -EAGAIN;
> +#endif
> 
> 
> 
> 
> -- 
> ***********************************************************
> Nicholas Petreley        http://www.VarLinux.org
> nicholas@petreley.com    http://www.computerworld.com
> http://www.petreley.org  http://www.linuxworld.com Eph 6:12
> ***********************************************************
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-----------------------------------------------
E-Mail: Martin Huenniger <pirx@minet.uni-jena.de>
Date: 20-Feb-02
Time: 21:40:17
-----------------------------------------------
