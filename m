Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUJIRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUJIRPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJIRPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:15:46 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:55494 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S267251AbUJIRPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:15:43 -0400
Subject: Re: [KJ] [RFT 2.6] pci-gart.c replace pci_find_device with
	pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       ak@suse.de
In-Reply-To: <87680000.1097276112@w-hlinder.beaverton.ibm.com>
References: <87680000.1097276112@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097342134.3903.14.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 10:15:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:55, Hanna Linder wrote:
> @@ -81,7 +81,7 @@ static u32 gart_unmapped_entry; 
>  
>  #define for_all_nb(dev) \
>  	dev = NULL;	\
> -	while ((dev = pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
> +	while ((dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
>  	     if (dev->bus->number == 0 && 				     \
>  		    (PCI_SLOT(dev->devfn) >= 24) && (PCI_SLOT(dev->devfn) <= 31))

for_each_pci_dev?

-scott

