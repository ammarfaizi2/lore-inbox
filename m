Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUJLQoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUJLQoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUJLQoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:44:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:32665 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266189AbUJLQnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:43:24 -0400
Date: Tue, 12 Oct 2004 09:43:13 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: sfeldma@pobox.com
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       davem@davemloft.net, ecd@skynet.be, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org
Subject: Re: [RFT 2.6] ebus.c replace pci_find_device with pci_get_device
Message-ID: <137550000.1097599393@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1097342474.3903.19.camel@sfeldma-mobl2.dsl-verizon.net>
References: <87310000.1097276022@w-hlinder.beaverton.ibm.com> <1097342474.3903.19.camel@sfeldma-mobl2.dsl-verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 09, 2004 10:21:15 AM -0700 Scott Feldman <sfeldma@pobox.com> wrote:

> On Fri, 2004-10-08 at 15:53, Hanna Linder wrote:
>> @@ -528,7 +528,7 @@ static struct pci_dev *find_next_ebus(st
>>  	struct pci_dev *pdev = start;
>>  
>>  	do {
>> -		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
>> +		pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
>>  		if (pdev &&
>>  		    (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
>>  		     pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
> 
> ebus_init() needs pci_put_dev(pdev) cleanup.
> 
> -scott
> 
> 

This is in a while loop with the pdev in the from* position. The dereference is
done automattically.

Thanks.

Hanna

