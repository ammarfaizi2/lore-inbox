Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTH3Rhy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 13:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTH3Rhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 13:37:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5015 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261893AbTH3Rhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 13:37:52 -0400
Message-ID: <3F50E0E6.2040907@pobox.com>
Date: Sat, 30 Aug 2003 13:37:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Sebastian Reichelt <Sebastian@tigcc.ticalc.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA VT8231 router detection
References: <20030830151112.550df1a6.Sebastian@tigcc.ticalc.org>
In-Reply-To: <20030830151112.550df1a6.Sebastian@tigcc.ticalc.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Reichelt wrote:
> Hello!
> 
> I have attached a trivial patch to the Linux 2.4.21 kernel (Debian
> unstable kernel-source-2.4.21 package version 2.4.21-5), to add support
> for "VIA Technologies, Inc. VT8231" as an interrupt router. I have also
> attached the output of lspci -vvv (not inline because of line breaks, is
> that OK?). Device 00:08.0, which did not have any IRQs assigned to it
> before, has gotten IRQ 9. I have used this patch for months without any
> problems, so it should be fine. Sorry if I have left out something
> important; please consider me a newbie.
[...]
> --- pci-irq.c.orig	2003-06-01 05:06:21.000000000 +0200
> +++ pci-irq.c	2003-08-30 00:17:42.000000000 +0200
> @@ -480,6 +480,7 @@
>  	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, pirq_via_get, pirq_via_set },
>  	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596, pirq_via_get, pirq_via_set },
>  	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, pirq_via_get, pirq_via_set },
> +	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, pirq_via_get, pirq_via_set },
>  
>  	{ "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set },


Well, Mr. Newbie, your patch looks fine to me :)

I'll test it out locally, and make sure it gets into 2.4 and 2.6, if 
nobody beats me to it.

	Jeff



