Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUG1RSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUG1RSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUG1RSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:18:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33761 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267345AbUG1RPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:15:22 -0400
Message-ID: <4107DF1D.4070405@pobox.com>
Date: Wed, 28 Jul 2004 13:15:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH 2.6.8-rc2] include/linux/ata.h
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF05A1844D@mail-sc-6-bk.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF05A1844D@mail-sc-6-bk.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> The macros ata_id_has_lba() and ata_id_has_dma() seem to have their bits
> reversed.  LBA support is bit 9 of word 49 in the identify page, whereas
> DMA support is bit 8 of word 49 in the identify page.
> 
> 
> --- ata.original.h	2004-07-19 17:49:26.000000000 -0700
> +++ ata.h	2004-07-19 17:49:05.000000000 -0700
> @@ -209,8 +209,8 @@
>  #define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
>  #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
>  #define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
> -#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 8))
> -#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 9))
> +#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 9))
> +#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 8))
>  #define ata_id_removeable(dev)	((dev)->id[0] & (1 << 7))
>  #define ata_id_u32(dev,n)	\
>  	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))


Patch looks good, but please submit patches generated from the base of 
the kernel tree, so that "patch -sp1 < patch" successfully applies your 
patch.

I am applying this patch manually...

	Jeff


