Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSIXE6A>; Tue, 24 Sep 2002 00:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSIXE6A>; Tue, 24 Sep 2002 00:58:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261569AbSIXE6A>;
	Tue, 24 Sep 2002 00:58:00 -0400
Message-ID: <3D8FF1F1.3020808@pobox.com>
Date: Tue, 24 Sep 2002 01:02:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] linux-2.5.38 additional i2c driver ID's
References: <Pine.LNX.4.44.0209240042180.16117-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> --- linux/include/linux/i2c.h.orig	2002-09-09 13:35:04.000000000 -0400
> +++ linux/include/linux/i2c.h	2002-09-21 22:27:11.000000000 -0400
> @@ -68,6 +68,12 @@
>  union i2c_smbus_data;
>  
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,1)
> +#ifndef __exit
> +#define __exit
> +#endif
> +#endif


We don't need to be adding this to the mainline 2.5.x kernel.
2.2.x kernels are ancient.

	Jeff



