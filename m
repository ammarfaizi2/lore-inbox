Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUJLQkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUJLQkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJLQkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:40:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7670 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266204AbUJLQjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:39:10 -0400
Date: Tue, 12 Oct 2004 09:39:13 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: sfeldma@pobox.com
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][10/12] prep_pci.c replace	pci_find_device with pci_get_device
Message-ID: <136720000.1097599153@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1097341535.3903.6.camel@sfeldma-mobl2.dsl-verizon.net>
References: <35460000.1097192417@w-hlinder.beaverton.ibm.com> <1097341535.3903.6.camel@sfeldma-mobl2.dsl-verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 09, 2004 10:05:35 AM -0700 Scott Feldman <sfeldma@pobox.com> wrote:

> On Thu, 2004-10-07 at 16:40, Hanna Linder wrote:
>> @@ -1102,7 +1102,7 @@ prep_pib_init(void)
>>  		}
>>  	}
>>  
>> -	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
>> +	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
>>  				   PCI_DEVICE_ID_WINBOND_82C105, dev))){
>>  		if (OpenPIC_Addr){
>>  			/*
> 
> Missing pci_dev_put(dev) cleanup?
> 
> -scott
> 
> 

Hi Scott,

It doesnt need an explicit dev_put because the pci_dev * is used as the *from pointer
in the pci_get_device call which will do the dev_put automaticaly.

Hanna

