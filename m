Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbSLDW4G>; Wed, 4 Dec 2002 17:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbSLDW4F>; Wed, 4 Dec 2002 17:56:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267156AbSLDW4F>;
	Wed, 4 Dec 2002 17:56:05 -0500
Message-ID: <3DEE89A9.2000201@pobox.com>
Date: Wed, 04 Dec 2002 18:03:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "White, Charles" <Charles.White@hp.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 cciss  patch 01 - adds support for the SA641,
 SA642 and SA6400 controllers.
References: <A2C35BB97A9A384CA2816D24522A53BB03991726@cceexc18.americas.cpqcorp.net>
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB03991726@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

White, Charles wrote:
> linux-2.4.20.cciss_p01/drivers/block/cciss.c
> --- linux-2.4.20.orig/drivers/block/cciss.c	Thu Nov 28 18:53:12 2002
> +++ linux-2.4.20.cciss_p01/drivers/block/cciss.c	Wed Dec  4
> 15:09:39 2002
> @@ -56,6 +56,11 @@
>  #include "cciss.h"
>  #include <linux/cciss_ioctl.h>
>  
> +/* remove when PCI_DEVICE_ID_COMPAQ_CCISSC is in pci_ids.h */
> +#ifndef PCI_DEVICE_ID_COMPAQ_CCISSC
> +#define PCI_DEVICE_ID_COMPAQ_CCISSC 0x46
> +#endif
> +


the patch looks simple and obvious, though I have one objection:  as the 
comment indicates, this patch hunk should instead be in 
include/linux/pci_ids.h.  There is no rule against modifying pci_ids.h 
-- please do so, and not crap up drivers with tons of these ifdefs...

