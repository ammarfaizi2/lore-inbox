Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRCCRpM>; Sat, 3 Mar 2001 12:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRCCRpC>; Sat, 3 Mar 2001 12:45:02 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28361 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129623AbRCCRow>;
	Sat, 3 Mar 2001 12:44:52 -0500
Message-ID: <3AA12D92.4E13DE89@mandrakesoft.com>
Date: Sat, 03 Mar 2001 12:44:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pci_release_region and pci_request_region
In-Reply-To: <3AA10A1B.890D3D99@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 2.4.3-pre1 has been uploaded.  The following drivers will
> not work as modules:
> 
> ./drivers/net/via-rhine.c
> ./drivers/net/yellowfin.c
> ./drivers/net/epic100.c
> ./drivers/net/8139too.c
> ./drivers/net/rcpci45.c
> ./drivers/net/sundance.c

Bah, life is so much better when everything is compiled into the kernel
anyway :)


> --- linux-2.4.3-pre1/drivers/pci/pci.c  Sat Mar  3 20:52:24 2001
> +++ linux-akpm/drivers/pci/pci.c        Sun Mar  4 02:01:07 2001
> @@ -1367,6 +1367,8 @@
>  EXPORT_SYMBOL(pci_root_buses);
>  EXPORT_SYMBOL(pci_enable_device);
>  EXPORT_SYMBOL(pci_find_capability);
> +EXPORT_SYMBOL(pci_release_regions);
> +EXPORT_SYMBOL(pci_request_regions);
>  EXPORT_SYMBOL(pci_find_class);
>  EXPORT_SYMBOL(pci_find_device);
>  EXPORT_SYMBOL(pci_find_slot);

Thanks,

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
