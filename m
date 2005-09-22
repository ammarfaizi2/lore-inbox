Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVIVCgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVIVCgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVIVCgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:36:42 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41639 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965213AbVIVCgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:36:42 -0400
Message-ID: <433218B2.9040908@pobox.com>
Date: Wed, 21 Sep 2005 22:36:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Currid <ACurrid@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc1] Fix broken NVIDIA device ID in sata_nv
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1CD6@hqemmail02.nvidia.com>
In-Reply-To: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1CD6@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.9 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andy Currid wrote: > Please apply this patch that
	corrects an NVIDIA SATA device ID in > 2.6.14-rc1. > @@ -158,6 +158,8
	@@ static struct pci_device_id nv_pci_tbl[] > PCI_ANY_ID, PCI_ANY_ID,
	0, 0, MCP51 }, > { PCI_VENDOR_ID_NVIDIA,
	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA, > PCI_ANY_ID, PCI_ANY_ID, 0, 0,
	MCP55 }, > + { PCI_VENDOR_ID_NVIDIA,
	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2, > + PCI_ANY_ID, PCI_ANY_ID, 0,
	0, MCP55 }, > { PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, > PCI_ANY_ID,
	PCI_ANY_ID, > PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC }, [...] 
	Content analysis details:   (0.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.9 UPPERCASE_50_75        message body is 50-75% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Currid wrote:
> Please apply this patch that corrects an NVIDIA SATA device ID in
> 2.6.14-rc1.

> @@ -158,6 +158,8 @@ static struct pci_device_id nv_pci_tbl[]
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  		PCI_ANY_ID, PCI_ANY_ID,
>  		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },

I am applying this patch, but note that it does not "fix" anything.  It 
simply adds a new PCI ID, for additional hardware support.

	Jeff


