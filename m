Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319300AbSIEXGh>; Thu, 5 Sep 2002 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319302AbSIEXGg>; Thu, 5 Sep 2002 19:06:36 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:48112
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319300AbSIEXF0>; Thu, 5 Sep 2002 19:05:26 -0400
Subject: Re: 2.4.20pre5 not booting on numa-q with CONFIG_MULTIQUAD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mannthey@us.ibm.com
Cc: gone@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <1031265878.3d77de5627864@imap.linux.ibm.com>
References: <200209052221.g85MLAQ04867@w-gaughen.beaverton.ibm.com> 
	<1031265878.3d77de5627864@imap.linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 00:11:10 +0100
Message-Id: <1031267470.7834.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 23:44, mannthey@us.ibm.com wrote:
> diff -urN linux-2.4.19/drivers/pci/pci.c linux-2.4.20-pre5/drivers/pci/pci.c
> --- linux-2.4.20-pre5/drivers/pci/pci.c      Sat Sep  7 06:29:04 2002
> +++ linux-2.4.20-pre5-test/drivers/pci/pci.c Sat Sep  7 06:10:26 2002
> @@ -586,7 +586,7 @@
>                 i + 1, /* PCI BAR # */
>                 pci_resource_len(pdev, i), pci_resource_start(pdev, i),
>                 pdev->slot_name);
> -       while(--i <= 0)
> +       while(--i >= 0)
>                 pci_release_region(pdev, i);
> 
>         return -EBUSY;

Doh well spotted

