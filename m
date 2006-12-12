Return-Path: <linux-kernel-owner+w=401wt.eu-S964786AbWLLXFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWLLXFL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLLXFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:05:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4769 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964788AbWLLXFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:05:08 -0500
Date: Wed, 13 Dec 2006 00:05:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.19-git] RTC Kconfig sorted by type
Message-ID: <20061212230517.GA28443@stusta.de>
References: <200612061652.45242.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061652.45242.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 04:52:44PM -0800, David Brownell wrote:
> This reorders the RTC driver menu into separate sections, splitting out
> the SOC, I2C, and SPI support to help make the menu easier to navigate.
> (We got some feedback a while ago that it was "a mess" and hard to make
> sense of...)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> ---
> Assumes the rtc-omap patch has been merged, and no other RTC drivers
> have been added to this Kconfig menu.
> 
> Index: at91/drivers/rtc/Kconfig
> ===================================================================
> --- at91.orig/drivers/rtc/Kconfig	2006-12-05 03:25:20.000000000 -0800
> +++ at91/drivers/rtc/Kconfig	2006-12-05 03:46:53.000000000 -0800
> @@ -1,4 +1,4 @@
> -\#
> +#
>  # RTC class/drivers configuration
>  #
>  
> @@ -20,6 +20,8 @@ config RTC_CLASS
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-class.
>  
> +if RTC_CLASS != n
> +


if RTC_CLASS


because otherwise


>  config RTC_HCTOSYS
>  	bool "Set system time from RTC on startup"
>  	depends on RTC_CLASS = y
> @@ -45,11 +47,10 @@ config RTC_DEBUG
>  	  and individual RTC drivers.
>  
>  comment "RTC interfaces"
> -	depends on RTC_CLASS
>  
>  config RTC_INTF_SYSFS
>  	tristate "sysfs"
> -	depends on RTC_CLASS && SYSFS
> +	depends on SYSFS
>...


RTC_CLASS=m, RTC_INTF_SYSFS=y would be an allowed configuration.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

