Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUINCFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUINCFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbUINCE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:04:28 -0400
Received: from are.twiddle.net ([64.81.246.98]:62081 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S269106AbUINCCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:02:41 -0400
Date: Mon, 13 Sep 2004 19:02:22 -0700
From: Richard Henderson <rth@twiddle.net>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Hanna Linder <hannal@us.ibm.com>, ink@jurassic.park.msu.ru,
       linux-kernel@vger.kernel.org, greg@kroah.com, wli@holomorphy.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to pci_get_device
Message-ID: <20040914020222.GB23058@twiddle.net>
Mail-Followup-To: Tonnerre <tonnerre@thundrix.ch>,
	Hanna Linder <hannal@us.ibm.com>, ink@jurassic.park.msu.ru,
	linux-kernel@vger.kernel.org, greg@kroah.com, wli@holomorphy.com
References: <806430000.1095118643@w-hlinder.beaverton.ibm.com> <20040914002933.GA20390@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914002933.GA20390@thundrix.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 02:29:33AM +0200, Tonnerre wrote:
> > -	while ((dev = pci_find_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
> > +	while ((dev = pci_get_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
> >                  if (dev->device == PCI_DEVICE_ID_NCR_53C810
> >  		    || dev->device == PCI_DEVICE_ID_NCR_53C815
> >  		    || dev->device == PCI_DEVICE_ID_NCR_53C820
> 
> Don't we need to put these devices in some place?

pci_get_device does that for non-null "from" argument.


r~
