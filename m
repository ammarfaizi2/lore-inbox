Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbTG1PXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbTG1PXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:23:09 -0400
Received: from lidskialf.net ([62.3.233.115]:37594 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270022AbTG1PXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:23:05 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Alexander Rau <al.rau@gmx.de>
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2 -- linux-2.5.75-acpi-irqparams-final4.patch
Date: Mon, 28 Jul 2003 16:38:24 +0100
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200307272305.12412.adq_dvb@lidskialf.net> <3F25419B.2050607@gmx.de>
In-Reply-To: <3F25419B.2050607@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307281638.24474.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 16:30, Alexander Rau wrote:
> Andrew de Quincey wrote:
> > This is version final4 of the patch now. Improvement over version final3
> > is a fix to IRQ allocation.. previously all PCI IRQs were allocated to
> > IRQ11 on my Thinkpad.
> >
> > This _may_ break ACPI IRQ routing on the Toshiba 5005-S504  (I hope I
> > have managed to support it though). Can someone check please? Quote from
> > pci_link.c:
> >          * Note that we don't validate that the current IRQ (_CRS) exists
> >          * within the possible IRQs (_PRS): we blindly assume that
> > whatever * IRQ a boot-enabled Link device is set to is the correct one. *
> > (Required to support systems such as the Toshiba 5005-S504.)
>
> I tried to apply the patch to 2.6.0-test2 in hope that this resolves my
> oops during boottime on my thinkpad t40p.
>
> Unfortunatly the compilation of the kernel fails with:
>
> ---------------------------------------------------------------------------
>-- CC      drivers/acpi/pci_link.o
> drivers/acpi/pci_link.c: In function `acpi_pci_link_allocate':
> drivers/acpi/pci_link.c:451: `_dbg' undeclared (first use in this function)
> drivers/acpi/pci_link.c:451: (Each undeclared identifier is reported
> only once
> drivers/acpi/pci_link.c:451: for each function it appears in.)
> make[2]: *** [drivers/acpi/pci_link.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
> ---------------------------------------------------------------------------
>--
>
> Any ideas how to port your patch to the 2.6 series ?

Weird! I compiled it on 2.6.0-test2 last night (for a thinkpad T20), and it 
was fine..... (and the thinkpad works fine too)

Send me your .config file so I can fix the patch, please.


