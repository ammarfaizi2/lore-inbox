Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUI1ASN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUI1ASN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUI1ASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 20:18:13 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:16004 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S266561AbUI1ASL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 20:18:11 -0400
Subject: Re: thinkpad issue --No PCMCIA hotplug activity when onboard nic
	(e1000) down
From: Dax Kelson <dax@gurulabs.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040927230458.F26680@flint.arm.linux.org.uk>
References: <1096317629.4075.65.camel@mentorng.gurulabs.com>
	 <20040927215304.E26680@flint.arm.linux.org.uk>
	 <1096319165.4075.78.camel@mentorng.gurulabs.com>
	 <20040927230458.F26680@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1096330668.5366.6.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 18:17:59 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 16:04, Russell King wrote:

> Can you try this patch please?  Thanks.
> 
> ===== drivers/pcmcia/yenta_socket.c 1.59 vs edited =====
> --- 1.59/drivers/pcmcia/yenta_socket.c	2004-08-22 15:39:15 +01:00
> +++ edited/drivers/pcmcia/yenta_socket.c	2004-09-27 23:03:57 +01:00
> @@ -1091,6 +1091,7 @@
>  	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4410, TI12XX),
>  	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4450, TI12XX),
>  	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4451, TI12XX),
> +	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4520, TI12XX),
>  
>  	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1250, TI1250),
>  	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1410, TI1250),
> ===== include/linux/pci_ids.h 1.176 vs edited =====
> --- 1.176/include/linux/pci_ids.h	2004-08-28 19:46:04 +01:00
> +++ edited/include/linux/pci_ids.h	2004-09-27 23:03:54 +01:00
> @@ -734,6 +734,7 @@
>  #define PCI_DEVICE_ID_TI_1251B		0xac1f
>  #define PCI_DEVICE_ID_TI_4410		0xac41
>  #define PCI_DEVICE_ID_TI_4451		0xac42
> +#define PCI_DEVICE_ID_TI_4520		0xac46
>  #define PCI_DEVICE_ID_TI_1410		0xac50
>  #define PCI_DEVICE_ID_TI_1420		0xac51
>  #define PCI_DEVICE_ID_TI_1451A		0xac52

I'm EXTREMELY happy to report that this patch works and I can now
hotplug PCMCIA devices successfully on my Thinkpad T42p.

>From my perspective, please apply.

Dax Kelson
Guru Labs

