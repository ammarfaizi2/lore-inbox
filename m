Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWFWDHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWFWDHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWFWDHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:07:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29062 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751112AbWFWDHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:07:32 -0400
Message-ID: <449B5AF2.9090104@garzik.org>
Date: Thu, 22 Jun 2006 23:07:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MCP65 support for sata_nv driver
References: <1150961925.5109.6.camel@achew-linux>
In-Reply-To: <1150961925.5109.6.camel@achew-linux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> Splitting up patch and resending.
> 
> This patch adds MCP65 SATA controller support to the sata_nv driver.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> 
> 
> 
> 
> diff -uprN -X linux-2.6.16.19/Documentation/dontdiff linux-2.6.16.19.original/drivers/scsi/sata_nv.c linux-2.6.16.19/drivers/scsi/sata_nv.c
> --- linux-2.6.16.19.original/drivers/scsi/sata_nv.c	2006-05-30 17:31:44.000000000 -0700
> +++ linux-2.6.16.19/drivers/scsi/sata_nv.c	2006-06-05 17:20:48.000000000 -0700
> @@ -166,12 +166,17 @@ static const struct pci_device_id nv_pci
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  		PCI_ANY_ID, PCI_ANY_ID,
>  		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
> -	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },

Why do you want to remove the RAID PCI ID?  That was not mentioned in 
the patch description at all.

	Jeff



