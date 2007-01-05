Return-Path: <linux-kernel-owner+w=401wt.eu-S1161000AbXAEIYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbXAEIYA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXAEIYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:24:00 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4391 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030364AbXAEIX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:23:59 -0500
Date: Fri, 5 Jan 2007 08:23:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] backlight control for Frontpath ProGear HX1050+
Message-ID: <20070105082351.GA32582@flint.arm.linux.org.uk>
Mail-Followup-To: Marcin Juszkiewicz <openembedded@hrw.one.pl>,
	linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
References: <200701050903.31859.openembedded@hrw.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701050903.31859.openembedded@hrw.one.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 09:03:30AM +0100, Marcin Juszkiewicz wrote:
> Index: linux-2.6.18/drivers/video/backlight/progear_bl.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18/drivers/video/backlight/progear_bl.c	2007-01-05 08:48:41.000000000 +0100
> +static int progearbl_probe(struct platform_device *pdev)
> +{
> +	u8 temp;
> +
> +	pmu_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 0);
> +	if(!pmu_dev) {
> +		printk("ALI M7101 PMU not found.\n"); 
> +		return(-1);

There are enumerated constants for these return values.  Please use the
proper and appropriate constants.

> +	}
> +	
> +	sb_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 0);
> +	if(!sb_dev) {
> +		printk("ALI 1533 SB not found.\n"); 
> +		return(-1);

Ditto.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
