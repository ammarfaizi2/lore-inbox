Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUG0Ajj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUG0Ajj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUG0Ajj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:39:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:16576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266195AbUG0Ajf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:39:35 -0400
Date: Mon, 26 Jul 2004 17:38:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Andrew Chew" <achew@nvidia.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Message-Id: <20040726173806.7cc0e9d5.akpm@osdl.org>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrew Chew" <achew@nvidia.com> wrote:
>
> This patch updates include/linux/pci_ids.h with the CK804 audio
>  controller ID, and adds the CK804 audio controller to the
>  sound/pci/intel8x0.c audio driver.

I'm getting many workwrapped and tab-replaced patches nowadays.  Could
people pleeeeze ensure that their email clients are sending unmangled
patches?

I fixed this one up.  I usually do :(


>  --- linux-2.6.8-rc2/include/linux/pci_ids.h	2004-07-21
>  15:22:57.000000000 -0700
>  +++ linux/include/linux/pci_ids.h	2004-07-20 18:49:22.000000000
>  -0700
>  @@ -1071,6 +1071,7 @@
>   #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
>   #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
>   #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
>  +#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
>   #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
>   #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
>   #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
>  --- linux-2.6.8-rc2/sound/pci/intel8x0.c	2004-07-21
>  15:22:59.000000000 -0700
>  +++ linux/sound/pci/intel8x0.c	2004-07-20 18:52:07.000000000 -0700
>  @@ -155,6 +155,9 @@
>   #ifndef PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO
>   #define PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO	0x00ea
>   #endif
>  +#ifndef PCI_DEVICE_ID_NVIDIA_CK804_AUDIO
>  +#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO 0x0059
>  +#endif
>   

Why does the driver need this ifdef?  We just added the ID to pci_ids.h?
