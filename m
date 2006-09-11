Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWIKFBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWIKFBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIKFBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:01:41 -0400
Received: from rex.snapgear.com ([203.143.235.140]:52655 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S932105AbWIKFBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:01:41 -0400
Message-ID: <4504EDAC.9050900@snapgear.com>
Date: Mon, 11 Sep 2006 15:01:32 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: gerg@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/m68knommu/kernel/setup.c should always #include
 <asm/pgtable.h>
References: <20060904221158.GA9173@stusta.de>
In-Reply-To: <20060904221158.GA9173@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Adrian Bunk wrote:
> This patch fixes the following compile error with 
> CONFIG_BLK_DEV_INITRD=n and -Werror-implicit-function-declaration:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/m68knommu/kernel/setup.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c: In function 'setup_arch':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c:268: error: implicit declaration of function 'paging_init'
> make[2]: *** [arch/m68knommu/kernel/setup.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks, I'll push that.

Regards
Greg



> --- linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c.old	2006-09-05 00:07:42.000000000 +0200
> +++ linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c	2006-09-05 00:08:20.000000000 +0200
> @@ -36,10 +36,7 @@
>  #include <asm/setup.h>
>  #include <asm/irq.h>
>  #include <asm/machdep.h>
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
>  #include <asm/pgtable.h>
> -#endif
>  
>  unsigned long memory_start;
>  unsigned long memory_end;
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a Secure Computing Company      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
