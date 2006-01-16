Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWAPL4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWAPL4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWAPL4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:56:12 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:18731 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750707AbWAPL4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:56:11 -0500
Date: Mon, 16 Jan 2006 12:56:07 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-ID: <20060116115607.GA18307@harddisk-recovery.nl>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113224252.38d8890f.rdunlap@xenotime.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 10:42:52PM -0800, Randy.Dunlap wrote:
> --- linux-2615-g9.orig/drivers/scsi/Kconfig
> +++ linux-2615-g9/drivers/scsi/Kconfig
> @@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
>  	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
>  	default y
>  
> +config SCSI_SATA_ACPI
> +	bool
> +	depends on SCSI_SATA && ACPI
> +	default y
> +

Could you add some help text over here? At first glance I got the
impression this was a host driver that works through ACPI calls, but by
reading the rest of your patches it turns out it is a suspend/resume
helper.

For quite some time we had no help text with the mysterious
"ACPI0004,PNP0A05 and PNP0A06 Container Driver", no need to add another
mysterious ACPI feature.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
