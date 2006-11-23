Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756989AbWKWMJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbWKWMJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757351AbWKWMJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:09:56 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:24081 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1756989AbWKWMJz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:09:55 -0500
Date: Thu, 23 Nov 2006 13:09:38 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, i2c@lm-sensors.org
Subject: Re: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
Message-Id: <20061123130938.5818ad16.khali@linux-fr.org>
In-Reply-To: <200611221519.12373.jason.d.gaston@intel.com>
References: <200611221519.12373.jason.d.gaston@intel.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, 22 Nov 2006 15:19:12 -0800, Jason Gaston wrote:
> This updated patch adds the Intel ICH9 LPC and SMBus Controller DID's.
> This patch relies on the irq ICH9 patch to pci_ids.h.

Looks good. Care to also update Documentation/i2c/busses/i2c-i801? I
see it misses at least the ICH8 and ESB2 as well.

I would also appreciate an update to lm_sensors' sensors-detect script,
if you could send a patch to the sensors list.

> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/drivers/i2c/busses/i2c-i801.c.orig	2006-11-22 06:17:20.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/i2c/busses/i2c-i801.c	2006-11-22 06:27:12.000000000 -0800
> @@ -33,6 +33,7 @@
>      ICH7		27DA
>      ESB2		269B
>      ICH8		283E
> +    ICH9		2930
>      This driver supports several versions of Intel's I/O Controller Hubs (ICH).
>      For SMBus support, they are similar to the PIIX4 and are part
>      of Intel's '810' and other chipsets.
> @@ -457,6 +458,7 @@
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_6) },
>  	{ 0, }
>  };
>  
> --- linux-2.6.19-rc6/drivers/i2c/busses/Kconfig.orig	2006-11-22 07:05:25.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/i2c/busses/Kconfig	2006-11-22 07:05:36.000000000 -0800
> @@ -125,6 +125,7 @@
>  	    ICH7
>  	    ESB2
>  	    ICH8
> +	    ICH9
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.

Thanks,
-- 
Jean Delvare
