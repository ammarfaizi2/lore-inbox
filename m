Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWITNsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWITNsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWITNsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:48:05 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:25036 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751414AbWITNsC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:48:02 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]: cciss - remove unneeded spaces in output for attached volumes (resend)
Date: Wed, 20 Sep 2006 08:47:57 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE558354B5@cceexc23.americas.cpqcorp.net>
In-Reply-To: <1b270aae0609200422h511d1169na201cdeaee05a24a@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: cciss - remove unneeded spaces in output for attached volumes (resend)
Thread-Index: Acbcpwk35K22AJZ2QveUvEKTnQByAQAFDwvw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Metathronius Galabant" <m.galabant@googlemail.com>,
       "ISS StorageDev" <iss_storagedev@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
X-OriginalArrivalTime: 20 Sep 2006 13:47:58.0623 (UTC) FILETIME=[61E80AF0:01C6DCBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Metathronius Galabant [mailto:m.galabant@googlemail.com] 
> Sent: Wednesday, September 20, 2006 6:22 AM
> To: ISS StorageDev
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> Subject: [PATCH]: cciss - remove unneeded spaces in output 
> for attached volumes (resend)
> 
> Hi,
> 
> please see the following patch against the cciss driver 
> (HP/Compaq SmartArray Controllers).
> It removes the awkwards spaces after the "=" when displaying 
> the geometry of the attached volumes.
> 
> Before:
> cciss: using DAC cycles
>      blocks= 286734240 block_size= 512
>      heads= 255, sectors= 32, cylinders= 35139
> 
> After:
> cciss: using DAC cycles
>      blocks=286734240 block_size=512
>      heads=255, sectors=32, cylinders=35139
> 
> 
> The following is against 2.6.18-rc6 (and I hope gmail doesn't 
> corrupt the inline patch).
> Cheers,
> M.
> 
> 
> Signed-off-by: Metathronius Galabant <m.galabant@gmail.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> diff -ru linux-2.6.18-rc6/drivers/block/cciss.c
> linux-2.6.18-rc6-f/drivers/block/cciss.c
> --- linux-2.6.18-rc6/drivers/block/cciss.c      2006-09-11
> 15:57:54.000000000 +0200
> +++ linux-2.6.18-rc6-f/drivers/block/cciss.c    2006-09-11
> 16:32:42.000000000 +0200
> @@ -1934,7 +1934,7 @@
>         } else {                /* Get geometry failed */
>                 printk(KERN_WARNING "cciss: reading geometry 
> failed\n");
>         }
> -       printk(KERN_INFO "      heads= %d, sectors= %d, 
> cylinders= %d\n\n",
> +       printk(KERN_INFO "      heads=%d, sectors=%d, 
> cylinders=%d\n\n",
>                drv->heads, drv->sectors, drv->cylinders);  }
> 
> @@ -1962,7 +1962,7 @@
>                 *total_size = 0;
>                 *block_size = BLOCK_SIZE;
>         }
> -       printk(KERN_INFO "      blocks= %u block_size= %d\n",
> +       printk(KERN_INFO "      blocks=%u block_size=%d\n",
>                *total_size, *block_size);
>         return;
>  }
> 
