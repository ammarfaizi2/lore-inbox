Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUJIRVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUJIRVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUJIRVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:21:22 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:25799 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S266748AbUJIRVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:21:21 -0400
Subject: Re: [RFT 2.6] ebus.c replace pci_find_device with pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       davem@davemloft.net, ecd@skynet.be, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org
In-Reply-To: <87310000.1097276022@w-hlinder.beaverton.ibm.com>
References: <87310000.1097276022@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097342474.3903.19.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 10:21:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:53, Hanna Linder wrote:
> @@ -528,7 +528,7 @@ static struct pci_dev *find_next_ebus(st
>  	struct pci_dev *pdev = start;
>  
>  	do {
> -		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
> +		pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
>  		if (pdev &&
>  		    (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
>  		     pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))

ebus_init() needs pci_put_dev(pdev) cleanup.

-scott

