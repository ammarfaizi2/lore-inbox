Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUJIRQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUJIRQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUJIRQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:16:28 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:62406 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S266912AbUJIRQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:16:23 -0400
Subject: Re: [KJ] [RFT 2.6] isa.c replace pci_find_device with
	pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, ecd@skynet.be,
       anton@samba.org, jj@sunsite.ms.mff.cuni.cz, greg@kroah.com,
       davem@davemloft.net
In-Reply-To: <84880000.1097274972@w-hlinder.beaverton.ibm.com>
References: <84880000.1097274972@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097342176.3903.16.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 10:16:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:36, Hanna Linder wrote:
> @@ -262,7 +262,7 @@ void __init isa_init(void)
>  	device = PCI_DEVICE_ID_AL_M1533;
>  
>  	pdev = NULL;
> -	while ((pdev = pci_find_device(vendor, device, pdev)) != NULL) {
> +	while ((pdev = pci_get_device(vendor, device, pdev)) != NULL) {
>  		struct pcidev_cookie *pdev_cookie;
>  		struct pci_pbm_info *pbm;
>  		struct sparc_isa_bridge *isa_br;

for_each_pci_dev?

-scott

