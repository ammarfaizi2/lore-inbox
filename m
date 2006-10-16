Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWJPQSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWJPQSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWJPQSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:18:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8845 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422715AbWJPQSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:18:31 -0400
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061016160759.GA14354@muc.de>
References: <1161013892.24237.100.camel@localhost.localdomain>
	 <20061016160759.GA14354@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 17:45:13 +0100
Message-Id: <1161017113.24237.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 18:07 +0200, ysgrifennodd Andi Kleen:
> > --- linux.vanilla-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 15:10:06.000000000 +0100
> > +++ linux-2.6.19-rc1-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-13 17:14:40.000000000 +0100
> > @@ -879,7 +879,7 @@
> >  
> >  error:
> >  	do {
> > -		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
> > +		dev = pci_get_device_reverse(PCI_VENDOR_ID_IBM,
> >  					      PCI_DEVICE_ID_IBM_CALGARY,
> >  					      dev);
> 
> No put call anywhere?

You can't hot unplug your MMU

