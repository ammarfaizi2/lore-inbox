Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWAGQug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWAGQug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWAGQug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:50:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53009 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030504AbWAGQug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:50:36 -0500
Date: Sat, 7 Jan 2006 16:50:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] misc: Configurable support for PCI serial ports
Message-ID: <20060107165028.GI31384@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <15.282480653@selenic.com> <16.282480653@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16.282480653@selenic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 02:35:57AM -0600, Matt Mackall wrote:
> Configurable support for PCI serial devices
> 
> This allows disabling support for _non_-legacy PCI serial devices.

Why is the config for SERIAL_PCI in init/Kconfig rather than
drivers/serial/Kconfig ?

> --- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:27:26.000000000 -0800
> +++ 2.6.14-misc/init/Kconfig	2005-11-09 11:27:28.000000000 -0800
> @@ -473,6 +473,15 @@ config BOOTFLAG
>  	help
>  	  This enables support for the Simple Bootflag Specification.
>  
> +config SERIAL_PCI
> +	depends PCI && SERIAL_8250
> +	default y
> +	bool "Enable standard PCI serial support" if EMBEDDED
> +	help
> +	  This builds standard PCI serial support. You may be able to disable
> +          this feature if you are only need legacy serial support.
> +	  Saves about 9K.
> +
>  endmenu		# General setup
>  
>  config TINY_SHMEM

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
