Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVADNEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVADNEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVADNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:04:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261554AbVADNEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:04:50 -0500
Date: Tue, 4 Jan 2005 13:04:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: mark older power managment as deprecated
Message-ID: <20050104130442.A18550@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	Andrew Morton <akpm@zip.com.au>
References: <20050104124659.GA22256@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050104124659.GA22256@elf.ucw.cz>; from pavel@ucw.cz on Tue, Jan 04, 2005 at 01:46:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:46:59PM +0100, Pavel Machek wrote:
> +typedef int __bitwise pm_dev_t;
>  
> -typedef int pm_dev_t;
> +#define PM_UNKNOWN_DEV	((__force pm_request_t) 0)	/* generic */
> +#define PM_SYS_DEV	((__force pm_request_t) 1)	/* system device (fan, KB controller, ...) */
> +#define PM_PCI_DEV	((__force pm_request_t) 2)	/* PCI device */
> +#define PM_USB_DEV	((__force pm_request_t) 3)	/* USB device */
> +#define PM_SCSI_DEV	((__force pm_request_t) 4)	/* SCSI device */
> +#define PM_ISA_DEV	((__force pm_request_t) 5)	/* ISA device */
> +#define	PM_MTD_DEV	((__force pm_request_t) 6)	/* Memory Technology Device */

Shouldn't these beeeeeeeeeeeeeeeeeeeeeeee pm_dev_t?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
