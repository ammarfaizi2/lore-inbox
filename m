Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVCLIJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVCLIJc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 03:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCLIF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 03:05:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:8411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261886AbVCLIFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 03:05:02 -0500
Date: Fri, 11 Mar 2005 23:30:25 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH 5/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050312073025.GE11236@kroah.com>
References: <200503120016.j2C0Gs8D020323@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503120016.j2C0Gs8D020323@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 04:16:54PM -0800, long wrote:
> This patch includes the source code of core component of PCI Express
> Advanced Error Reporting driver.
> 
> Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>
> 
> --------------------------------------------------------------------
> diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_core.c patch-2.6.11-rc5-aerc3-split5/drivers/pci/pcie/aer/aerdrv_core.c
> --- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_core.c	1969-12-31 19:00:00.000000000 -0500
> +++ patch-2.6.11-rc5-aerc3-split5/drivers/pci/pcie/aer/aerdrv_core.c	2005-03-10 10:31:09.000000000 -0500
> @@ -0,0 +1,911 @@
> +/*
> + * Copyright (C) 2005 Intel
> + * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/pm.h>
> +#include <linux/rtc.h>
> +#include <linux/suspend.h>
> +#include <linux/acpi.h>
> +#include <linux/pci-acpi.h>
> +#include "aerdrv.h"
> +
> +LIST_HEAD(rc_list);			/* Define Root Complex List */

Static?


