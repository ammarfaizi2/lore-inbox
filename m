Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271120AbVBFFH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbVBFFH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272718AbVBFFH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:07:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53937 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262165AbVBFFHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:07:19 -0500
Message-ID: <4205A5F3.9050804@pobox.com>
Date: Sun, 06 Feb 2005 00:06:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martins Krikis <mkrikis@yahoo.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 2.4.29] libata: fix ata_piix on ICH6R in RAID mode
References: <87d5vjtzf5.fsf@yahoo.com>
In-Reply-To: <87d5vjtzf5.fsf@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martins Krikis wrote:
> --- linux-2.4.29/drivers/scsi/libata-core.c	2005-01-25 20:55:41.000000000 -0500
> +++ linux-2.4.29-iswraid/drivers/scsi/libata-core.c	2005-02-01 20:23:51.000000000 -0500
> @@ -3597,7 +3597,8 @@ int ata_pci_init_one (struct pci_dev *pd
>  	else
>  		port[1] = port[0];
>  
> -	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0) {
> +	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0
> +	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
>  		/* TODO: support transitioning to native mode? */
>  		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
>  		mask = (1 << 2) | (1 << 0);

applied

