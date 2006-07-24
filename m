Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWGXIJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWGXIJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWGXIJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:09:21 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:18617 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932093AbWGXIJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:09:20 -0400
Message-ID: <44C48010.40603@sw.ru>
Date: Mon, 24 Jul 2006 12:08:48 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
CC: James.Bottomley@SteelEye.com, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Patro, Sumant" <Sumant.Patro@lsil.com>,
       yang.bo@lsil.com
Subject: Re: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capability
 checker
References: <890BF3111FB9484E9526987D912B261902CDA9@NAMAIL3.ad.lsil.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261902CDA9@NAMAIL3.ad.lsil.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann wrote:
> Hi,
> With patch, the driver access PCIconfiguration space with dedicated 
> offset to read a signature. If the signature read, it means that the 
> controller has capability to handle 64-bit DMA. 
> Without this patch, the driver blindly claimed 64-bit DMA capability
> without checking with controller.
> The issue has been reported by Vasily Averin. 

> +	if (((magic64 == HBA_SIGNATURE_64_BIT) &&
> +		(adapter->pdev->subsystem_device !=
> +		PCI_SUBSYS_ID_MEGARAID_SATA_150_6)) ||

I would note that I've reported about issue on SATA_150_4 device. I can also
accept that similar patch fixes this issue.

> +		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC && 
> +		adapter->pdev->device == PCI_DEVICE_ID_VERDE) || 
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC && 
> +		adapter->pdev->device == PCI_DEVICE_ID_DOBSON) || 
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC && 
> +		adapter->pdev->device == PCI_DEVICE_ID_LINDSAY) || 
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_DELL && 
> +		adapter->pdev->device == PCI_DEVICE_ID_PERC4_DI_EVERGLADES) || 
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_DELL && 
> +		adapter->pdev->device == PCI_DEVICE_ID_PERC4E_DI_KOBUK)) {

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team
