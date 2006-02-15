Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945911AbWBOKMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbWBOKMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWBOKMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:12:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41992 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751092AbWBOKMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:12:35 -0500
Date: Wed, 15 Feb 2006 10:12:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove duplicate #includes
Message-ID: <20060215101227.GD21003@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060213093959.GA10496@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213093959.GA10496@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:39:59AM +0100, Herbert Poetzl wrote:
> diff -NurpP --minimal linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop321-setup.c linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop321-setup.c
> --- linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop321-setup.c	2006-02-07 11:52:06 +0100
> +++ linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop321-setup.c	2006-02-13 01:14:57 +0100
> @@ -13,7 +13,6 @@
>  #include <linux/mm.h>
>  #include <linux/init.h>
>  #include <linux/config.h>
> -#include <linux/init.h>
>  #include <linux/major.h>
>  #include <linux/fs.h>
>  #include <linux/platform_device.h>
> diff -NurpP --minimal linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop331-setup.c linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop331-setup.c
> --- linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop331-setup.c	2006-02-07 11:52:06 +0100
> +++ linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop331-setup.c	2006-02-13 01:15:09 +0100
> @@ -12,7 +12,6 @@
>  #include <linux/mm.h>
>  #include <linux/init.h>
>  #include <linux/config.h>
> -#include <linux/init.h>
>  #include <linux/major.h>
>  #include <linux/fs.h>
>  #include <linux/platform_device.h>
> diff -NurpP --minimal linux-2.6.16-rc2/arch/arm/plat-omap/pm.c linux-2.6.16-rc2-mpf/arch/arm/plat-omap/pm.c
> --- linux-2.6.16-rc2/arch/arm/plat-omap/pm.c	2006-01-03 17:29:08 +0100
> +++ linux-2.6.16-rc2-mpf/arch/arm/plat-omap/pm.c	2006-02-13 01:15:24 +0100
> @@ -38,7 +38,6 @@
>  #include <linux/pm.h>
>  #include <linux/sched.h>
>  #include <linux/proc_fs.h>
> -#include <linux/pm.h>
>  #include <linux/interrupt.h>
>  
>  #include <asm/io.h>
> diff -NurpP --minimal linux-2.6.16-rc2/drivers/video/s3c2410fb.c linux-2.6.16-rc2-mpf/drivers/video/s3c2410fb.c
> --- linux-2.6.16-rc2/drivers/video/s3c2410fb.c	2006-02-07 11:52:57 +0100
> +++ linux-2.6.16-rc2-mpf/drivers/video/s3c2410fb.c	2006-02-13 01:38:19 +0100
> @@ -82,7 +82,6 @@
>  #include <linux/fb.h>
>  #include <linux/init.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/string.h>
>  #include <linux/interrupt.h>
>  #include <linux/workqueue.h>
>  #include <linux/wait.h>

Thanks, I've applied just the above bits of the patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
