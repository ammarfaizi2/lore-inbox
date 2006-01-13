Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161371AbWAMIDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbWAMIDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWAMIDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:03:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161371AbWAMIDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:03:46 -0500
Date: Fri, 13 Jan 2006 00:03:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] - pci_ids - adding pci device id support for FC949ES
Message-Id: <20060113000323.09cbff98.akpm@osdl.org>
In-Reply-To: <F331B95B72AFFB4B87467BE1C8E9CF5F1AA29A@NAMAIL2.ad.lsil.com>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F1AA29A@NAMAIL2.ad.lsil.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Moore, Eric" <Eric.Moore@lsil.com> wrote:
>
> Adding support for new LSI Logic Fibre Channel controller.
> 
>  Signed-off-by: Eric Moore <Eric.Moore@lsil.com>
> 
>  --- b/include/linux/pci_ids.h	2006-01-11 19:04:18.000000000 -0700
>  +++ a/include/linux/pci_ids.h	2006-01-12 14:19:43.000000000 -0700
>  @@ -181,6 +181,7 @@
>   #define PCI_DEVICE_ID_LSI_FC929X	0x0626
>   #define PCI_DEVICE_ID_LSI_FC939X	0x0642
>   #define PCI_DEVICE_ID_LSI_FC949X	0x0640
>  +#define PCI_DEVICE_ID_LSI_FC949ES	0x0646
>   #define PCI_DEVICE_ID_LSI_FC919X	0x0628
>   #define PCI_DEVICE_ID_NCR_YELLOWFIN	0x0701
>   #define PCI_DEVICE_ID_LSI_61C102	0x0901

That doesn't add support - it just adds the ID.  We've apparently decided
not to keep IDs of devices which the kernel doesn't support.

Also, there's a plan to stop using pci_ids.h - PCI IDs are supposed to go
into a driver-private header file.  I guess drivers/scsi/megaraid.h is an
example.
