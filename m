Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVCPWex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVCPWex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVCPWex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:34:53 -0500
Received: from cantor.suse.de ([195.135.220.2]:19846 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261529AbVCPWev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:34:51 -0500
Date: Wed, 16 Mar 2005 23:32:59 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jonsmirl@gmail.com
Subject: Re: [PATCH] fbdev: Allow core fb to be built as a module
Message-ID: <20050316223259.GA18001@suse.de>
References: <200503101904.j2AJ4Yaj019164@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200503101904.j2AJ4Yaj019164@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Mar 11, Linux Kernel Mailing List wrote:

> ChangeSet 1.2187, 2005/03/10 09:14:07-08:00, jonsmirl@gmail.com
> 
> 	[PATCH] fbdev: Allow core fb to be built as a module
> 	
> 	Allow the framebuffer core to be built as a module to ease debugging.

> diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
> --- a/drivers/video/Makefile	2005-03-10 11:04:46 -08:00
> +++ b/drivers/video/Makefile	2005-03-10 11:04:46 -08:00
> @@ -8,11 +8,9 @@
>  obj-$(CONFIG_LOGO)		  += logo/
>  obj-$(CONFIG_SYSFS)		  += backlight/
>  
> -obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o
> -# Only include macmodes.o if we have FB support and are PPC
> -ifeq ($(CONFIG_FB),y)
> -obj-$(CONFIG_PPC)                 += macmodes.o
> -endif
> +obj-$(CONFIG_FB)                  += fb.o
> +fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o
> +fb-objs                           := $(fb-y)
>  
>  obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
>  obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o

How do we get macmodes back?

drivers/built-in.o(.text+0x20508): In function `.matroxfb_probe':
: undefined reference to `.mac_vmode_to_var'
make[1]: *** [.tmp_vmlinux1] Error 1

