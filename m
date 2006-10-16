Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWJPQIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWJPQIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbWJPQIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:08:04 -0400
Received: from colin.muc.de ([193.149.48.1]:57096 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1422700AbWJPQIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:08:01 -0400
Date: 16 Oct 2006 18:07:59 +0200
Date: Mon, 16 Oct 2006 18:07:59 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
Message-ID: <20061016160759.GA14354@muc.de>
References: <1161013892.24237.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161013892.24237.100.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux.vanilla-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 15:10:06.000000000 +0100
> +++ linux-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 17:14:40.000000000 +0100
> @@ -879,7 +879,7 @@
>  
>  error:
>  	do {
> -		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
> +		dev = pci_get_device_reverse(PCI_VENDOR_ID_IBM,
>  					      PCI_DEVICE_ID_IBM_CALGARY,
>  					      dev);

No put call anywhere?

-Andi
