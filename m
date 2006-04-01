Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWDAWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWDAWQo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 17:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWDAWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 17:16:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751571AbWDAWQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 17:16:43 -0500
Date: Sun, 2 Apr 2006 00:16:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH -mm] acpi: fix memory_hotplug externs
Message-ID: <20060401221641.GC11800@stusta.de>
References: <20060328114655.05e1933f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328114655.05e1933f.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 11:46:55AM -0800, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Spell CONFIG option correctly so that externs work.
> Fixes these warnings:
> drivers/acpi/acpi_memhotplug.c:248: warning: implicit declaration of function 'add_memory'
> drivers/acpi/acpi_memhotplug.c:312: warning: implicit declaration of function 'remove_memory'
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  linsrc/linux-2616-mm2/include/linux/memory_hotplug.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- rddunlap.orig/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> +++ rddunlap/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> @@ -105,7 +105,7 @@ static inline int __remove_pages(struct 
>  }
>  
>  #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
> -	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
> +	|| defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
>  extern int add_memory(u64 start, u64 size);
>  extern int remove_memory(u64 start, u64 size);
>  #endif

What about simply offering the prototypes unconditionally?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

