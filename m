Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUJLQik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUJLQik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUJLQik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:38:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:46994 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266169AbUJLQig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:38:36 -0400
Date: Tue, 12 Oct 2004 09:38:52 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: sfeldma@pobox.com
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][9/12] pplus.c replace	pci_find_device with pci_get_device
Message-ID: <136400000.1097599132@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1097341320.3903.3.camel@sfeldma-mobl2.dsl-verizon.net>
References: <33930000.1097191565@w-hlinder.beaverton.ibm.com> <1097341320.3903.3.camel@sfeldma-mobl2.dsl-verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 09, 2004 10:02:01 AM -0700 Scott Feldman <sfeldma@pobox.com> wrote:

> On Thu, 2004-10-07 at 16:26, Hanna Linder wrote:
>> -	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
>> +	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
>>  				   PCI_DEVICE_ID_WINBOND_82C105, dev))) {
>>  		/*
>>  		 * Disable LEGIRQ mode so PCI INTS are routed
> 
> Missing cleanup at the bottom of func?
> 
> 	if(dev)
> 		pci_dev_put(dev);
> 
> -scott

Hi Scott,

It doesnt need an explicit dev_put because the pci_dev * is used as the *from pointer
in the pci_get_device call which will do the dev_put automaticaly.

Hanna

