Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVGDK42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVGDK42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGDK41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:56:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52242 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261611AbVGDKyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:54:02 -0400
Date: Mon, 4 Jul 2005 11:53:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes 4: s/menu/menuconfig/ CPU scaling menu
Message-ID: <20050704115357.A587@flint.arm.linux.org.uk>
Mail-Followup-To: Bodo Eggert <7eggert@gmx.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz> <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz> <Pine.LNX.4.58.0507041231200.6165@be1.lrz> <Pine.LNX.4.58.0507041243070.8687@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507041243070.8687@be1.lrz>; from 7eggert@gmx.de on Mon, Jul 04, 2005 at 12:43:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 12:43:56PM +0200, Bodo Eggert wrote:
> Part 4: The CPU scaling menu.
> 
> In many config submenus, the first menu option will enable the rest 
> of the menu options. For these menus, It's appropriate to use the more 
> convenient "menuconfig" keyword.
> 
> This patch is designed for 2.6.13-rc1

This is inappropriate for ARM - take a look at the ARM Kconfig file
around those lines which you deleted.  You'll notice that ARM contains
some extra options for cpufreq which aren't offered on other
architectures.

These options should appear under the cpufreq menu, and making this
change means that they no longer do so.

> --- rc1-a/./arch/arm/Kconfig	2005-06-30 11:22:15.000000000 +0200
> +++ rc1-b/./arch/arm/Kconfig	2005-07-04 12:39:29.000000000 +0200
> @@ -516,8 +516,6 @@ endmenu
>  
>  if (ARCH_SA1100 || ARCH_INTEGRATOR)
>  
> -menu "CPU Frequency scaling"
> -
>  source "drivers/cpufreq/Kconfig"
>  
>  config CPU_FREQ_SA1100
> @@ -541,8 +539,6 @@ config CPU_FREQ_INTEGRATOR
>  
>  	  If in doubt, say Y.
>  
> -endmenu
> -
>  endif
>  
>  menu "Floating point emulation"

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
