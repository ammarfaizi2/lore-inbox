Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSIEXkV>; Thu, 5 Sep 2002 19:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSIEXkV>; Thu, 5 Sep 2002 19:40:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7335 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318242AbSIEXkU>;
	Thu, 5 Sep 2002 19:40:20 -0400
Message-Id: <200209052343.g85Nhbh05323@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mannthey@us.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: 2.4.20pre5 not booting on numa-q with CONFIG_MULTIQUAD 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "06 Sep 2002 00:11:10 BST." <1031267470.7834.12.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Sep 2002 16:43:37 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tested with the patch and the box boots. :-) So, can we get this applied to 
the 2.4 tree?

Great find, Keith.

Thanks, 
Pat

  > On Thu, 2002-09-05 at 23:44, mannthey@us.ibm.com wrote:
  > > diff -urN linux-2.4.19/drivers/pci/pci.c linux-2.4.20-pre5/drivers/pci/pc
  > i.c
  > > --- linux-2.4.20-pre5/drivers/pci/pci.c      Sat Sep  7 06:29:04 2002
  > > +++ linux-2.4.20-pre5-test/drivers/pci/pci.c Sat Sep  7 06:10:26 2002
  > > @@ -586,7 +586,7 @@
  > >                 i + 1, /* PCI BAR # */
  > >                 pci_resource_len(pdev, i), pci_resource_start(pdev, i),
  > >                 pdev->slot_name);
  > > -       while(--i <= 0)
  > > +       while(--i >= 0)
  > >                 pci_release_region(pdev, i);
  > > 
  > >         return -EBUSY;
  > 


