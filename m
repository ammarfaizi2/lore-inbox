Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290677AbSBGRoF>; Thu, 7 Feb 2002 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290708AbSBGRn4>; Thu, 7 Feb 2002 12:43:56 -0500
Received: from OL10K-24.207.148.94.charter-stl.com ([24.207.148.94]:20364 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S290677AbSBGRnh>;
	Thu, 7 Feb 2002 12:43:37 -0500
Message-Id: <200202071745.g17HjPE03108@linux.local>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Josh Grebe <squash2@dropnet.net>
Reply-To: squash2@dropnet.net
To: Hanno =?iso-8859-1?q?B=F6ck?= <hanno@gmx.de>,
        David Weinehall <tao@acc.umu.se>
Subject: Re: Patch for eepro100 to support more cards
Date: Thu, 7 Feb 2002 11:45:25 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201080545Z291604-13996+15441@vger.kernel.org> <20020206132727.H1735@khan.acc.umu.se> <20020206144449Z290588-13996+17952@vger.kernel.org>
In-Reply-To: <20020206144449Z290588-13996+17952@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanno,

Patches that I had previously sent to add support for other cards were not 
accepted when I had it done like this. The fix was to ad an entry for the PCI 
ID into include/linux/pci_ids.h instead of adding defines into eepro100.c.
You might try changing that and resubmitting, it is a cleaner way to do it 
anyway.

Josh


On Wednesday 06 February 2002 08:45, Hanno Böck wrote:
> Because of some complains and as pre8 is out now, I made it again for the
> 2.4.18pre8-kernel. I hope it is okay now.
>
> I put up a site for the patch: http://www.int21.de/eepro100/
>
> The Patch adds definitions for the Intel Pro/100 VE-card to the
> eepro100-driver.
>
> --- linux-2.4.18-pre8/drivers/net/eepro100.c	Wed Feb  6 15:15:16 2002
> +++ linux/drivers/net/eepro100.c	Wed Feb  6 15:19:14 2002
> @@ -168,6 +168,9 @@
>  #ifndef PCI_DEVICE_ID_INTEL_ID1030
>  #define PCI_DEVICE_ID_INTEL_ID1030 0x1030
>  #endif
> +#ifndef PCI_DEVICE_ID_INTEL_ID1031          /* support for Intel Pro/100
> VE */ +#define PCI_DEVICE_ID_INTEL_ID1031 0x1031
> +#endif
>
>
>  static int speedo_debug = 1;
> @@ -2270,6 +2273,8 @@
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1029,
>  		PCI_ANY_ID, PCI_ANY_ID, },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
> +		PCI_ANY_ID, PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1031,     /* support for
> Intel Pro/100 VE */ PCI_ANY_ID, PCI_ANY_ID, },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
>  		PCI_ANY_ID, PCI_ANY_ID, },
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
