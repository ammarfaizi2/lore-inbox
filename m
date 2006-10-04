Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWJDGLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWJDGLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJDGLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:11:16 -0400
Received: from mail.portrix.net ([212.202.157.208]:41636 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1030381AbWJDGLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:11:11 -0400
Message-ID: <45235042.4090201@l4x.org>
Date: Wed, 04 Oct 2006 08:10:10 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060812 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Lennart Poettering <mzxreary@0pointer.de>
CC: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, dtor@insightbb.com, akpm@osdl.org
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, fifth try
References: <20061004024927.GA27716@ecstasy.ring2.lan>
In-Reply-To: <20061004024927.GA27716@ecstasy.ring2.lan>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Poettering wrote:
> This is the fifth version of this driver. Changes to the previous
> version are mostly cosmetics: on request of Andrew Morton I replaced
> indentation with spaces by tabs (by passing it through "unexpand"). 

> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -384,6 +384,8 @@ extern int ec_transaction(u8 command,
>  				   wdata_len, rdata, rdata_len);
>  }
>  
> +EXPORT_SYMBOL(ec_transaction);
> +
>  static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
>  {
>  	int result;
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7fc692a..d25b0db 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -28,5 +28,24 @@ config IBM_ASM
>  
>  	  If unsure, say N.
>  
> +config MSI_LAPTOP
> +        tristate "MSI Laptop Extras"
> +        depends on X86
> +        depends on ACPI_EC
> +        depends on BACKLIGHT_CLASS_DEVICE
> +        ---help---
> +          This is a driver for laptops built by MSI (MICRO-STAR 
> +	  INTERNATIONAL):
> +	      
> +	      MSI MegaBook S270 (MS-1013)
> +	      Cytron/TCM/Medion/Tchibo MD96100/SAM2000
> +	   
> +	  It adds support for Bluetooth, WLAN and LCD brightness control.
> +
> +          More information about this driver is available at
> +          <http://0pointer.de/lennart/tchibo.html>.
> +
> +          If you have an MSI S270 laptop, say Y or M here.
> +
>  endmenu

This part is still spaces only. The help text should be indented
by tab + 2 spaces.

Jan
