Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUJIRCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUJIRCK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUJIRCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:02:10 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:40645 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S267195AbUJIRCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:02:07 -0400
Subject: Re: [Kernel-janitors] [PATCH 2.6][9/12] pplus.c replace
	pci_find_device with pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
In-Reply-To: <33930000.1097191565@w-hlinder.beaverton.ibm.com>
References: <33930000.1097191565@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097341320.3903.3.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 10:02:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 16:26, Hanna Linder wrote:
> -	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
> +	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
>  				   PCI_DEVICE_ID_WINBOND_82C105, dev))) {
>  		/*
>  		 * Disable LEGIRQ mode so PCI INTS are routed

Missing cleanup at the bottom of func?

	if(dev)
		pci_dev_put(dev);

-scott

