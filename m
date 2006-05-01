Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWEARpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWEARpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWEARpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:45:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932178AbWEARpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:45:22 -0400
Subject: Re: + drivers-scsi-use-array_size-macro.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: tklauser@nuerscht.ch, akpm@osdl.org, linux-scsi@vger.kernel.org
In-Reply-To: <200605011717.k41HHagU001787@shell0.pdx.osdl.net>
References: <200605011717.k41HHagU001787@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 01 May 2006 19:45:19 +0200
Message-Id: <1146505519.20760.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 10:15 -0700, akpm@osdl.org wrote:
> diff -puN drivers/scsi/53c700.c~drivers-scsi-use-array_size-macro drivers/scsi/53c700.c
> --- devel/drivers/scsi/53c700.c~drivers-scsi-use-array_size-macro	2006-05-01 10:15:39.000000000 -0700
> +++ devel-akpm/drivers/scsi/53c700.c	2006-05-01 10:15:39.000000000 -0700
> @@ -316,7 +316,7 @@ NCR_700_detect(struct scsi_host_template
>  	BUG_ON(!dma_is_consistent(pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());
>  	hostdata->slots = (struct NCR_700_command_slot *)(memory + SLOTS_OFFSET);
>  	hostdata->dev = dev;
> -		
> +
>  	pSlots = pScript + SLOTS_OFFSET;
>  
>  	/* Fill in the missing routines from the host template */

noise?

> @@ -332,19 +332,18 @@ NCR_700_detect(struct scsi_host_template
>  	tpnt->slave_destroy = NCR_700_slave_destroy;
>  	tpnt->change_queue_depth = NCR_700_change_queue_depth;
>  	tpnt->change_queue_type = NCR_700_change_queue_type;
> -	
> +

more noise?
> @@ -385,17 +382,17 @@ NCR_700_detect(struct scsi_host_template
>  	host->hostdata[0] = (unsigned long)hostdata;
>  	/* kick the chip */
>  	NCR_700_writeb(0xff, host, CTEST9_REG);
> -	if(hostdata->chip710) 
> +	if (hostdata->chip710)

while a nice cleanup.. does it fit in this patch?


(many more such things snipped)



