Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWFOOi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWFOOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWFOOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:38:56 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:54720 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030444AbWFOOiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:38:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 4/7] CCISS: use ARRAY_SIZE without intermediates
Date: Thu, 15 Jun 2006 09:38:52 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10C5249DD@cceexc23.americas.cpqcorp.net>
In-Reply-To: <200606141710.58041.bjorn.helgaas@hp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/7] CCISS: use ARRAY_SIZE without intermediates
Thread-Index: AcaQB9YjV2s7jiMFRZyK/lR0XS+y1QAgYOfA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 15 Jun 2006 14:38:53.0546 (UTC) FILETIME=[6CB68CA0:01C69089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Helgaas, Bjorn 
> Sent: Wednesday, June 14, 2006 6:11 PM
> To: Miller, Mike (OS Dev)
> Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
> Subject: [PATCH 4/7] CCISS: use ARRAY_SIZE without intermediates
> 
> It's easier to verify loop bounds if the array name is 
> mentioned the for() statement that steps through the array.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> Index: rc5-mm3/drivers/block/cciss.c
> ===================================================================
> --- rc5-mm3.orig/drivers/block/cciss.c	2006-06-14 
> 15:15:28.000000000 -0600
> +++ rc5-mm3/drivers/block/cciss.c	2006-06-14 
> 15:16:13.000000000 -0600
> @@ -104,8 +104,6 @@
>  };
>  MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
>  
> -#define NR_PRODUCTS ARRAY_SIZE(products)
> -
>  /*  board_id = Subsystem Device ID & Vendor ID
>   *  product = Marketing Name for the board
>   *  access = Address of the struct of function pointers @@ 
> -2831,14 +2829,14 @@
>  	print_cfg_table(c->cfgtable);
>  #endif /* CCISS_DEBUG */
>  
> -	for(i=0; i<NR_PRODUCTS; i++) {
> +	for(i=0; i<ARRAY_SIZE(products); i++) {
>  		if (board_id == products[i].board_id) {
>  			c->product_name = products[i].product_name;
>  			c->access = *(products[i].access);
>  			break;
>  		}
>  	}
> -	if (i == NR_PRODUCTS) {
> +	if (i == ARRAY_SIZE(products)) {
>  		printk(KERN_WARNING "cciss: Sorry, I don't know how"
>  			" to access the Smart Array controller 
> %08lx\n", 
>  				(unsigned long)board_id);
> 
