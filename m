Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVJFJkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVJFJkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJFJkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:40:18 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:57361 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750774AbVJFJkR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:40:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pTJyR9xn+NyUPv/ccG5x1cHBjObeT3/NwbzaWjJE6k8pgVg87PIElP69h2DLOcQTYiJ48P8TJ6STL9whekrMrBYrZY0VrXyTxqPLKgj5H3r3ERcBwSaH8Wz3Iwx5RWhB67ew26NIJtPn5yb68OmrU8IbcLePsXjwgZwVpXmO9L0=
Message-ID: <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com>
Date: Thu, 6 Oct 2005 11:40:15 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Aurelien Jarno <aurelien@aurel32.net>, Lionel.Bouton@inet6.fr,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965 southbridge
In-Reply-To: <20051005205906.GA4320@farad.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051005205906.GA4320@farad.aurel32.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/5/05, Aurelien Jarno <aurelien@aurel32.net> wrote:
> Hi,
>
> Here is a patch that enables the ATA133 mode for the SiS965 southbridge
> in the SiS5513 driver.

The patch for SIS965(L) support is already in -mm tree:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/broken-out/sis5513-support-sis-965l.patch

Have you tried it?

Thanks,
Bartlomiej

> --- linux-2.6.14-rc3-git4.orig/drivers/ide/pci/sis5513.c        2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.14-rc3-git4/drivers/ide/pci/sis5513.c     2005-10-05 22:12:30.000000000 +0200
> @@ -87,6 +87,7 @@
>         u8 chipset_family;
>         u8 flags;
>  } SiSHostChipInfo[] = {
> +       { "SiS965",     PCI_DEVICE_ID_SI_965,   ATA_133  },
>         { "SiS745",     PCI_DEVICE_ID_SI_745,   ATA_100  },
>         { "SiS735",     PCI_DEVICE_ID_SI_735,   ATA_100  },
>         { "SiS733",     PCI_DEVICE_ID_SI_733,   ATA_100  },
> --- linux-2.6.14-rc3-git4.orig/include/linux/pci_ids.h  2005-10-05 22:08:49.000000000 +0200
> +++ linux-2.6.14-rc3-git4/include/linux/pci_ids.h       2005-10-05 22:13:35.000000000 +0200
> @@ -672,6 +672,7 @@
>  #define PCI_DEVICE_ID_SI_961           0x0961
>  #define PCI_DEVICE_ID_SI_962           0x0962
>  #define PCI_DEVICE_ID_SI_963           0x0963
> +#define PCI_DEVICE_ID_SI_965           0x0965
>  #define PCI_DEVICE_ID_SI_5107          0x5107
>  #define PCI_DEVICE_ID_SI_5300          0x5300
>  #define PCI_DEVICE_ID_SI_5511          0x5511
