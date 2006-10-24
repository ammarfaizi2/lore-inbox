Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWJXN0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWJXN0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWJXN0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:26:05 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:49559 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S965113AbWJXN0C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:26:02 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH cciss: fix printk format warning
Date: Tue, 24 Oct 2006 08:25:58 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE55B23817@cceexc23.americas.cpqcorp.net>
In-Reply-To: <20061023214608.f09074e9.randy.dunlap@oracle.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH cciss: fix printk format warning
Thread-Index: Acb3J5lCUYjxJ3fKQFqLVfX3zlmnJQASD0ag
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>,
       "ISS StorageDev" <iss_storagedev@hp.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Cc: "akpm" <akpm@osdl.org>, "Jens Axboe" <jens.axboe@oracle.com>
X-OriginalArrivalTime: 24 Oct 2006 13:25:59.0668 (UTC) FILETIME=[F1CAFB40:01C6F76F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Randy Dunlap [mailto:randy.dunlap@oracle.com] 
> Sent: Monday, October 23, 2006 11:46 PM
> To: ISS StorageDev; lkml
> Cc: akpm
> Subject: [PATCH cciss: fix printk format warning
> 
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix printk format warnings:
> drivers/block/cciss.c:2000: warning: long long int format, 
> long unsigned int arg (arg 2)
> drivers/block/cciss.c:2035: warning: long long int format, 
> long unsigned int arg (arg 2)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> ---
> 
>  drivers/block/cciss.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-2619-rc3-pv.orig/drivers/block/cciss.c
> +++ linux-2619-rc3-pv/drivers/block/cciss.c
> @@ -1992,8 +1992,8 @@ cciss_read_capacity(int ctlr, int logvol
>  		*block_size = BLOCK_SIZE;
>  	}
>  	if (*total_size != (__u32) 0)
> -		printk(KERN_INFO "      blocks= %lld block_size= %d\n",
> -		*total_size, *block_size);
> +		printk(KERN_INFO "      blocks= %llu block_size= %d\n",
> +		(unsigned long long)*total_size, *block_size);
>  	kfree(buf);
>  	return;
>  }
> @@ -2027,8 +2027,8 @@ cciss_read_capacity_16(int ctlr, int log
>  		*total_size = 0;
>  		*block_size = BLOCK_SIZE;
>  	}
> -	printk(KERN_INFO "      blocks= %lld block_size= %d\n",
> -	       *total_size, *block_size);
> +	printk(KERN_INFO "      blocks= %llu block_size= %d\n",
> +	       (unsigned long long)*total_size, *block_size);
>  	kfree(buf);
>  	return;
>  }
> 
> 
> ---
> 
