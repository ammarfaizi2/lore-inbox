Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbUKRMMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbUKRMMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUKRML7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:11:59 -0500
Received: from mail.renesas.com ([202.234.163.13]:25596 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262749AbUKRMLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:11:03 -0500
Date: Thu, 18 Nov 2004 21:10:48 +0900 (JST)
Message-Id: <20041118.211048.628179754.takata.hirokazu@renesas.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: Re: 2.6.10-rc2-mm2
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
References: <20041118021538.5764d58c.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

From: Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc2-mm2
Date: Thu, 18 Nov 2004 02:15:38 -0800
> 
> +m32r-fix-build-error-of.patch
> 
>  m32r build fix

Please drop this patch from -mm tree.
Again, the patch was prepared for not -mm-tree but bk-tree.

# The -mm tree is sometimes too experimental for developing and
# maintaining our new m32r port.
# I don't have good idea...

Thank you.


From: Hirokazu Takata <takata@linux-m32r.org>
Subject: [PATCH 2.6.10-rc2-bk1] m32r: Fix build error of arch/m32r/mm/fault.c
Date: Wed, 17 Nov 2004 11:46:31 +0900 (JST)
> Hi,
> 
> Please drop "Changes for arch/m32r/mm/fault.c@1.3" or 
> apply the attached patch to bk-tree for m32r.
> 
> The modification of "Changes for arch/m32r/mm/fault.c@1.3" was
> prepared for enforce-a-gap-between-heap-and-stack.patch(*) of -mm tree,
> but it has not been merged into mainline.
>   (*) "heap-stack-gap for 2.6" (Sep. 25, 2004)
>        http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.3/0435.html
> 
> So, this patch is for withdrawing the previous arch/m32r/mm/fault.c.
> 
> Thanks.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> ---
> 
>  arch/m32r/mm/fault.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
> --- a/arch/m32r/mm/fault.c	2004-11-15 12:16:47.000000000 +0900
> +++ b/arch/m32r/mm/fault.c	2004-11-17 10:54:24.000000000 +0900
> @@ -182,7 +182,7 @@ asmlinkage void do_page_fault(struct pt_
>  			goto bad_area;
>  	}
>  #endif
> -	if (expand_stack(vma, address, NULL))
> +	if (expand_stack(vma, address))
>  		goto bad_area;
>  /*
>   * Ok, we have a good vm_area for this memory access, so
> 
> --
> Hirokazu Takata <takata@linux-m32r.org>
> Linux/M32R Project:  http://www.linux-m32r.org/

-- Takata





