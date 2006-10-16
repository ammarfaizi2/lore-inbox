Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWJPPeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWJPPeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWJPPeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:34:44 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:57794 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422663AbWJPPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:34:43 -0400
Date: Mon, 16 Oct 2006 17:34:37 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
Message-ID: <20061016153437.GL3234@rhun.haifa.ibm.com>
References: <1161013892.24237.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161013892.24237.100.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:51:32PM +0100, Alan Cox wrote:
> Use pci_get_bus_and_slot to find the router (and lock it for the kernel
> lifetime), also use pci_get_device_reverse() to walk the list finding
> calgary IOMMUs
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c linux-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c
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
>  		if (!dev)

Looks good, this part is

Acked-By: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli

